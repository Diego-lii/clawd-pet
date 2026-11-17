import Cocoa
import QuartzCore
import CoreServices
import IOKit.ps

// MARK: - Colors
let orange = NSColor(srgbRed: 0.851, green: 0.467, blue: 0.341, alpha: 1)
let ink    = NSColor(srgbRed: 0.10, green: 0.09, blue: 0.09, alpha: 1)
let cream  = NSColor(srgbRed: 0.99, green: 0.97, blue: 0.93, alpha: 1)
let spark  = NSColor(srgbRed: 1.00, green: 0.80, blue: 0.30, alpha: 1)
let zGray  = NSColor(srgbRed: 0.55, green: 0.58, blue: 0.62, alpha: 1)


// MARK: - Language (English by default, Spanish when the Mac is set to Spanish)
let spanish = Locale.preferredLanguages.first?.hasPrefix("es") ?? false
let spanishText: [String: String] = [
    "Hi! 👋": "¡Hola! 👋",
    "I'm here if you need me": "Estoy aquí si me necesitas",
    "What are we doing today?": "¿Qué estamos haciendo hoy?",
    "Hmm, interesting...": "Hmm, interesante...",
    "Don't forget to drink water 💧": "No olvides tomar agua 💧",
    "Let's go!": "¡Vamos con todo!",
    "Did you commit yet?": "¿Ya hiciste commit?",
    "I like this spot": "Me gusta este rincón",
    "Break time? Stretch a bit": "¿Un descanso? Estira un poco",
    "Nice work!": "¡Buen trabajo!",
    "Today is going to be a good day": "Hoy va a ser un buen día",
    "Take me somewhere else?": "¿Me llevas a otro lado?",
    "Hey!": "¡Ey!",
    "Haha!": "¡Jaja!",
    "Yes?": "¿Sí?",
    "Here I am!": "¡Aquí estoy!",
    "Wheee!": "¡Wii!",
    "Again!": "¡Otra vez!",
    "Still up? 🌙": "¿Aún despierto? 🌙",
    "Good morning! ☀️": "¡Buenos días! ☀️",
    "Good afternoon!": "¡Buenas tardes!",
    "Good evening! 🌙": "¡Buenas noches! 🌙",
    "Yes!": "¡Sí!",
    "We did it!": "¡Lo logramos!",
    "Hi, Claude! 👋": "¡Hola, Claude! 👋",
    "My team!": "¡Mi equipo!",
    "Let's get to work!": "¡Vamos a trabajar!",
    "Coding time? 👀": "¿A programar? 👀",
    "Code mode!": "¡Modo código!",
    "Browsing?": "¿Navegando?",
    "Don't get distracted 😄": "No te distraigas 😄",
    "What are we looking for?": "¿Qué buscamos?",
    "Messages?": "¿Mensajes?",
    "Say hi for me": "Saluda de mi parte",
    "Looking for something?": "¿Buscando algo?",
    "Huh?! You're back!": "¡¿Eh?! ¡Ya volviste!",
    "Claude is working…": "Claude está trabajando…",
    "Let's do this!": "¡Manos a la obra!",
    "Typing…": "Tecleando…",
    "Done! ✦": "¡Listo! ✦",
    "Whoa!": "¡Uy!",
    "Nice view!": "¡Buena vista!",
    "I can see everything from here": "Desde aquí se ve todo",
    "Hop!": "¡Hop!",
    "Compiling…": "Compilando…",
    "Reading code…": "Leyendo código…",
    "Thinking…": "Pensando…",
    "What a nice spot!": "¡Qué buen sitio!",
    "Here?": "¿Aquí?",
    "Huh? I'm awake!": "¿Eh? ¡Ya desperté!",
    "Party!": "¡Fiesta!",
    "Wave": "Saluda",
    "Say something": "Di algo",
    "Go to a window": "Ve a una ventana",
    "Celebrate": "Celebra",
    "Sleep / wake up": "Duerme / despierta",
    "Come to the center": "Ven al centro",
    "Quit Clawd": "Cerrar mascota",
    "Awake!": "¡Despierto!",
    "Hi!": "¡Hola!",
    "Hi! I'm Clawd": "¡Hola! Soy Clawd",
    "Low battery!": "¡Batería baja!",
]
func tr(_ text: String) -> String { spanish ? (spanishText[text] ?? text) : text }

func clamp<T: Comparable>(_ v: T, _ lo: T, _ hi: T) -> T { min(max(v, lo), hi) }

let phrases = [
    "Hi! 👋", "I'm here if you need me", "What are we doing today?",
    "Hmm, interesting...", "Don't forget to drink water 💧", "Let's go!",
    "Did you commit yet?", "I like this spot", "Break time? Stretch a bit",
    "Nice work!", "Today is going to be a good day", "beep boop", "Take me somewhere else?",
]
let clickPhrases = ["Hey!", "Haha!", "Yes?", "Here I am!", "Wheee!", "Again!"]

enum Mode { case idle, walk, run, sleep, wave, cheer, think, happy, dizzy, drag, work, startled, dance }
enum EyeStyle { case open, closed, wink, happy, dizzy }

// MARK: - Drawing Clawd
//
// Clawd is an 11 x 8 pixel grid:
//
//   .XXXXXXXXX.
//   .XXXXXXXXX.
//   XX.XXXXX.XX   <- eyes and arms
//   XXXXXXXXXXX
//   .XXXXXXXXX.
//   .XXXXXXXXX.
//   .X.X...X.X.   <- legs
//   .X.X...X.X.
final class PetView: NSView {
    weak var pet: Pet?
    static let w: CGFloat = 200
    static let h: CGFloat = 140
    static let u: CGFloat = 6                 // size of one pixel (change it to make Clawd bigger or smaller)
    static let cols: CGFloat = 11, rows: CGFloat = 8
    var ox: CGFloat { (PetView.w - PetView.cols * PetView.u) / 2 }
    let oy: CGFloat = 8

