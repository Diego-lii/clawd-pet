#!/bin/zsh
# Builds the pet and creates ClawdPet.app next to this script.
set -e
cd "$(dirname "$0")"
APP="ClawdPet.app"
rm -rf "$APP"
mkdir -p "$APP/Contents/MacOS" "$APP/Contents/Resources"
cp Info.plist "$APP/Contents/Info.plist"
swiftc -O -swift-version 5 -o "$APP/Contents/MacOS/ClawdPet" main.swift -framework Cocoa
echo "Built: $(pwd)/$APP"
