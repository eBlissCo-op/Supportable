import SwiftUI

struct ControlPanelView: View {
    @Binding var isRunning: Bool
    @Binding var showOverlay: Bool
    @Binding var showDemoUnderlay: Bool
    let startAction: () -> Void
    let stopAction: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Supportable Controls")
                        .font(.headline)
                    HStack(spacing: 12) {
                        if isRunning {
                            Button {
                                stopAction()
                            } label: {
                                Label("Stop Cam/Mic", systemImage: "stop.fill")
                            }
                            .buttonStyle(.borderedProminent)
                        } else {
                            Button {
                                startAction()
                            } label: {
                                Label("Start Cam/Mic", systemImage: "video.fill")
                            }
                            .buttonStyle(.borderedProminent)
                        }
                        
                        Toggle(isOn: $showOverlay) {
                            Label("Overlay", systemImage: "square.on.square")
                        }
                        .toggleStyle(.switch)
                        
                        Toggle(isOn: $showDemoUnderlay) {
                            Label("Underlay UI", systemImage: "rectangle.on.rectangle.angled")
                        }
                        .toggleStyle(.switch)
                    }
                }
                Spacer()
            }
            .padding()
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
            .shadow(radius: 8)
        }
        .accessibilityElement(children: .contain)
    }
}
