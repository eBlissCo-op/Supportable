import SwiftUI

struct ContentView: View {
    @StateObject private var media = CameraMicController()
    @State private var showOverlay = true
    @State private var showDemoUnderlay = true
    
    var body: some View {
        ZStack {
            // Underlay "test app UI" to prove touch passthrough
            if showDemoUnderlay {
                DemoUnderlayView()
                    .zIndex(0)
            }
            
            // Camera preview layer (optional)
            if media.isRunning {
                CameraPreviewView(session: media.session)
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .zIndex(1)
            }
            
            // Transparent overlay (doesn't intercept touches by default)
            if showOverlay {
                TransparentOverlayView()
                    .allowsHitTesting(false) // let touches fall through by default
                    .zIndex(2)
            }
            
            // Floating control panel (intercepts touches)
            ControlPanelView(
                isRunning: $media.isRunning,
                showOverlay: $showOverlay,
                showDemoUnderlay: $showDemoUnderlay,
                startAction: { media.start() },
                stopAction: { media.stop() }
            )
            .padding()
            .zIndex(3)
        }
    }
}

struct DemoUnderlayView: View {
    @State private var count = 0
    var body: some View {
        VStack(spacing: 20) {
            Text("Demo Underlay")
                .font(.largeTitle.bold())
            Text("Tap the buttons to verify passthrough works.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            HStack {
                Button("−") { count -= 1 }
                    .buttonStyle(.borderedProminent)
                Text("Count: \(count)")
                    .font(.title2.monospacedDigit())
                Button("+") { count += 1 }
                    .buttonStyle(.borderedProminent)
            }
            .padding(.top, 8)
            Spacer()
        }
        .padding()
    }
}