    var mode: Mode = .idle
    var time: CGFloat = 0
    var facing: CGFloat = 1
    var walking = false
    var hop: CGFloat = 0
    var hopVel: CGFloat = 0
    var squash: CGFloat = 1
    var turn: CGFloat = 0            // turn progress (0 = not turning)
    var turnFlipped = false
    var blink: CGFloat = 0
    var blinkTimer: CGFloat = 2
    var eyeStyle: EyeStyle = .open
    var eyeDX = 0, eyeDY = 0         // where the eyes look
    var armL = 0, armR = 0           // arms: 0 down, 1 up
    var sparkleT: CGFloat = 0
    var speech: String?
    var speechTime: CGFloat = 0
    var sleepT: CGFloat = 0

    var spriteCenterX: CGFloat { ox + PetView.cols * PetView.u / 2 }
    var spriteTop: CGFloat { oy + PetView.rows * PetView.u + hop }
    // Clickable area.
    var hitRect: NSRect {
        NSRect(x: ox, y: oy, width: PetView.cols * PetView.u, height: PetView.rows * PetView.u + hop + PetView.u)
    }

    // Rectangle of one grid pixel.
    func cell(_ x: CGFloat, _ y: CGFloat, _ w: CGFloat = 1, _ h: CGFloat = 1) -> NSRect {
        let u = PetView.u
        return NSRect(x: ox + x * u, y: oy + (PetView.rows - y - h) * u + hop, width: w * u, height: h * u)
    }
    func fill(_ r: NSRect, _ c: NSColor) { c.setFill(); r.fill() }

    override func draw(_ dirtyRect: NSRect) {
        guard let ctx = NSGraphicsContext.current?.cgContext else { return }
        let u = PetView.u
        ctx.saveGState()
        // squash on landing, narrow while turning
        let sleeping = mode == .sleep
        let turnScale = turn > 0 ? max(0.12, 1 - 0.95 * sin(turn * .pi)) : 1
        let sy = sleeping ? 0.7 : squash
        let sx = (sleeping ? 1.15 : (2 - squash)) * turnScale
        ctx.translateBy(x: spriteCenterX, y: oy)
        ctx.scaleBy(x: sx, y: sy)
        ctx.translateBy(x: -spriteCenterX, y: -oy)
        if mode == .run { ctx.translateBy(x: 0, y: abs(sin(time * 14)) * 3) }
        if mode == .dance {
            // sway to the beat
            ctx.translateBy(x: spriteCenterX, y: oy + PetView.rows * PetView.u / 2)
            ctx.rotate(by: sin(time * 7) * 0.12)
            ctx.translateBy(x: -spriteCenterX, y: -(oy + PetView.rows * PetView.u / 2))
        }

        // body
        fill(cell(1, 0, 9, 6), orange)
        // arms
        fill(cell(0, CGFloat(2 - armL), 1, 2), orange)
        fill(cell(10, CGFloat(2 - armR), 1, 2), orange)
        // legs
        if !sleeping {
            let phase = walking ? Int(time * (mode == .run ? 16 : 9)) % 4 : 0
            let showLeft = phase != 3, showRight = phase != 1
            if showLeft { fill(cell(1, 6, 1, 2), orange); fill(cell(3, 6, 1, 2), orange) }
            if showRight { fill(cell(7, 6, 1, 2), orange); fill(cell(9, 6, 1, 2), orange) }
        }
        // eyes (hidden while turning)
        if turnScale > 0.45 { drawEyes() }
        ctx.restoreGState()

        if sparkleT > 0 { drawSparkles() }
        if sleeping { drawZs() }
        if let t = speech { drawBubble(t, topY: spriteTop + (armL + armR > 0 ? u : 0) + 6, tailX: spriteCenterX) }
    }

    func drawEyes() {
        let u = PetView.u
        var style = eyeStyle
        if mode == .sleep { style = .closed }
        else if style == .open && blink > 0.5 { style = .closed }
        let ex = CGFloat(eyeDX), ey = CGFloat(eyeDY)
        for (i, bx) in [CGFloat(2), CGFloat(8)].enumerated() {
            let r = cell(bx + ex, 2 + ey)
            var s = style
            if style == .wink { s = i == 0 ? .open : .closed }
            switch s {
            case .open:
                fill(r, ink)
            case .closed, .wink:
                fill(NSRect(x: r.minX, y: r.minY, width: u, height: u * 0.35), ink)
            case .happy:
                let p = NSBezierPath()
                let cx = r.midX, cy = r.midY, hw = u * 0.7, hh = u * 0.75
                let dir: CGFloat = i == 0 ? 1 : -1
                p.move(to: CGPoint(x: cx - dir * hw, y: cy + hh))
                p.line(to: CGPoint(x: cx + dir * hw, y: cy))
                p.line(to: CGPoint(x: cx - dir * hw, y: cy - hh))
                p.lineWidth = u * 0.42; p.lineJoinStyle = .miter; p.lineCapStyle = .butt
                ink.setStroke(); p.stroke()
            case .dizzy:
                let p = NSBezierPath()
                let cx = r.midX, cy = r.midY, k = u * 0.7
                p.move(to: CGPoint(x: cx - k, y: cy - k)); p.line(to: CGPoint(x: cx + k, y: cy + k))
                p.move(to: CGPoint(x: cx - k, y: cy + k)); p.line(to: CGPoint(x: cx + k, y: cy - k))
                p.lineWidth = u * 0.38; p.lineCapStyle = .butt
                ink.setStroke(); p.stroke()
            }
        }
    }

