//
//  OCMainView.swift
//  BestAppEver
//
//  Created by Student04 on 07/11/2023.
//

import RealityKit
import SwiftUI
import os

@available(iOS 17.0, *)
/// The root of the SwiftUI view graph.
struct OCMainView: View {
    @EnvironmentObject var data :AppDataModel
    @State private var showReconstructionView: Bool = false
    @State private var showErrorAlert: Bool = false
    @State private var isComplete: Bool = false
    @State private var isShown = false
    
    private var showProgressView: Bool {
        data.state == .completed || data.state == .restart || data.state == .ready
    }

    var body: some View {
        VStack {
            if isShown{
                if data.state == .capturing {
                    if let session = data.objectCaptureSession {
                        CaptureView(session: session)
                    }
                } else if showProgressView {
                    CircularProgressView()
                }
            }
        }
        .onAppear{
            isShown = true
        }
        .onDisappear{
            isShown = false
        }
        .onChange(of: data.state) { _, newState in
            if newState == .failed {
                showErrorAlert = true
                showReconstructionView = false
            } else {
                showErrorAlert = false
                isComplete = newState == .completed
                showReconstructionView = newState == .reconstructing || newState == .viewing
            }
        }
        .sheet(isPresented: $showReconstructionView) {
            if let folderManager = data.scanFolderManager {
                ReconstructionPrimaryView(outputFile: folderManager.modelsFolder.appendingPathComponent("model-mobile.usdz"), images: folderManager.imagesFolder)
            }
        }
        .alert(
            "Failed:  " + (data.error != nil  ? "\(String(describing: data.error!))" : ""),
            isPresented: $showErrorAlert,
            actions: {
                Button("OK") {
                    data.state = .restart
                }
            },
            message: {}
        )
    }
}

#Preview {
    OCMainView()
}
