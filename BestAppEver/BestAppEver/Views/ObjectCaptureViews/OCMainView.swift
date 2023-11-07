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
    
    private var showProgressView: Bool {
        data.state == .completed || data.state == .restart || data.state == .ready
    }

    var body: some View {
        VStack {
            if data.state == .capturing {
                if let session = data.objectCaptureSession {
                    CaptureView(session: session)
                }
            } else if showProgressView {
                CircularProgressView()
            }
        }
        .onChange(of: data.state) { _, newState in
            if newState == .failed {
                showErrorAlert = true
                showReconstructionView = false
            } else {
                showErrorAlert = false
                showReconstructionView = newState == .reconstructing || newState == .viewing
            }
        }
        .sheet(isPresented: $showReconstructionView) {
            if let folderManager = data.scanFolderManager {
                ReconstructionPrimaryView(outputFile: folderManager.modelsFolder.appendingPathComponent("model-mobile.usdz"))
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