    func drawSparkles() {
        let u = PetView.u
        spark.withAlphaComponent(min(1, sparkleT)).setFill()
        for i in 0..<4 {
            let a = time * 2.5 + CGFloat(i) * .pi / 2
            let rx = PetView.cols * u * 0.75, ry = PetView.rows * u * 0.6
            let x = spriteCenterX + cos(a) * rx
            let y = oy + PetView.rows * u * 0.55 + hop + sin(a) * ry
            let s = u * (0.6 + 0.3 * abs(sin(time * 6 + CGFloat(i))))
            NSRect(x: x - s / 2, y: y - s * 1.5, width: s, height: s * 3).fill()
            NSRect(x: x - s * 1.5, y: y - s / 2, width: s * 3, height: s).fill()
        }
    }

    func drawZs() {
        let u = PetView.u
        for i in 0..<3 {
            let ph = (sleepT * 0.5 + CGFloat(i) * 0.33).truncatingRemainder(dividingBy: 1)
            let attrs: [NSAttributedString.Key: Any] = [
                .font: NSFont.monospacedSystemFont(ofSize: 7 + ph * 8, weight: .bold),
                .foregroundColor: zGray.withAlphaComponent(1 - ph)]
            NSAttributedString(string: "z", attributes: attrs)
                .draw(at: CGPoint(x: spriteCenterX + 3 * u + ph * 14, y: oy + 5 * u + ph * 30))
        }
    }

    func drawBubble(_ text: String, topY: CGFloat, tailX cx: CGFloat) {
        let para = NSMutableParagraphStyle(); para.alignment = .center
        let attrs: [NSAttributedString.Key: Any] = [
            .font: NSFont.systemFont(ofSize: 11, weight: .medium), .foregroundColor: ink, .paragraphStyle: para]
        let str = NSAttributedString(string: text, attributes: attrs)
        var size = str.boundingRect(with: NSSize(width: 150, height: 200),
                                    options: [.usesLineFragmentOrigin, .usesFontLeading]).size
        size.width = ceil(size.width) + 2; size.height = ceil(size.height)
        let pad: CGFloat = 7
        let bw = size.width + pad * 2, bh = size.height + pad * 2
        let bx = clamp(cx - bw / 2, 4, PetView.w - bw - 4)
        let by = topY
        let path = NSBezierPath(roundedRect: NSRect(x: bx, y: by, width: bw, height: bh), xRadius: 4, yRadius: 4)
        path.move(to: CGPoint(x: cx - 5, y: by + 1)); path.line(to: CGPoint(x: cx, y: by - 6)); path.line(to: CGPoint(x: cx + 5, y: by + 1))
        cream.setFill(); path.fill()
        ink.setStroke(); path.lineWidth = 1.2; path.stroke()
        let patch = NSBezierPath()
        patch.move(to: CGPoint(x: cx - 4, y: by + 2)); patch.line(to: CGPoint(x: cx, y: by - 4)); patch.line(to: CGPoint(x: cx + 4, y: by + 2)); patch.close()
        cream.setFill(); patch.fill()
        str.draw(with: NSRect(x: bx + pad, y: by + pad, width: size.width, height: size.height),
                 options: [.usesLineFragmentOrigin, .usesFontLeading])
    }

    override func mouseDown(with event: NSEvent) { pet?.mouseDown(at: NSEvent.mouseLocation) }
    override func mouseDragged(with event: NSEvent) { pet?.mouseDragged(to: NSEvent.mouseLocation) }
    override func mouseUp(with event: NSEvent) { pet?.mouseUp(clicks: event.clickCount) }
    override func rightMouseDown(with event: NSEvent) {
        guard let menu = pet?.makeMenu() else { return }
        NSMenu.popUpContextMenu(menu, with: event, for: self)
    }
}

// MARK: - Open windows (Clawd can walk on top of them)
struct Platform {
    let rect: NSRect
    let owner: String
    var top: CGFloat { rect.maxY }
}

func visiblePlatforms(excluding myWindow: Int) -> [Platform] {
    guard let list = CGWindowListCopyWindowInfo([.optionOnScreenOnly, .excludeDesktopElements], kCGNullWindowID) as? [[String: Any]] else { return [] }
    let primaryH = NSScreen.screens.first?.frame.height ?? 0
    var out: [Platform] = []
    for w in list {
        guard (w[kCGWindowLayer as String] as? Int) == 0,
              (w[kCGWindowNumber as String] as? Int) != myWindow,
              ((w[kCGWindowAlpha as String] as? Double) ?? 1) > 0.2,
              let b = w[kCGWindowBounds as String] as? [String: CGFloat],
              let x = b["X"], let y = b["Y"], let wd = b["Width"], let ht = b["Height"],
              wd >= 160, ht >= 90 else { continue }
        let owner = (w[kCGWindowOwnerName as String] as? String) ?? ""
        if owner == "Dock" || owner == "Window Server" || owner == "Notification Center" || owner == "Control Center" { continue }
        // convert to screen coordinates
        out.append(Platform(rect: NSRect(x: x, y: primaryH - y - ht, width: wd, height: ht), owner: owner))
    }
    return out
}

// MARK: - The pet's brain
final class Pet: NSObject {
    let window: NSWindow
    let view = PetView(frame: NSRect(x: 0, y: 0, width: PetView.w, height: PetView.h))
    var pos: CGPoint = .zero           // position on screen
    var modeTime: CGFloat = 3
    var lastT = CACurrentMediaTime()
    var timer: Timer?
    var statusItem: NSStatusItem?

    // movement
    var airborne = false               // falling
    var vy: CGFloat = 0
    let gravity: CGFloat = 1500
    var walkTarget: CGPoint = .zero    // where it is going
    var standing = false               // standing on something
    var platforms: [Platform] = []
    var platformTimer: CGFloat = 0
    var standingOn: String = ""

