# Supportable

An iOS SwiftUI test app that demonstrates a **transparent overlay** with **touch passthrough** everywhere except a floating **control panel**. The control panel can **toggle camera and mic** (AVCaptureSession) and show a live camera preview.

## Features
- Transparent overlay layer
- Touch passthrough except on control buttons
- Start/stop camera + mic
- Minimal, clean SwiftUI
- Ready to drop into Xcode (create an iOS App project named **Supportable**, then replace `ContentView.swift` and add the files below)

## Quick Start
1. In Xcode, create a new **iOS App** project named `Supportable` (SwiftUI + Swift).
2. In the created project, add the folders from this repo (`iOS`, `Core`) into the project (drag into Xcode, **Copy items if needed**).
3. Replace Xcode’s default `ContentView.swift` with the one provided here.
4. Add the **Info.plist** entries (Camera/Microphone usage descriptions) from `iOS/Info.plist` (or copy the values).
5. Build & run on a real device (camera requires device).

## Info.plist keys (required)
- `NSCameraUsageDescription` = "Camera access is required for Supportable to show live video."
- `NSMicrophoneUsageDescription` = "Microphone access is required for Supportable to capture audio."

## License
MIT
