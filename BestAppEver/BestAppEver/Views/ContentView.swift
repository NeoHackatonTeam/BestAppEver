//
//  ContentView.swift
//  BestAppEver
//
//  Created by Student04 on 07/11/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            Group{
                LibrairyView()
                    .tabItem {
                        Image(systemName: "list.bullet")
                        
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
