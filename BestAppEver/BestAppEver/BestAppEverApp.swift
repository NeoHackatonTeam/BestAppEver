//
//  BestAppEverApp.swift
//  BestAppEver
//
//  Created by Student04 on 07/11/2023.
//

import SwiftUI

@main
struct BestAppEverApp: App {
    @StateObject var appModel = AppDataModel.instance
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appModel)
        }
    }
}
