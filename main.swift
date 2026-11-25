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
// props
let screenDark = NSColor(srgbRed: 0.16, green: 0.16, blue: 0.23, alpha: 1)
let codeGreen  = NSColor(srgbRed: 0.45, green: 0.75, blue: 0.40, alpha: 1)
let codeBlue   = NSColor(srgbRed: 0.45, green: 0.65, blue: 0.95, alpha: 1)
let codeYellow = NSColor(srgbRed: 0.95, green: 0.78, blue: 0.30, alpha: 1)
let keyGray    = NSColor(srgbRed: 0.42, green: 0.45, blue: 0.50, alpha: 1)
let keyLight   = NSColor(srgbRed: 0.62, green: 0.65, blue: 0.70, alpha: 1)
let phoneBlue  = NSColor(srgbRed: 0.25, green: 0.43, blue: 0.64, alpha: 1)
let bookBlue   = NSColor(srgbRed: 0.36, green: 0.55, blue: 0.85, alpha: 1)
let broomWood  = NSColor(srgbRed: 0.48, green: 0.31, blue: 0.18, alpha: 1)
let broomStraw = NSColor(srgbRed: 0.93, green: 0.72, blue: 0.25, alpha: 1)
let lensFill   = NSColor(srgbRed: 0.62, green: 0.70, blue: 0.78, alpha: 0.85)
let lensEdge   = NSColor(srgbRed: 0.43, green: 0.52, blue: 0.60, alpha: 1)
let ballRed    = NSColor(srgbRed: 0.90, green: 0.35, blue: 0.30, alpha: 1)
let hatYellow  = NSColor(srgbRed: 0.95, green: 0.72, blue: 0.25, alpha: 1)
let hatYellowD = NSColor(srgbRed: 0.80, green: 0.58, blue: 0.15, alpha: 1)
let santaRed   = NSColor(srgbRed: 0.82, green: 0.18, blue: 0.20, alpha: 1)
let partyPink  = NSColor(srgbRed: 0.93, green: 0.40, blue: 0.65, alpha: 1)
let partyTeal  = NSColor(srgbRed: 0.25, green: 0.75, blue: 0.75, alpha: 1)
let boxBrown   = NSColor(srgbRed: 0.76, green: 0.58, blue: 0.38, alpha: 1)
let boxTape    = NSColor(srgbRed: 0.62, green: 0.44, blue: 0.26, alpha: 1)
let heartPink  = NSColor(srgbRed: 0.95, green: 0.40, blue: 0.50, alpha: 1)
let steel      = NSColor(srgbRed: 0.55, green: 0.58, blue: 0.62, alpha: 1)


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
    "Checking for updates…": "Buscando actualizaciones…",
    "You're up to date": "Estás al día",
    "Couldn't check for updates": "No pude buscar actualizaciones",
    "New version": "Nueva versión",
    "click me to download": "haz clic en mí para descargar",
    "Check for updates…": "Buscar actualizaciones…",
    "Claude needs your approval!": "¡Claude necesita tu aprobación!",
    "Claude is waiting for you": "Claude te está esperando",
    "On my way!": "¡Voy!",
    "Claude Code alerts: turn on": "Avisos de Claude Code: activar",
    "Claude Code alerts: turn off": "Avisos de Claude Code: desactivar",
    "Alerts on! Claude Code will tell me when it needs you.": "¡Avisos activados! Claude Code me dirá cuando te necesite.",
    "Alerts off.": "Avisos desactivados.",
    "Couldn't set up the alerts": "No pude activar los avisos",
    "Do not disturb: turn on": "No molestar: activar",
    "Do not disturb: turn off": "No molestar: desactivar",
    "Sounds: turn off": "Sonidos: desactivar",
    "Sounds: turn on": "Sonidos: activar",
    "Hat": "Sombrero",
    "Automatic (Santa hat in December)": "Automático (gorro de Navidad en diciembre)",
    "No hat": "Sin sombrero",
    "Hard hat": "Casco de obra",
    "Party hat": "Gorro de fiesta",
    "Santa hat": "Gorro de Navidad",
    "Sunglasses": "Gafas de sol",
    "Quiet mode. I'll wait here.": "Modo silencio. Espero aquí.",
    "I'm back!": "¡Ya volví!",
    "Hmm?": "¿Mmm?",
    "Peekaboo!": "¡Cucú!",
]
func tr(_ text: String) -> String { spanish ? (spanishText[text] ?? text) : text }

// MARK: - Updates (checks the latest GitHub release)
let appVersion = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? "0"
let releasesPage = "https://github.com/Diego-lii/clawd-pet/releases/latest"
let releasesAPI = "https://api.github.com/repos/Diego-lii/clawd-pet/releases/latest"

func versionParts(_ v: String) -> [Int] {
    v.trimmingCharacters(in: CharacterSet(charactersIn: "vV ")).split(separator: ".").map { Int($0) ?? 0 }
}
func isNewer(_ a: String, than b: String) -> Bool {
    let x = versionParts(a), y = versionParts(b)
    for i in 0..<max(x.count, y.count) {
        let p = i < x.count ? x[i] : 0, q = i < y.count ? y[i] : 0
        if p != q { return p > q }
    }
    return false
}

