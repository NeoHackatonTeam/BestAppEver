/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A wrapper for AR QuickLook viewer that shows the reconstructed USDZ model
 file directly.
*/

import ARKit
import QuickLook
import SwiftUI
import UIKit
import os

struct ModelView: View {
    let modelFile: URL
    let endCaptureCallback: () -> Void
    @State var trueModelFile :URL = URL(string: "")!

    var body: some View {
        if trueModelFile.absoluteString != ""{
            ARQuickLookController(modelFile: trueModelFile, endCaptureCallback: endCaptureCallback)
                .onAppear{
                    ReposStorage.instance.loadFile(typeFile: FileType.objet3d, nameFile: modelFile.absoluteString) { result in
                        switch result {
                        case .success(let imageFilename):
                            trueModelFile = imageFilename
                        case .failure:
                            break
                        }
                    }
                }
        }
        else{
            Text("Wait for it")
        }
    }
}

private struct ARQuickLookController: UIViewControllerRepresentable {

    let modelFile: URL
    let endCaptureCallback: () -> Void

    func makeUIViewController(context: Context) -> QLPreviewControllerWrapper {
        let controller = QLPreviewControllerWrapper()
        controller.qlvc.dataSource = context.coordinator
        controller.qlvc.delegate = context.coordinator
        return controller
    }

    func makeCoordinator() -> ARQuickLookController.Coordinator {
        return Coordinator(parent: self)
    }

    func updateUIViewController(_ uiViewController: QLPreviewControllerWrapper, context: Context) {}

    class Coordinator: NSObject, QLPreviewControllerDataSource, QLPreviewControllerDelegate {
        let parent: ARQuickLookController

        init(parent: ARQuickLookController) {
            self.parent = parent
        }

        func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
            return 1
        }

        func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
            return parent.modelFile as QLPreviewItem
        }

        func previewControllerWillDismiss(_ controller: QLPreviewController) {
            parent.endCaptureCallback()
        }
    }
}

private class QLPreviewControllerWrapper: UIViewController {
    let qlvc = QLPreviewController()
    var qlPresented = false

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !qlPresented {
            present(qlvc, animated: false, completion: nil)
            qlPresented = true
        }
    }
}