    // mouse
    var dragStart: CGPoint?
    var dragOrigin: CGPoint?
    var dragging = false
    var lastMouse = NSEvent.mouseLocation
    var startleCooldown: CGFloat = 0

    // environment
    var idleSleeping = false
    var batteryTimer: CGFloat = 5
    var batteryWarned = false
    var appCommentCooldown: CGFloat = 8
    var fsStream: FSEventStreamRef?
    var claudeActiveUntil: TimeInterval = 0
    var claudeWorkStart: TimeInterval = 0
    var claudeAnnounced = false
    var musicPlaying = false
    var musicTrack = ""
    var musicTimer: CGFloat = 2
    var musicQuerying = false

    var spriteW: CGFloat { PetView.cols * PetView.u }
    var spriteH: CGFloat { PetView.rows * PetView.u }
    var feetY: CGFloat { pos.y + view.oy }
    var centerX: CGFloat { pos.x + view.spriteCenterX }

    var screen: NSScreen {
        let c = CGPoint(x: centerX, y: pos.y + 40)
        return NSScreen.screens.first { $0.frame.contains(c) } ?? NSScreen.main ?? NSScreen.screens[0]
    }
    var screenFloor: CGFloat { screen.visibleFrame.minY }
    var topLimit: CGFloat { screen.visibleFrame.maxY - spriteH - 12 }   // never above the menu bar
    // Valid positions that keep Clawd on screen.
    func originBounds(_ scr: NSScreen) -> NSRect {
        let f = scr.visibleFrame
        return NSRect(x: f.minX - view.ox, y: f.minY - view.oy, width: f.width - spriteW, height: f.height - spriteH - 12)
    }
    func clampToScreen() {
        let b = originBounds(screen)
        pos.x = clamp(pos.x, b.minX, b.maxX); pos.y = clamp(pos.y, b.minY, b.maxY)
    }

    override init() {
        window = NSWindow(contentRect: NSRect(x: 0, y: 0, width: PetView.w, height: PetView.h),
                          styleMask: [.borderless], backing: .buffered, defer: false)
        super.init()
        window.isOpaque = false
        window.backgroundColor = .clear
        window.hasShadow = false
        window.level = .floating
        window.collectionBehavior = [.canJoinAllSpaces, .stationary, .ignoresCycle, .fullScreenAuxiliary]
        window.isReleasedWhenClosed = false
        window.contentView = view
        view.pet = self

        let f = (NSScreen.main ?? NSScreen.screens[0]).visibleFrame
        pos = CGPoint(x: f.maxX - 200 - view.ox, y: f.minY - view.oy)
        place()
        window.orderFrontRegardless()

        let item = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        item.button?.title = "✦"
        item.menu = makeMenu()
        statusItem = item

        NotificationCenter.default.addObserver(self, selector: #selector(screensChanged),
                                               name: NSApplication.didChangeScreenParametersNotification, object: nil)
        NSWorkspace.shared.notificationCenter.addObserver(self, selector: #selector(appActivated(_:)),
                                                          name: NSWorkspace.didActivateApplicationNotification, object: nil)
        startClaudeWatcher()

        let t = Timer(timeInterval: 1.0 / 60.0, repeats: true) { [weak self] _ in self?.tick() }
        RunLoop.main.add(t, forMode: .common)
        timer = t
        platforms = visiblePlatforms(excluding: window.windowNumber)
        startWave(greeting())
    }

    func place() { window.setFrameOrigin(CGPoint(x: round(pos.x), y: round(pos.y))) }

    @objc func screensChanged() { clampToScreen(); place() }

    func say(_ text: String, for secs: CGFloat) { view.speech = tr(text); view.speechTime = secs }

    func greeting() -> String {
        let h = Calendar.current.component(.hour, from: Date())
        if h < 6 { return "Still up? 🌙" }
        if h < 12 { return "Good morning! ☀️" }
        if h < 20 { return "Good afternoon!" }
        return "Good evening! 🌙"
    }
    var isNight: Bool { let h = Calendar.current.component(.hour, from: Date()); return h >= 23 || h < 7 }

    // MARK: Floor
    // What is under a point: a window or the screen bottom.
    func floorUnder(x: CGFloat, maxY: CGFloat) -> (y: CGFloat, owner: String) {
        var best = screenFloor, owner = "floor"
        let limit = topLimit
        for (i, p) in platforms.enumerated() {
            guard p.rect.minX <= x, x <= p.rect.maxX, p.top <= maxY, p.top > best, p.top <= limit else { continue }
            let probe = CGPoint(x: x, y: p.top - 2)
            var covered = false
            for j in 0..<i where platforms[j].rect.contains(probe) { covered = true; break }
            if !covered { best = p.top; owner = p.owner }
        }
        return (best, owner)
    }
    // How far it can walk without falling off.
    func walkableRange(aroundX x: CGFloat) -> ClosedRange<CGFloat> {
        let y = feetY
        var lo = x, hi = x
        let step: CGFloat = 8
        while lo - step > screen.visibleFrame.minX && abs(floorUnder(x: lo - step, maxY: y + 4).y - y) < 3 { lo -= step }
        while hi + step < screen.visibleFrame.maxX && abs(floorUnder(x: hi + step, maxY: y + 4).y - y) < 3 { hi += step }
        return lo...hi
    }

    // MARK: States
    func enter(_ m: Mode, for secs: CGFloat) {
        let v = view
        v.mode = m; modeTime = secs
        v.walking = false; v.armL = 0; v.armR = 0; v.eyeStyle = .open
        switch m {
        case .sleep: v.sleepT = 0; v.speech = nil
        case .cheer: v.armL = 1; v.armR = 1; v.sparkleT = secs
        case .happy: v.eyeStyle = .happy; v.sparkleT = secs
        case .dizzy: v.eyeStyle = .dizzy
        case .think: say("...", for: secs)
        case .startled: v.hopVel = 170
        case .dance: v.eyeStyle = .happy
        default: break
        }
    }
    func startWave(_ text: String?) {
        enter(.wave, for: 2.2)
        if let t = text { say(t, for: 2.8) }
    }
    func startWalk(to target: CGPoint, run: Bool = false) {
        walkTarget = target
        enter(run ? .run : .walk, for: 30)
    }
    func startWalk(toX x: CGFloat, run: Bool = false) {
        startWalk(to: CGPoint(x: x - view.spriteCenterX, y: pos.y), run: run)
    }

