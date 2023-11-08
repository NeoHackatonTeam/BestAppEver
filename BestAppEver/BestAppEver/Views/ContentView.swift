//
//  ContentView.swift
//  BestAppEver
//
//  Created by Student04 on 07/11/2023.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @State private var selectedImage: UIImage?

    var body: some View {
        TabView{
            Group{
                LibrairyView()
                    .tabItem {
                        Image(systemName: "list.bullet")
                        
                    }
            }
                OCMainView()
                    .tabItem {
                        Image(systemName: "camera")
                    }
            }
            .toolbarBackground(.black, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarColorScheme(.dark, for: .tabBar)
        }
    }
}

#Preview {
    ContentView()
}
