//
//  CaptureView.swift
//  BestAppEver
//
//  Created by Student04 on 07/11/2023.
//

import Foundation
import RealityKit
import SwiftUI

@available(iOS 17.0, *)
struct CaptureView: View {
    @EnvironmentObject var data: AppDataModel
    var session: ObjectCaptureSession
    @State var showInfo: Bool = false
    @State private var showOnboardingView: Bool = false

    var body: some View {
        ZStack {
            ObjectCaptureView(session: session,
                              cameraFeedOverlay: { GradientBackground() })
            .blur(radius: data.showPreviewModel ? 45 : 0)
            .transition(.opacity)
            if shouldShowOverlayView {
                CaptureOverlayView(session: session, showInfo: $showInfo)
            }
        }
        .sheet(isPresented: $showInfo) {
            HelpPageView(showInfo: $showInfo)
                .padding()
        }
        .sheet(isPresented: $showOnboardingView,
               onDismiss: { [weak data] in data?.setPreviewModelState(shown: false) },
               content: {[weak data] in
            if let appModel = data, let onboardingState = appModel.determineCurrentOnboardingState() {
                OnboardingView(state: onboardingState)
            }
        })
        .task {
            for await userCompletedScanPass in session.userCompletedScanPassUpdates where userCompletedScanPass {
                data.setPreviewModelState(shown: true)
            }
        }
        .onChange(of: data.showPreviewModel, {_, showPreviewModel in
            if !showInfo {
                showOnboardingView = showPreviewModel
            }
        })
        .onChange(of: showInfo) {
            data.setPreviewModelState(shown: showInfo)
        }
        .onAppear(perform: {
            UIApplication.shared.isIdleTimerDisabled = true
        })
        .onDisappear(perform: {
            UIApplication.shared.isIdleTimerDisabled = false
        })
        .id(session.id)
    }

    private var shouldShowOverlayView: Bool {
        !showInfo && !data.showPreviewModel && !session.isPaused && session.cameraTracking == .normal
    }
}