    func pickBehavior() {
        if airborne { return }
        let r = Double.random(in: 0..<1)
        let sleepBias = isNight ? 0.12 : 0.0
        let onPlatform = standing && standingOn != "floor"
        if musicPlaying && r < 0.3 { enter(.dance, for: CGFloat.random(in: 5...9)); return }
        switch r {
        case ..<0.20: enter(.idle, for: CGFloat.random(in: 2...5))
        case ..<0.42:
            // go to a random point
            let b = originBounds(screen)
            startWalk(to: CGPoint(x: CGFloat.random(in: b.minX...max(b.minX, b.maxX)),
                                  y: CGFloat.random(in: b.minY...max(b.minY, b.maxY))))
        case ..<0.58: goToWindow()
        case ..<0.68 where onPlatform:
            // walk along the window it is standing on
            let range = walkableRange(aroundX: centerX)
            startWalk(toX: CGFloat.random(in: range))
        case ..<0.74: startWave(Bool.random() ? "Hi!" : nil)
        case ..<0.79: enter(.cheer, for: 2.5); say(["Yes!", "We did it!", "✦"].randomElement()!, for: 2)
        case ..<0.85: enter(.think, for: 3)
        case ..<(0.91 + sleepBias): enter(.sleep, for: CGFloat.random(in: 10...25))
        default: enter(.idle, for: 4); say(phrases.randomElement()!, for: 3.5)
        }
    }

    // Run to the top edge of a window.
    func goToWindow() {
        var spots: [(x: CGFloat, y: CGFloat)] = []
        let f = screen.visibleFrame
        for p in platforms where p.top <= topLimit && p.top >= f.minY && !(standing && standingOn == p.owner) {
            let lo = max(p.rect.minX, f.minX) + 20, hi = min(p.rect.maxX, f.maxX) - 20
            guard hi > lo else { continue }
            for _ in 0..<4 {
                let x = CGFloat.random(in: lo...hi)
                if floorUnder(x: x, maxY: p.top + 1).y == p.top { spots.append((x, p.top)); break }
            }
        }
        if spots.isEmpty {
            if standingOn == "floor" && standing { enter(.idle, for: 2); return }
            spots.append((CGFloat.random(in: (f.minX + 40)...(f.maxX - 40)), screenFloor))
        }
        let sp = spots.randomElement()!
        startWalk(to: CGPoint(x: sp.x - view.spriteCenterX, y: sp.y - view.oy), run: true)
    }

    // MARK: Environment reactions
    func startClaudeWatcher() {
        let path = (NSHomeDirectory() as NSString).appendingPathComponent(".claude/projects")
        guard FileManager.default.fileExists(atPath: path) else { return }
        var ctx = FSEventStreamContext(version: 0, info: Unmanaged.passUnretained(self).toOpaque(), retain: nil, release: nil, copyDescription: nil)
        let cb: FSEventStreamCallback = { _, info, n, paths, _, _ in
            guard let info = info else { return }
            let pet = Unmanaged<Pet>.fromOpaque(info).takeUnretainedValue()
            let arr = unsafeBitCast(paths, to: NSArray.self)
            for i in 0..<n { if let p = arr[i] as? String, p.hasSuffix(".jsonl") { pet.claudeActivity(); break } }
        }
        guard let st = FSEventStreamCreate(nil, cb, &ctx, [path] as CFArray,
                                           FSEventStreamEventId(kFSEventStreamEventIdSinceNow), 0.6,
                                           FSEventStreamCreateFlags(kFSEventStreamCreateFlagFileEvents | kFSEventStreamCreateFlagUseCFTypes)) else { return }
        FSEventStreamSetDispatchQueue(st, DispatchQueue.main)
        FSEventStreamStart(st)
        fsStream = st
    }
    func claudeActivity() {
        let now = Date().timeIntervalSince1970
        if claudeActiveUntil < now { claudeWorkStart = now; claudeAnnounced = false }
        claudeActiveUntil = now + 7
    }
    var claudeActive: Bool { claudeActiveUntil > Date().timeIntervalSince1970 }

    func batteryState() -> (percent: Int, charging: Bool)? {
        guard let snap = IOPSCopyPowerSourcesInfo()?.takeRetainedValue(),
              let list = IOPSCopyPowerSourcesList(snap)?.takeRetainedValue() as? [CFTypeRef] else { return nil }
        for ps in list {
            if let d = IOPSGetPowerSourceDescription(snap, ps)?.takeUnretainedValue() as? [String: Any],
               let cap = d[kIOPSCurrentCapacityKey] as? Int {
                return (cap, (d[kIOPSIsChargingKey] as? Bool) ?? false)
            }
        }
        return nil
    }

