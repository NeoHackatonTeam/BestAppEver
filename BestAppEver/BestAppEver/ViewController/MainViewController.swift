//
//  MainViewController.swift
//  BestAppEver
//
//  Created by Tony Izzi on 07/11/2023.
//

import Foundation
import RealityKit
import SwiftUI

@MainActor
class MainViewController{
    
    let instance = MainViewController()
    
    private var session = ObjectCaptureSession()
    
    func startConfig(){
        /*var configuration = ObjectCaptureSession.Configuration()
        configuration.checkpointDirectory = getDocumentsDir().appendingPathComponent("Snapshots/")

        session.start(imagesDirectory: getDocumentsDir().appendingPathComponent("Images/"),
                      configuration: configuration)*/
    }

}