// MARK: - Claude Code hooks (so Clawd knows when Claude needs you)
//
// A tiny shell script is registered as a Claude Code hook. Every event it receives is
// appended to ~/.clawdpet/events.jsonl, and Clawd reads that file.
let clawdDir = NSHomeDirectory() + "/.clawdpet"
let eventsFile = clawdDir + "/events.jsonl"
let hookScript = clawdDir + "/hook.sh"
let claudeSettings = NSHomeDirectory() + "/.claude/settings.json"
let hookScriptSource = """
#!/bin/sh
# Installed by Clawd Pet. Claude Code runs this on some events; the event JSON arrives on stdin.
# It is appended to a file that Clawd Pet watches. Nothing leaves your Mac.
mkdir -p "$HOME/.clawdpet"
cat >> "$HOME/.clawdpet/events.jsonl"
printf '\\n' >> "$HOME/.clawdpet/events.jsonl"
exit 0
"""
let hookEvents: [(event: String, matcher: String?)] = [("Notification", "permission_prompt|idle_prompt"), ("Stop", nil)]

func readSettings() -> [String: Any] {
    guard let d = FileManager.default.contents(atPath: claudeSettings),
          let j = try? JSONSerialization.jsonObject(with: d) as? [String: Any] else { return [:] }
    return j
}
func writeSettings(_ j: [String: Any]) throws {
    let d = try JSONSerialization.data(withJSONObject: j, options: [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes])
    try FileManager.default.createDirectory(atPath: (claudeSettings as NSString).deletingLastPathComponent, withIntermediateDirectories: true)
    try d.write(to: URL(fileURLWithPath: claudeSettings))
}
func entryIsOurs(_ e: [String: Any]) -> Bool {
    ((e["hooks"] as? [[String: Any]]) ?? []).contains { ($0["command"] as? String) == hookScript }
}
func hooksInstalled() -> Bool {
    let hooks = readSettings()["hooks"] as? [String: Any] ?? [:]
    let list = hooks["Notification"] as? [[String: Any]] ?? []
    return list.contains(where: entryIsOurs) && FileManager.default.isExecutableFile(atPath: hookScript)
}
func installHooks() throws {
    try FileManager.default.createDirectory(atPath: clawdDir, withIntermediateDirectories: true)
    try hookScriptSource.write(toFile: hookScript, atomically: true, encoding: .utf8)
    try FileManager.default.setAttributes([.posixPermissions: 0o755], ofItemAtPath: hookScript)
    var settings = readSettings()
    if FileManager.default.fileExists(atPath: claudeSettings) && !FileManager.default.fileExists(atPath: claudeSettings + ".before-clawdpet") {
        try? FileManager.default.copyItem(atPath: claudeSettings, toPath: claudeSettings + ".before-clawdpet")
    }
    var hooks = settings["hooks"] as? [String: Any] ?? [:]
    for h in hookEvents {
        var list = (hooks[h.event] as? [[String: Any]] ?? []).filter { !entryIsOurs($0) }
        var entry: [String: Any] = ["hooks": [["type": "command", "command": hookScript]]]
        if let m = h.matcher { entry["matcher"] = m }
        list.append(entry)
        hooks[h.event] = list
    }
    settings["hooks"] = hooks
    try writeSettings(settings)
}
func removeHooks() throws {
    var settings = readSettings()
    var hooks = settings["hooks"] as? [String: Any] ?? [:]
    for h in hookEvents {
        let list = (hooks[h.event] as? [[String: Any]] ?? []).filter { !entryIsOurs($0) }
        if list.isEmpty { hooks.removeValue(forKey: h.event) } else { hooks[h.event] = list }
    }
    if hooks.isEmpty { settings.removeValue(forKey: "hooks") } else { settings["hooks"] = hooks }
    try writeSettings(settings)
    try? FileManager.default.removeItem(atPath: hookScript)
}

func clamp<T: Comparable>(_ v: T, _ lo: T, _ hi: T) -> T { min(max(v, lo), hi) }

let phrases = [
    "Hi! 👋", "I'm here if you need me", "What are we doing today?",
    "Hmm, interesting...", "Don't forget to drink water 💧", "Let's go!",
    "Did you commit yet?", "I like this spot", "Break time? Stretch a bit",
    "Nice work!", "Today is going to be a good day", "beep boop", "Take me somewhere else?",
]
let clickPhrases = ["Hey!", "Haha!", "Yes?", "Here I am!", "Wheee!", "Again!"]

enum Mode { case idle, walk, run, sleep, wave, cheer, think, happy, dizzy, drag, work, startled, dance, read, sweep, juggle, alert, peek, petted, build, quiet }
enum Hat: String, CaseIterable { case auto, none, hardHat, party, santa, sunglasses }