    // Asks Apple Music and Spotify (only if they are open) whether a song is playing.
    func checkMusic() {
        guard !musicQuerying else { return }
        let running = Set(NSWorkspace.shared.runningApplications.compactMap { $0.bundleIdentifier })
        let players = ["com.apple.Music", "com.spotify.client"].filter { running.contains($0) }
        if players.isEmpty { musicResult(""); return }
        musicQuerying = true
        let source = players.map { id in """
            try
                tell application id "\(id)"
                    if player state is playing then return (name of current track) & " — " & (artist of current track)
                end tell
            end try
            """ }.joined(separator: "\n") + "\nreturn \"\""
        DispatchQueue.global(qos: .utility).async { [weak self] in
            var error: NSDictionary?
            let out = NSAppleScript(source: source)?.executeAndReturnError(&error).stringValue ?? ""
            DispatchQueue.main.async { self?.musicQuerying = false; self?.musicResult(out) }
        }
    }
    func musicResult(_ track: String) {
        let playing = !track.isEmpty
        let changed = playing && track != musicTrack
        musicPlaying = playing
        musicTrack = track
        let v = view
        let busy = dragging || airborne || v.mode == .sleep || v.mode == .drag || v.mode == .work || v.mode == .startled
        if changed && !busy {
            enter(.dance, for: 8)
            say("♪ " + track, for: 4)
        } else if !playing && v.mode == .dance {
            enter(.idle, for: 2)
        }
    }

    func userIdleSeconds() -> Double {
        let types: [CGEventType] = [.mouseMoved, .leftMouseDown, .rightMouseDown, .keyDown, .scrollWheel, .leftMouseDragged]
        return types.map { CGEventSource.secondsSinceLastEventType(.combinedSessionState, eventType: $0) }.min() ?? 0
    }

    @objc func appActivated(_ n: Notification) {
        guard appCommentCooldown <= 0, !dragging, view.mode != .sleep,
              let app = n.userInfo?[NSWorkspace.applicationUserInfoKey] as? NSRunningApplication,
              app.processIdentifier != ProcessInfo.processInfo.processIdentifier,
              let name = app.localizedName else { return }
        let bid = app.bundleIdentifier ?? ""
        var line: String? = nil
        switch true {
        case name == "Claude" || bid.contains("anthropic"): line = ["Hi, Claude! 👋", "My team!", "Let's get to work!"].randomElement()
        case ["Xcode", "Code", "Visual Studio Code", "Cursor", "Terminal", "iTerm2", "Warp", "Zed"].contains(name):
            line = ["Coding time? 👀", "Code mode!", "Did you commit yet?"].randomElement()
        case ["Spotify", "Music", "Música"].contains(name): line = "♪ ♫"
        case ["Safari", "Google Chrome", "Arc", "Firefox", "Brave Browser"].contains(name):
            line = ["Browsing?", "Don't get distracted 😄", "What are we looking for?"].randomElement()
        case ["Slack", "Discord", "Messages", "Mensajes", "WhatsApp", "Telegram"].contains(name):
            line = ["Messages?", "Say hi for me"].randomElement()
        case name == "Finder": line = "Looking for something?"
        case ["Mail", "Correo"].contains(name): line = "📬"
        default: return
        }
        guard let l = line, Double.random(in: 0..<1) < 0.6 else { return }
        appCommentCooldown = 25
        if !airborne && view.mode != .drag { enter(.idle, for: 3) }
        say(l, for: 2.8)
    }

