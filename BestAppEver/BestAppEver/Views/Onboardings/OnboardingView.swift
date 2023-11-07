/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The view that shows the guidance text and tutorials on the review screen.
*/

import Foundation
import RealityKit
import SwiftUI

@available(iOS 17.0, *)
/// View that shows the guidance text and tutorials on the review screen.
struct OnboardingView: View {
    @EnvironmentObject var data: AppDataModel
    @StateObject private var stateMachine: OnboardingStateMachine
    @Environment(\.colorScheme) private var colorScheme

    init(state: OnboardingState) {
        _stateMachine = StateObject(wrappedValue: OnboardingStateMachine(state))
    }

    var body: some View {
        ZStack {
            Color(colorScheme == .light ? .white : .black).ignoresSafeArea()
            if let session = data.objectCaptureSession {
                OnboardingTutorialView(session: session, onboardingStateMachine: stateMachine)
                OnboardingButtonView(session: session, onboardingStateMachine: stateMachine)
            }
        }
        .interactiveDismissDisabled(data.objectCaptureSession?.userCompletedScanPass ?? false)
        .allowsHitTesting(!isFinishingOrCompleted)
    }

    private var isFinishingOrCompleted: Bool {
        guard let session = data.objectCaptureSession else { return true }
        return session.state == .finishing || session.state == .completed
    }
}