// MARK: - Preferences (saved between launches)
let prefs = UserDefaults.standard
var hatPref: Hat { Hat(rawValue: prefs.string(forKey: "hat") ?? "auto") ?? .auto }
var soundsOn: Bool { prefs.object(forKey: "sounds") == nil ? true : prefs.bool(forKey: "sounds") }
var quietMode: Bool { prefs.bool(forKey: "quiet") }
// The hat actually worn: "auto" means a Santa hat in December and nothing otherwise.
func currentHat() -> Hat {
    if hatPref != .auto { return hatPref }
    return Calendar.current.component(.month, from: Date()) == 12 ? .santa : .none
}
func playSound(_ name: String) {
    guard soundsOn, let snd = NSSound(named: NSSound.Name(name)) else { return }
    snd.volume = 0.35
    snd.play()
}
enum EyeStyle { case open, closed, wink, happy, dizzy, content }

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
    static let h: CGFloat = 175
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
    var carrying = false
    var heartT: CGFloat = 0
    var hat: Hat = .none

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
        drawProps()
        drawHat()
        ctx.restoreGState()
        if heartT > 0 { drawHearts() }

        if sparkleT > 0 { drawSparkles() }
        if sleeping { drawZs() }
        if let t = speech {
            var extra: CGFloat = armL + armR > 0 ? u : 0
            if mode == .work { extra = 8.5 * u } else if mode == .dance { extra = 1.5 * u } else if mode == .juggle { extra = 5.5 * u } else if mode == .alert { extra = 3.5 * u }
            switch hat { case .hardHat: extra = max(extra, 2.2 * u); case .party: extra = max(extra, 4.5 * u); case .santa: extra = max(extra, 4.5 * u); default: break }
            drawBubble(t, topY: spriteTop + extra + 6, tailX: spriteCenterX)
        }
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
            case .content:
                // "v v": relaxed eyes
                let p = NSBezierPath()
                let cx = r.midX, cy = r.midY, hw = u * 0.75, hh = u * 0.45
                p.move(to: CGPoint(x: cx - hw, y: cy + hh))
                p.line(to: CGPoint(x: cx, y: cy - hh))
                p.line(to: CGPoint(x: cx + hw, y: cy + hh))
                p.lineWidth = u * 0.4; p.lineJoinStyle = .miter; p.lineCapStyle = .butt
                ink.setStroke(); p.stroke()
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

    // Accessories for some states: laptop, headphones, glasses and book, broom, balls, magnifier.
    func drawProps() {
        let u = PetView.u
        switch mode {
        case .work:
            // screen above the head
            fill(cell(0.5, -8, 10, 6.5), screenDark)
            fill(NSRect(x: cell(1, -7.6).minX, y: cell(1, -7.6).minY, width: u * 0.5, height: u * 0.5), ballRed)
            fill(NSRect(x: cell(1.8, -7.6).minX, y: cell(1.8, -7.6).minY, width: u * 0.5, height: u * 0.5), codeYellow)
            fill(NSRect(x: cell(2.6, -7.6).minX, y: cell(2.6, -7.6).minY, width: u * 0.5, height: u * 0.5), codeGreen)
            // code lines that get typed in
            let lines: [(CGFloat, CGFloat, NSColor)] = [(1.2, 4.5, codeGreen), (2.0, 5.5, codeGreen), (2.0, 3.0, codeBlue), (2.8, 4.0, codeBlue), (1.2, 2.5, codeYellow)]
            let progress = (time * 1.4).truncatingRemainder(dividingBy: CGFloat(lines.count) + 1.5)
            for (i, l) in lines.enumerated() {
                let shown = clamp(progress - CGFloat(i), 0, 1)
                if shown > 0 { fill(cell(l.0, -6.6 + CGFloat(i) * 0.9, l.1 * shown, 0.5), l.2) }
            }
            // keyboard in front of the body
            fill(cell(-0.5, 4, 12, 2), keyGray)
            for kx in stride(from: 0.0, to: 11.0, by: 1.0) {
                for ky in [4.3, 5.1] { fill(cell(CGFloat(kx) + 0.1, CGFloat(ky), 0.6, 0.5), keyLight) }
            }
        case .dance:
            // headphones
            fill(cell(1, -1, 9, 1), phoneBlue)
            fill(cell(0, -1, 1, 2), phoneBlue); fill(cell(10, -1, 1, 2), phoneBlue)
            fill(cell(-0.5, 1, 1.5, 2.6), phoneBlue); fill(cell(10, 1, 1.5, 2.6), phoneBlue)
            // floating notes
            for i in 0..<2 {
                let ph = (time * 0.7 + CGFloat(i) * 0.5).truncatingRemainder(dividingBy: 1)
                let attrs: [NSAttributedString.Key: Any] = [
                    .font: NSFont.systemFont(ofSize: 9 + ph * 6, weight: .bold),
                    .foregroundColor: codeYellow.withAlphaComponent(1 - ph)]
                let side: CGFloat = i == 0 ? -1 : 1
                NSAttributedString(string: "♪", attributes: attrs)
                    .draw(at: CGPoint(x: spriteCenterX + side * (5 * u + ph * 10), y: oy + 6 * u + hop + ph * 28))
            }
        case .read:
            // round glasses
            lensEdge.setStroke()
            for bx in [CGFloat(2), CGFloat(8)] {
                let r = cell(bx, 2)
                let g = NSBezierPath(ovalIn: r.insetBy(dx: -u * 0.45, dy: -u * 0.45))
                g.lineWidth = 1.6; ink.setStroke(); g.stroke()
            }
            fill(NSRect(x: cell(3, 2).minX - u * 0.45, y: cell(3, 2).midY - 0.8, width: 5 * u + u * 0.9, height: 1.6), ink)
            // book held in front, pages flip every 1.6 s
            fill(cell(0.3, 3.3, 4, 2.4), bookBlue)
            fill(cell(2.25, 3.3, 0.2, 2.4), phoneBlue)
            let flip = Int(time / 1.6) % 2
            for i in 0..<3 {
                let w: CGFloat = (i + flip) % 2 == 0 ? 1.3 : 0.9
                fill(cell(0.6, 3.7 + CGFloat(i) * 0.6, w, 0.25), cream)
                fill(cell(2.7, 3.7 + CGFloat(i) * 0.6, w, 0.25), cream)
            }
        case .sweep:
            // broom: handle from the left arm to a brush that sweeps on the floor
            let sway = sin(time * 4)
            let hand = CGPoint(x: cell(0.5, 2.5).midX, y: cell(0.5, 2.5).midY)
            let brush = CGPoint(x: cell(-1.2 + sway * 1.3, 7.9).midX, y: cell(0, 7.9).midY)
            let h = NSBezierPath(); h.move(to: hand); h.line(to: brush)
            h.lineWidth = u * 0.45; h.lineCapStyle = .round; broomWood.setStroke(); h.stroke()
            fill(NSRect(x: brush.x - u, y: brush.y - u * 0.3, width: 2 * u, height: u * 0.9), broomStraw)
            if sway > 0.9 { fill(cell(9.5, -0.8, 0.4, 0.6), codeBlue) }
        case .juggle:
            // three balls flying between the hands
            let colors = [codeGreen, ballRed, codeYellow]
            for i in 0..<3 {
                let q = (time * 0.55 + CGFloat(i) / 3).truncatingRemainder(dividingBy: 1)
                let t = q < 0.5 ? q * 2 : (1 - q) * 2
                let x = 0.5 + 10 * t, y = 2.5 - 5 * sin(t * .pi)
                let c = cell(x, y)
                fill(NSRect(x: c.midX - u * 0.5, y: c.midY - u * 0.5, width: u, height: u), colors[i])
            }
        case .alert where true, .quiet where pet?.alertMessage.isEmpty == false:
            // blinking red "!" above the head
            if Int(time * 4) % 2 == 0 {
                fill(cell(5, -3.2, 1, 1.9), ballRed)
                fill(cell(5, -1.0, 1, 0.8), ballRed)
            }
        case .build:
            // hammer swinging in the right arm
            let swing = max(0, sin(time * 5))
            let hand = CGPoint(x: cell(10.5, 2.5).midX, y: cell(10.5, 2.5).midY)
            let a: CGFloat = -0.3 - swing * 1.4
            let len = 3.2 * u
            let head = CGPoint(x: hand.x + cos(a) * len, y: hand.y + sin(a) * len)
            let h = NSBezierPath(); h.move(to: hand); h.line(to: head)
            h.lineWidth = u * 0.45; h.lineCapStyle = .round; broomWood.setStroke(); h.stroke()
            fill(NSRect(x: head.x - u * 0.9, y: head.y - u * 0.55, width: u * 1.8, height: u * 1.1), steel)
            if swing > 0.97 { fill(cell(12.5, 4.5, 0.5, 0.5), codeYellow); fill(cell(13.3, 3.8, 0.4, 0.4), codeYellow) }
        case .run where carrying:
            // cardboard box carried in front
            fill(cell(2.5, 3, 6, 2.8), boxBrown)
            fill(cell(5.2, 3, 0.6, 2.8), boxTape)
            fill(cell(2.5, 3.8, 6, 0.3), boxTape)
        case .think:
            // magnifier over the right eye (the eye looks bigger through it)
            let r = cell(7.4, 1.4, 2.2, 2.2)
            if mode == .think { let e = cell(8, 2); fill(NSRect(x: e.midX - u * 0.75, y: e.midY - u * 0.75, width: u * 1.5, height: u * 1.5), ink) }
            let lens = NSBezierPath(roundedRect: r, xRadius: u * 0.5, yRadius: u * 0.5)
            lensFill.setFill(); lens.fill()
            lens.lineWidth = 1.4; lensEdge.setStroke(); lens.stroke()
            fill(NSRect(x: r.minX + u * 0.35, y: r.maxY - u * 0.8, width: u * 0.45, height: u * 0.45), cream)
            let hd = NSBezierPath(); hd.move(to: CGPoint(x: r.maxX - 2, y: r.minY + 2)); hd.line(to: CGPoint(x: r.maxX + u * 0.8, y: r.minY - u * 0.8))
            hd.lineWidth = u * 0.45; hd.lineCapStyle = .round; broomWood.setStroke(); hd.stroke()
        default: break
        }
    }

    func drawHat() {
        let u = PetView.u
        switch hat {
        case .hardHat:
            fill(cell(1.5, -1, 8, 1), hatYellow)
            fill(cell(2.5, -2, 6, 1), hatYellow)
            fill(cell(0.5, -0.5, 10, 0.5), hatYellowD)
            fill(cell(5.2, -1.8, 0.6, 1.5), hatYellowD); fill(cell(4.6, -1.4, 1.8, 0.5), hatYellowD)
        case .party:
            let p = NSBezierPath()
            let base = cell(3.5, -0.2, 4, 0.2)
            p.move(to: CGPoint(x: base.minX, y: base.maxY)); p.line(to: CGPoint(x: base.maxX, y: base.maxY)); p.line(to: CGPoint(x: base.midX, y: base.maxY + 4 * u)); p.close()
            partyPink.setFill(); p.fill()
            for i in 0..<3 { fill(cell(4.3 + CGFloat(i) * 0.35, -0.9 - CGFloat(i) * 1.0, 2.4 - CGFloat(i) * 0.7, 0.35), partyTeal) }
            fill(NSRect(x: base.midX - u * 0.45, y: base.maxY + 4 * u - u * 0.3, width: u * 0.9, height: u * 0.9), codeYellow)
        case .santa:
            fill(cell(1, -1, 9, 1), santaRed)
            fill(cell(2, -2, 6.5, 1), santaRed)
            fill(cell(3, -3, 4, 1), santaRed)
            fill(cell(4, -3.8, 2.5, 0.9), santaRed)
            fill(cell(0.5, -0.6, 10, 0.7), cream)
            fill(cell(6.3, -4.3, 1.1, 1.1), cream)
        case .sunglasses:
            fill(cell(1.3, 1.7, 3, 1.5), ink); fill(cell(6.7, 1.7, 3, 1.5), ink)
            fill(cell(4.3, 2.0, 2.4, 0.4), ink)
            fill(cell(1.7, 1.95, 0.7, 0.35), steel); fill(cell(7.1, 1.95, 0.7, 0.35), steel)
        case .none, .auto: break
        }
    }

    func drawHearts() {
        for i in 0..<3 {
            let ph = (time * 0.7 + CGFloat(i) * 0.33).truncatingRemainder(dividingBy: 1)
            let attrs: [NSAttributedString.Key: Any] = [
                .font: NSFont.systemFont(ofSize: 8 + ph * 7, weight: .bold),
                .foregroundColor: heartPink.withAlphaComponent(min(1, heartT) * (1 - ph))]
            let side: CGFloat = i == 1 ? 0 : (i == 0 ? -1 : 1)
            NSAttributedString(string: "♥", attributes: attrs)
                .draw(at: CGPoint(x: spriteCenterX + side * (3.5 * PetView.u + ph * 8) - 4, y: oy + 7 * PetView.u + hop + ph * 30))
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

// A borderless window that macOS does not push back on screen (Clawd hides behind the edge when peeking).
final class PetWindow: NSWindow {
    override func constrainFrameRect(_ frameRect: NSRect, to screen: NSScreen?) -> NSRect { frameRect }
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
    var updateTimer: CGFloat = 40          // first silent check 40 s after launch, then daily
    var updateAvailable: String?           // tag of the newer release, if any
    var updateClickUntil: TimeInterval = 0 // while set, a click on Clawd opens the download page
    var eventsOffset: UInt64 = 0           // how much of events.jsonl has been read
    var eventsTimer: CGFloat = 0
    var alertStart: TimeInterval = 0
    var alertMessage = ""
    var alertRepeat: CGFloat = 0
    var peekPhase = 0                      // 0 leaving, 1 hidden, 2 peeking, 3 coming back
    var peekSide: CGFloat = 1
    var hoverStill: CGFloat = 0            // seconds the cursor has rested on Clawd
    var petCooldown: CGFloat = 0
    var stillMouse: CGFloat = 0            // seconds the cursor has not moved
    var curiosityCooldown: CGFloat = 30
    var curious = false
    var dragMaxSpeed: CGFloat = 0

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
        window = PetWindow(contentRect: NSRect(x: 0, y: 0, width: PetView.w, height: PetView.h),
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
        if let a = try? FileManager.default.attributesOfItem(atPath: eventsFile), let n = (a[.size] as? NSNumber)?.uint64Value { eventsOffset = n }
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
        v.walking = false; v.armL = 0; v.armR = 0; v.eyeStyle = .open; v.carrying = false
        switch m {
        case .sleep: v.sleepT = 0; v.speech = nil
        case .cheer: v.armL = 1; v.armR = 1; v.sparkleT = secs
        case .happy: v.eyeStyle = .happy; v.sparkleT = secs
        case .dizzy: v.eyeStyle = .dizzy
        case .think: say("...", for: secs)
        case .startled: v.hopVel = 170
        case .dance: v.eyeStyle = .content
        case .alert: v.armL = 1; v.armR = 1
        case .petted: v.eyeStyle = .content; v.heartT = secs
        case .build: v.armR = 1
        case .quiet: v.speech = nil
        case .read: v.armL = 1
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
        if quietMode { enter(.quiet, for: 0); return }
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
        case ..<0.70: startWave(Bool.random() ? "Hi!" : nil)
        case ..<0.72 where view.hat == .hardHat: enter(.build, for: 5)
        case ..<0.735: startPeek()
        case ..<0.76: enter(.read, for: CGFloat.random(in: 6...10))
        case ..<0.79: enter(.sweep, for: 5)
        case ..<0.82: enter(.juggle, for: 6)
        case ..<0.85: enter(.cheer, for: 2.5); say(["Yes!", "We did it!", "✦"].randomElement()!, for: 2)
        case ..<0.89: enter(.think, for: 3)
        case ..<(0.94 + sleepBias): enter(.sleep, for: CGFloat.random(in: 10...25))
        default: enter(.idle, for: 4); say(phrases.randomElement()!, for: 3.5)
        }
    }

    // Hide behind the nearest screen edge, then peek back in.
    func startPeek() {
        let f = screen.visibleFrame
        peekSide = centerX < f.midX ? -1 : 1
        peekPhase = 0
        let hiddenX = peekSide < 0 ? f.minX - view.ox - spriteW - 4 : f.maxX - view.ox + 4
        walkTarget = CGPoint(x: hiddenX, y: pos.y)
        enter(.peek, for: 30)
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
        view.carrying = true
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
        let busy = dragging || airborne || v.mode == .sleep || v.mode == .drag || v.mode == .work || v.mode == .startled || v.mode == .quiet || v.mode == .peek || v.mode == .alert
        if changed && !busy {
            enter(.dance, for: 8)
            say("♪ " + track, for: 4)
        } else if !playing && v.mode == .dance {
            enter(.idle, for: 2)
        }
    }

    // Asks GitHub for the latest release. `quiet` only speaks when there is a new version.
    func checkForUpdates(quiet: Bool) {
        if !quiet { say("Checking for updates…", for: 3) }
        guard let url = URL(string: releasesAPI) else { return }
        var req = URLRequest(url: url, timeoutInterval: 10)
        req.setValue("application/vnd.github+json", forHTTPHeaderField: "Accept")
        URLSession.shared.dataTask(with: req) { [weak self] data, _, _ in
            var tag: String? = nil
            if let d = data, let json = try? JSONSerialization.jsonObject(with: d) as? [String: Any] {
                tag = json["tag_name"] as? String
            }
            DispatchQueue.main.async { self?.updateResult(tag: tag, quiet: quiet) }
        }.resume()
    }
    func updateResult(tag: String?, quiet: Bool) {
        guard let tag = tag else {
            if !quiet { say("Couldn't check for updates", for: 3) }
            return
        }
        if isNewer(tag, than: appVersion) {
            updateAvailable = tag
            updateClickUntil = Date().timeIntervalSince1970 + 30
            if view.mode != .sleep && view.mode != .drag && !airborne { enter(.cheer, for: 2.5) }
            say(tr("New version") + " \(tag): " + tr("click me to download"), for: 8)
        } else if !quiet {
            say(tr("You're up to date") + " (v\(appVersion))", for: 3)
        }
    }

    // Reads new lines appended to the events file by the Claude Code hook.
    func readClaudeEvents() {
        guard let attrs = try? FileManager.default.attributesOfItem(atPath: eventsFile),
              let size = (attrs[.size] as? NSNumber)?.uint64Value else { return }
        if size < eventsOffset { eventsOffset = 0 }
        guard size > eventsOffset, let fh = FileHandle(forReadingAtPath: eventsFile) else { return }
        defer { try? fh.close() }
        fh.seek(toFileOffset: eventsOffset)
        let data = fh.readDataToEndOfFile()
        eventsOffset = size
        if size > 1_000_000 { try? "".write(toFile: eventsFile, atomically: true, encoding: .utf8); eventsOffset = 0 }
        guard let text = String(data: data, encoding: .utf8) else { return }
        for line in text.split(separator: "\n") {
            guard let d = line.data(using: .utf8),
                  let j = try? JSONSerialization.jsonObject(with: d) as? [String: Any] else { continue }
            handleClaudeEvent(j)
        }
    }
    func handleClaudeEvent(_ e: [String: Any]) {
        let name = e["hook_event_name"] as? String ?? ""
        let type = e["notification_type"] as? String ?? ""
        switch (name, type) {
        case ("Notification", "permission_prompt"): startAlert("Claude needs your approval!")
        case ("Notification", "idle_prompt"): startAlert("Claude is waiting for you")
        case ("Stop", _):
            if view.mode == .alert { stopAlert() }
            let worked = Date().timeIntervalSince1970 - claudeWorkStart
            claudeActiveUntil = 0
            if worked > 12 && view.mode != .sleep && view.mode != .drag && !airborne && view.mode != .alert { enter(.cheer, for: 2.5); say("Done! ✦", for: 2.5) }
            else if view.mode == .work { enter(.idle, for: 2) }
        default: break
        }
    }
    func startAlert(_ message: String) {
        guard !dragging else { return }
        if quietMode { alertMessage = message; alertStart = Date().timeIntervalSince1970; return }
        alertStart = Date().timeIntervalSince1970
        alertMessage = message
        alertRepeat = 10
        idleSleeping = false
        enter(.alert, for: 180)
        say(message, for: 5)
        playSound("Pop")
    }
    func stopAlert() {
        if view.mode == .alert { enter(quietMode ? .quiet : .idle, for: 2) }
        alertMessage = ""
    }

    func userIdleSeconds() -> Double {
        let types: [CGEventType] = [.mouseMoved, .leftMouseDown, .rightMouseDown, .keyDown, .scrollWheel, .leftMouseDragged]
        return types.map { CGEventSource.secondsSinceLastEventType(.combinedSessionState, eventType: $0) }.min() ?? 0
    }

    @objc func appActivated(_ n: Notification) {
        guard appCommentCooldown <= 0, !dragging, view.mode != .sleep, view.mode != .quiet, view.mode != .peek, view.mode != .alert,
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
        } else if v.mode == .read {
            v.eyeDX = 0; v.eyeDY = 0
        } else if v.mode == .idle || v.mode == .think || v.mode == .wave {
            v.eyeDX = dx > 90 ? 1 : (dx < -90 ? -1 : 0)
            v.eyeDY = dy > 90 ? -1 : (dy < -90 ? 1 : 0)
        } else { v.eyeDX = 0; v.eyeDY = 0 }
        if !dragging && !airborne && startleCooldown == 0 && hypot(dx, dy) < 70 && mouseSpeed > 1800
            && v.mode != .sleep && v.mode != .drag && v.mode != .quiet && v.mode != .peek {
            startleCooldown = 6
            enter(.startled, for: 0.6)
            say("!", for: 0.8)
            playSound("Pop")
            // run away from the cursor
            let len = max(hypot(dx, dy), 1)
            let b = originBounds(screen)
            walkTarget = CGPoint(x: clamp(pos.x - dx / len * 200, b.minX, b.maxX),
                                 y: clamp(pos.y - dy / len * 120, b.minY, b.maxY))
        }
        let overBody = v.hitRect.offsetBy(dx: pos.x, dy: pos.y).contains(mouse)
        if !dragging {
            if window.ignoresMouseEvents == overBody { window.ignoresMouseEvents = !overBody }
        }
        // petting: the cursor resting on Clawd for a moment
        let calm: Set<Mode> = [.idle, .think, .wave, .read, .quiet]
        hoverStill = (overBody && mouseSpeed < 25) ? hoverStill + dt : 0
        if hoverStill > 1.2 && petCooldown == 0 && calm.contains(v.mode) && !dragging {
            petCooldown = 12; hoverStill = 0
            if v.mode == .quiet { v.heartT = 2.5 } else { enter(.petted, for: 2.5); playSound("Tink") }
        }
        // curiosity: the cursor has been still nearby for a while
        stillMouse = mouseSpeed < 5 ? stillMouse + dt : 0
        let near = hypot(dx, dy)
        if stillMouse > 6 && near > 90 && near < 420 && curiosityCooldown == 0 && !overBody && (v.mode == .idle || v.mode == .walk) {
            curiosityCooldown = 60; curious = true
            let b = originBounds(screen)
            let side: CGFloat = dx > 0 ? -1 : 1
            startWalk(to: CGPoint(x: clamp(mouse.x + side * 48 - v.spriteCenterX, b.minX, b.maxX),
                                  y: clamp(mouse.y - 30 - v.oy, b.minY, b.maxY)))
        }

        // falls asleep when you stop using the Mac
        let idle = userIdleSeconds()
        if !idleSleeping && idle > 150 && !dragging && !airborne && v.mode != .sleep && v.mode != .quiet && v.mode != .peek {
            idleSleeping = true; enter(.sleep, for: 9999)
        } else if idleSleeping && idle < 1.5 && v.mode != .alert {
            idleSleeping = false
            enter(.startled, for: 0.7); say("Huh?! You're back!", for: 2.5)
        }

        v.hat = currentHat()
        petCooldown = max(0, petCooldown - dt)
        curiosityCooldown = max(0, curiosityCooldown - dt)
        if v.heartT > 0 { v.heartT -= dt }

        // Claude Code events (permission prompts, waiting, done)
        eventsTimer -= dt
        if eventsTimer <= 0 { eventsTimer = 0.5; readClaudeEvents() }

        // updates: once at start, then once a day
        updateTimer -= dt
        if updateTimer <= 0 { updateTimer = 24 * 3600; checkForUpdates(quiet: true) }

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
        if v.mode == .alert && claudeActive && Date().timeIntervalSince1970 - alertStart > 4 && claudeActiveUntil - 7 > alertStart + 3 { stopAlert() }
        if claudeActive && !dragging && !airborne && v.mode != .sleep && v.mode != .drag && v.mode != .startled && v.mode != .alert && v.mode != .quiet && v.mode != .peek {
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
                playSound(hard ? "Basso" : "Bottle")
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
                if v.carrying { v.squash = 0.85; playSound("Bottle") }
                enter(.idle, for: CGFloat.random(in: 1.5...4))
                if curious { curious = false; say("Hmm?", for: 2); enter(.idle, for: 4) }
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
        case .peek:
            let f = screen.visibleFrame
            let peekX = peekSide < 0 ? f.minX - view.ox - spriteW * 0.55 : f.maxX - view.ox - spriteW * 0.45
            let d = walkTarget.x - pos.x
            if abs(d) > 1 {
                v.walking = true
                v.facing = d > 0 ? 1 : -1
                pos.x += (d > 0 ? 1 : -1) * min(abs(d), 90 * dt); place()
            } else {
                v.walking = false
                switch peekPhase {
                case 0: peekPhase = 1; modeTime = CGFloat.random(in: 2...4)
                case 1:
                    modeTime -= dt
                    if modeTime <= 0 { peekPhase = 2; walkTarget.x = peekX; modeTime = 2.5; say("Peekaboo!", for: 1.5); playSound("Pop") }
                case 2:
                    modeTime -= dt
                    if modeTime <= 0 { peekPhase = 3; walkTarget.x = peekSide < 0 ? f.minX - view.ox + 20 : f.maxX - view.ox - spriteW - 20 }
                default: enter(.idle, for: 2)
                }
            }
            v.eyeDX = Int(-peekSide); v.eyeDY = 0
        case .petted:
            modeTime -= dt; if modeTime <= 0 { pickBehavior() }
        case .build:
            v.armR = 1
            modeTime -= dt; if modeTime <= 0 { pickBehavior() }
        case .quiet:
            v.eyeDX = dx > 90 ? 1 : (dx < -90 ? -1 : 0); v.eyeDY = dy > 90 ? -1 : (dy < -90 ? 1 : 0)
        case .alert:
            if v.hop == 0 && v.hopVel == 0 { v.hopVel = 170 }
            alertRepeat -= dt
            if alertRepeat <= 0 { alertRepeat = 10; say(alertMessage, for: 4) }
            modeTime -= dt; if modeTime <= 0 { stopAlert() }
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
        case .read:
            v.eyeDX = 0; v.eyeDY = 0
            modeTime -= dt; if modeTime <= 0 { pickBehavior() }
        case .sweep:
            v.armL = 1; v.facing = -1
            modeTime -= dt; if modeTime <= 0 { pickBehavior() }
        case .juggle:
            v.armL = Int(v.time * 2.2) % 2; v.armR = 1 - v.armL
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
            dragMaxSpeed = 0
            enter(.drag, for: 0); view.speech = nil; view.hop = 0; view.hopVel = 0; view.turn = 0
            view.armL = 1; view.armR = 1
            airborne = false; vy = 0
        }
        if dragging {
            let np = CGPoint(x: o.x + p.x - s.x, y: o.y + p.y - s.y)
            dragMaxSpeed = max(dragMaxSpeed, hypot(np.x - pos.x, np.y - pos.y) * 60)
            pos = np; place()
        }
    }
    func mouseUp(clicks: Int) {
        if dragging {
            dragging = false
            clampToScreen(); place()
            airborne = false; vy = 0
            let fl = floorUnder(x: centerX, maxY: feetY + 4)
            standing = abs(feetY - fl.y) <= 3
            if standing { standingOn = fl.owner }
            if dragMaxSpeed > 2600 { enter(.dizzy, for: 1.6); playSound("Basso") }
            else if quietMode { enter(.quiet, for: 0) }
            else { enter(.idle, for: 3); say(standing && standingOn != "floor" ? "What a nice spot!" : "Here?", for: 1.6) }
            dragMaxSpeed = 0
        } else { poke(clicks: clicks) }
        dragStart = nil
    }
    func poke(clicks: Int) {
        idleSleeping = false
        if view.mode == .alert { stopAlert(); say("On my way!", for: 1.5); return }
        if view.mode == .quiet { alertMessage = ""; view.heartT = 1.5; return }
        playSound("Tink")
        if updateAvailable != nil && Date().timeIntervalSince1970 < updateClickUntil, let url = URL(string: releasesPage) {
            NSWorkspace.shared.open(url)
            updateClickUntil = 0
            enter(.happy, for: 1.5)
            return
        }
        if view.mode == .sleep { enter(.idle, for: 3); say("Huh? I'm awake!", for: 2.5); return }
        if clicks >= 2 { enter(.cheer, for: 3); say("Party!", for: 2); playSound("Glass"); return }
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
        add(quietMode ? "Do not disturb: turn off" : "Do not disturb: turn on", #selector(menuQuiet))
        let hatItem = NSMenuItem(title: tr("Hat"), action: nil, keyEquivalent: "")
        let hatMenu = NSMenu()
        let hats: [(Hat, String)] = [(.auto, "Automatic (Santa hat in December)"), (.none, "No hat"), (.hardHat, "Hard hat"), (.party, "Party hat"), (.santa, "Santa hat"), (.sunglasses, "Sunglasses")]
        for (h, title) in hats {
            let i = NSMenuItem(title: tr(title), action: #selector(menuHat(_:)), keyEquivalent: "")
            i.target = self; i.representedObject = h.rawValue; i.state = hatPref == h ? .on : .off
            hatMenu.addItem(i)
        }
        hatItem.submenu = hatMenu
        m.addItem(hatItem)
        add(soundsOn ? "Sounds: turn off" : "Sounds: turn on", #selector(menuSounds))
        add(hooksInstalled() ? "Claude Code alerts: turn off" : "Claude Code alerts: turn on", #selector(menuHooks))
        add("Check for updates…", #selector(menuUpdate))
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
    @objc func menuHooks() {
        do {
            if hooksInstalled() { try removeHooks(); say("Alerts off.", for: 3) }
            else { try installHooks(); enter(.cheer, for: 2.5); say("Alerts on! Claude Code will tell me when it needs you.", for: 5) }
        } catch { say("Couldn't set up the alerts", for: 3) }
        statusItem?.menu = makeMenu()
    }
    @objc func menuQuiet() {
        prefs.set(!quietMode, forKey: "quiet")
        if quietMode {
            let f = (NSScreen.main ?? screen).visibleFrame
            walkTarget = CGPoint(x: f.maxX - view.ox - spriteW - 16, y: f.minY - view.oy)
            enter(.walk, for: 30); view.speech = nil
            say("Quiet mode. I'll wait here.", for: 2.5)
        } else {
            enter(.idle, for: 2); say("I'm back!", for: 2)
        }
        statusItem?.menu = makeMenu()
    }
    @objc func menuSounds() { prefs.set(!soundsOn, forKey: "sounds"); if soundsOn { playSound("Tink") }; statusItem?.menu = makeMenu() }
    @objc func menuHat(_ sender: NSMenuItem) {
        prefs.set(sender.representedObject as? String ?? "auto", forKey: "hat")
        view.hat = currentHat()
        if view.hat == .hardHat { enter(.build, for: 4) } else { enter(.happy, for: 1.5) }
        statusItem?.menu = makeMenu()
    }
    @objc func menuUpdate() { checkForUpdates(quiet: false) }
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
render("dance") { $0.mode = .dance; $0.eyeStyle = .content; $0.armL = 1; $0.time = 0.2; $0.speech = "♪ Song — Artist" }
render("work")  { $0.mode = .work; $0.armL = 1; $0.eyeDY = 1; $0.time = 3.2 }
render("read")  { $0.mode = .read; $0.armL = 1; $0.time = 0.5 }
render("sweep") { $0.mode = .sweep; $0.armL = 1; $0.facing = -1; $0.time = 0.3 }
render("juggle") { $0.mode = .juggle; $0.armL = 1; $0.time = 0.9 }
render("think") { $0.mode = .think; $0.speech = "..." }
render("hardhat") { $0.hat = .hardHat; $0.mode = .build; $0.armR = 1; $0.time = 0.3 }
render("party") { $0.hat = .party; $0.eyeStyle = .happy }
render("santa") { $0.hat = .santa }
render("shades") { $0.hat = .sunglasses }
render("box") { $0.mode = .run; $0.carrying = true; $0.walking = true; $0.armL = 1; $0.armR = 1; $0.time = 0.3 }
render("petted") { $0.mode = .petted; $0.eyeStyle = .content; $0.heartT = 1.5; $0.time = 0.4 }
render("alert") { $0.mode = .alert; $0.armL = 1; $0.armR = 1; $0.hop = 8; $0.time = 0.1; $0.speech = "Claude needs your approval!" }
print("version compare:", isNewer("v1.2.0", than: "1.1.0"), isNewer("v1.1.0", than: "1.2.0"), isNewer("v1.2.0", than: "1.2.0"), isNewer("v2.0", than: "1.9.9"))
// list the detected windows
let plats = visiblePlatforms(excluding: 0)
print("windows:", plats.count)
for p in plats.prefix(12) { print(String(format: "  %@  x %.0f…%.0f  top %.0f  h %.0f", p.owner, p.rect.minX, p.rect.maxX, p.top, p.rect.height)) }
#else
if CommandLine.arguments.contains("--install-hooks") { try installHooks(); print("Claude Code hooks installed in \(claudeSettings)"); exit(0) }
if CommandLine.arguments.contains("--remove-hooks") { try removeHooks(); print("Claude Code hooks removed from \(claudeSettings)"); exit(0) }
let app = NSApplication.shared
app.setActivationPolicy(.accessory)
let delegate = AppDelegate()
app.delegate = delegate
app.run()
#endif
