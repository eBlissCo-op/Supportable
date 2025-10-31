import SwiftUI

/// A nearly fully transparent overlay view that lets touches pass through.
struct TransparentOverlayView: View {
    var body: some View {
        Rectangle()
            .fill(Color.black.opacity(0.001)) // keep it in the hit-testing tree, but transparent
            .ignoresSafeArea()
    }
}