    // MARK: Main loop (60 times per second)
    func tick() {
        let now = CACurrentMediaTime()
        let dt = min(CGFloat(now - lastT), 0.05)
        lastT = now
        let v = view
        v.time += dt

        // animations
        v.blinkTimer -= dt
        if v.blinkTimer <= 0 { v.blink = 1; v.blinkTimer = CGFloat.random(in: 2.5...6) }
        else if v.blink > 0 { v.blink = max(0, v.blink - dt * 7) }
        v.squash += (1 - v.squash) * min(1, dt * 10)
        if v.hop > 0 || v.hopVel > 0 {
            v.hopVel -= 900 * dt
            v.hop += v.hopVel * dt
            if v.hop <= 0 { v.hop = 0; v.hopVel = 0; v.squash = 0.82 }
        }
        if v.speech != nil { v.speechTime -= dt; if v.speechTime <= 0 { v.speech = nil } }
        if v.sparkleT > 0 { v.sparkleT -= dt }
        if v.turn > 0 {
            v.turn += dt / 0.4
            if !v.turnFlipped && v.turn >= 0.5 { v.facing = -v.facing; v.turnFlipped = true }
            if v.turn >= 1 { v.turn = 0 }
        }
        startleCooldown = max(0, startleCooldown - dt)
        appCommentCooldown = max(0, appCommentCooldown - dt)

        // check which windows are open
        platformTimer -= dt
        if platformTimer <= 0 { platforms = visiblePlatforms(excluding: window.windowNumber); platformTimer = 0.25 }

        // mouse
        let mouse = NSEvent.mouseLocation
        let cx = centerX, cy = pos.y + v.oy + spriteH / 2
        let dx = mouse.x - cx, dy = mouse.y - cy
        let mouseSpeed = hypot(mouse.x - lastMouse.x, mouse.y - lastMouse.y) / max(dt, 0.001)
        lastMouse = mouse
        if v.mode == .walk || v.mode == .run {
            v.eyeDX = Int(v.facing); v.eyeDY = 0
        } else if v.mode == .work {
            v.eyeDX = 0; v.eyeDY = 1
        } else if v.mode == .idle || v.mode == .think || v.mode == .wave {
            v.eyeDX = dx > 90 ? 1 : (dx < -90 ? -1 : 0)
            v.eyeDY = dy > 90 ? -1 : (dy < -90 ? 1 : 0)
        } else { v.eyeDX = 0; v.eyeDY = 0 }
        if !dragging && !airborne && startleCooldown == 0 && hypot(dx, dy) < 70 && mouseSpeed > 1800
            && v.mode != .sleep && v.mode != .drag {
            startleCooldown = 6
            enter(.startled, for: 0.6)
            say("!", for: 0.8)
            // run away from the cursor
            let len = max(hypot(dx, dy), 1)
            let b = originBounds(screen)
            walkTarget = CGPoint(x: clamp(pos.x - dx / len * 200, b.minX, b.maxX),
                                 y: clamp(pos.y - dy / len * 120, b.minY, b.maxY))
        }
        if !dragging {
            let over = v.hitRect.offsetBy(dx: pos.x, dy: pos.y).contains(mouse)
            if window.ignoresMouseEvents == over { window.ignoresMouseEvents = !over }
        }

        // falls asleep when you stop using the Mac
        let idle = userIdleSeconds()
        if !idleSleeping && idle > 150 && !dragging && !airborne && v.mode != .sleep {
            idleSleeping = true; enter(.sleep, for: 9999)
        } else if idleSleeping && idle < 1.5 {
            idleSleeping = false
            enter(.startled, for: 0.7); say("Huh?! You're back!", for: 2.5)
        }

        // music
        musicTimer -= dt
        if musicTimer <= 0 { musicTimer = 3; checkMusic() }

        // battery
        batteryTimer -= dt
        if batteryTimer <= 0 {
            batteryTimer = 60
            if let b = batteryState() {
                if b.percent <= 15 && !b.charging && !batteryWarned {
                    batteryWarned = true
                    if v.mode != .sleep { enter(.idle, for: 4) }
                    say(tr("Low battery!") + " 🔋 \(b.percent)%", for: 5)
                } else if b.charging || b.percent > 30 { batteryWarned = false }
            }
        }

        // Claude Code is working
        if claudeActive && !dragging && !airborne && v.mode != .sleep && v.mode != .drag && v.mode != .startled {
            if v.mode != .work {
                enter(.work, for: 9999)
                if !claudeAnnounced { claudeAnnounced = true; say(["Claude is working…", "Let's do this!", "Typing…"].randomElement()!, for: 3) }
            }
        } else if v.mode == .work && !claudeActive {
            let worked = Date().timeIntervalSince1970 - claudeWorkStart
            if worked > 12 { enter(.cheer, for: 2.5); say("Done! ✦", for: 2.5) } else { enter(.idle, for: 2) }
        }

        // if the window it was standing on disappears, it falls
        let floor = floorUnder(x: centerX, maxY: feetY + 4)
        if !airborne && v.mode != .drag {
            let onIt = abs(feetY - floor.y) <= 3
            if standing && !onIt && feetY > floor.y + 3 && v.mode != .walk && v.mode != .run && v.mode != .startled {
                airborne = true; vy = 0
                v.speech = nil; say("Whoa!", for: 1)
            } else if standing && !onIt && floor.y - feetY > 3 && floor.y - feetY < 80 {
                pos.y = floor.y - v.oy; place()               // the window moved up a little
            } else {
                standing = onIt
                if onIt { standingOn = floor.owner }
            }
        }
        if airborne && v.mode != .drag {
            vy -= gravity * dt
            pos.y += vy * dt
            if vy <= 0 && feetY <= floor.y {
                pos.y = floor.y - v.oy
                airborne = false
                let hard = vy < -900
                vy = 0
                v.squash = hard ? 0.65 : 0.8
                standing = true; standingOn = floor.owner
                if hard && Bool.random() { enter(.dizzy, for: 1.2) } else { enter(.idle, for: CGFloat.random(in: 1...3)) }
            }
            place()
        }

        // what it does in each state
        switch v.mode {
        case .walk, .run, .startled:
            guard !airborne else { break }
            let run = v.mode != .walk
            v.walking = true
            let d = CGPoint(x: walkTarget.x - pos.x, y: walkTarget.y - pos.y)
            let dist = hypot(d.x, d.y)
            if abs(d.x) > 2 {
                let want: CGFloat = d.x > 0 ? 1 : -1
                if want != v.facing && v.turn == 0 { v.turn = 0.001; v.turnFlipped = false }
            }
            let speed: CGFloat = v.turn > 0 ? 0 : (run ? 120 : 42)
            if dist < 2 || modeTime <= 0 {
                clampToScreen(); place()
                let fl = floorUnder(x: centerX, maxY: feetY + 4)
                standing = abs(feetY - fl.y) <= 3
                if standing { standingOn = fl.owner }
                if run && standing && standingOn != "floor" && Double.random(in: 0..<1) < 0.4 {
                    say(["Nice view!", "I can see everything from here", "Hop!"].randomElement()!, for: 2)
                }
                enter(.idle, for: CGFloat.random(in: 1.5...4))
            } else {
                let step = min(dist, speed * dt)
                pos.x += d.x / dist * step; pos.y += d.y / dist * step
                place()
            }
            modeTime -= dt
        case .dance:
            v.armL = Int(v.time * 3.5) % 2; v.armR = 1 - v.armL
            if v.hop == 0 && v.hopVel == 0 { v.hopVel = 110 }
            modeTime -= dt; if modeTime <= 0 { pickBehavior() }
        case .wave:
            v.armR = Int(v.time * 4) % 2
            modeTime -= dt; if modeTime <= 0 { pickBehavior() }
        case .work:
            v.armL = Int(v.time * 7) % 2; v.armR = 1 - v.armL
            if Int(v.time * 0.1) % 3 == 0 && v.speech == nil && Double.random(in: 0..<1) < 0.002 {
                say(["Compiling…", "Reading code…", "Thinking…", "tap tap tap"].randomElement()!, for: 2.5)
            }
        case .cheer, .happy:
            if v.hop == 0 && v.hopVel == 0 { v.hopVel = 150 }
            modeTime -= dt; if modeTime <= 0 { pickBehavior() }
        case .dizzy:
            v.armL = Int(v.time * 3) % 2; v.armR = 1 - v.armL
            modeTime -= dt; if modeTime <= 0 { enter(.idle, for: 2) }
        case .sleep:
            v.sleepT += dt
            modeTime -= dt; if modeTime <= 0 { pickBehavior() }
        case .idle, .think:
            modeTime -= dt; if modeTime <= 0 && !airborne { pickBehavior() }
        case .drag:
            break
        }
        v.needsDisplay = true
    }

    // MARK: Mouse
    func mouseDown(at p: CGPoint) { dragStart = p; dragOrigin = pos; dragging = false }
    func mouseDragged(to p: CGPoint) {
        guard let s = dragStart, let o = dragOrigin else { return }
        if !dragging && hypot(p.x - s.x, p.y - s.y) > 4 {
            dragging = true
            idleSleeping = false
            enter(.drag, for: 0); view.speech = nil; view.hop = 0; view.hopVel = 0; view.turn = 0
            view.armL = 1; view.armR = 1
            airborne = false; vy = 0
        }
        if dragging { pos = CGPoint(x: o.x + p.x - s.x, y: o.y + p.y - s.y); place() }
    }
    func mouseUp(clicks: Int) {
        if dragging {
            dragging = false
            clampToScreen(); place()
            airborne = false; vy = 0
            let fl = floorUnder(x: centerX, maxY: feetY + 4)
            standing = abs(feetY - fl.y) <= 3
            if standing { standingOn = fl.owner }
            enter(.idle, for: 3)
            say(standing && standingOn != "floor" ? "What a nice spot!" : "Here?", for: 1.6)
        } else { poke(clicks: clicks) }
        dragStart = nil
    }
    func poke(clicks: Int) {
        idleSleeping = false
        if view.mode == .sleep { enter(.idle, for: 3); say("Huh? I'm awake!", for: 2.5); return }
        if clicks >= 2 { enter(.cheer, for: 3); say("Party!", for: 2); return }
        enter(.happy, for: 1.6)
        say(clickPhrases.randomElement()!, for: 1.8)
    }

    // MARK: Menu
    func makeMenu() -> NSMenu {
        let m = NSMenu()
        func add(_ title: String, _ sel: Selector, _ key: String = "") {
            let i = NSMenuItem(title: tr(title), action: sel, keyEquivalent: key); i.target = self; m.addItem(i)
        }
        add("Wave", #selector(menuWave))
        add("Say something", #selector(menuSay))
        add("Go to a window", #selector(menuJump))
        add("Celebrate", #selector(menuCheer))
        add("Sleep / wake up", #selector(menuSleep))
        add("Come to the center", #selector(menuHome))
        m.addItem(.separator())
        add("Quit Clawd", #selector(menuQuit), "q")
        return m
    }
    @objc func menuWave() { startWave("Hi!") }
    @objc func menuSay() { enter(.idle, for: 4); say(phrases.randomElement()!, for: 3.5) }
    @objc func menuJump() { if !airborne { platforms = visiblePlatforms(excluding: window.windowNumber); goToWindow() } }
    @objc func menuCheer() { enter(.cheer, for: 3); say("✦ ✦ ✦", for: 2) }
    @objc func menuSleep() {
        if view.mode == .sleep { idleSleeping = false; enter(.idle, for: 3); say("Awake!", for: 2) }
        else { enter(.sleep, for: 120) }
    }
    @objc func menuHome() {
        let f = (NSScreen.main ?? screen).visibleFrame
        pos = CGPoint(x: f.midX - view.spriteCenterX, y: f.midY); place()
        airborne = false; vy = 0; standing = false
        enter(.idle, for: 3); say("Here I am!", for: 2)
    }
    @objc func menuQuit() { NSApp.terminate(nil) }
}

final class AppDelegate: NSObject, NSApplicationDelegate {
    var pet: Pet?
    func applicationDidFinishLaunching(_ n: Notification) { pet = Pet() }
}

#if RENDER_TEST
// Test mode: saves every state as a PNG image.
_ = NSApplication.shared
func render(_ name: String, _ setup: (PetView) -> Void) {
    let v = PetView(frame: NSRect(x: 0, y: 0, width: PetView.w, height: PetView.h))
    setup(v)
    guard let rep = v.bitmapImageRepForCachingDisplay(in: v.bounds) else { return }
    v.cacheDisplay(in: v.bounds, to: rep)
    try? rep.representation(using: .png, properties: [:])?.write(to: URL(fileURLWithPath: CommandLine.arguments[1] + "/" + name + ".png"))
}
render("idle")  { $0.speech = "Hi! I'm Clawd" }
render("look")  { $0.eyeDX = 1; $0.eyeDY = -1 }
render("walk")  { $0.walking = true; $0.time = 0.35; $0.eyeDX = -1 }
render("turn")  { $0.turn = 0.3 }
render("wave")  { $0.armR = 1; $0.eyeStyle = .wink }
render("cheer") { $0.armL = 1; $0.armR = 1; $0.sparkleT = 1; $0.hop = 8 }
render("happy") { $0.eyeStyle = .happy; $0.sparkleT = 1 }
render("sleep") { $0.mode = .sleep; $0.sleepT = 1.2 }
render("dizzy") { $0.eyeStyle = .dizzy; $0.armL = 1 }
render("think") { $0.speech = "..." }
render("work")  { $0.mode = .work; $0.armL = 1; $0.eyeDY = 1; $0.speech = "Claude is working…" }
render("startled") { $0.hop = 10; $0.speech = "!" }
render("dance") { $0.mode = .dance; $0.eyeStyle = .happy; $0.armL = 1; $0.time = 0.2; $0.speech = "♪ Song — Artist" }
// list the detected windows
let plats = visiblePlatforms(excluding: 0)
print("windows:", plats.count)
for p in plats.prefix(12) { print(String(format: "  %@  x %.0f…%.0f  top %.0f  h %.0f", p.owner, p.rect.minX, p.rect.maxX, p.top, p.rect.height)) }
#else
let app = NSApplication.shared
app.setActivationPolicy(.accessory)
let delegate = AppDelegate()
app.delegate = delegate
app.run()
#endif
