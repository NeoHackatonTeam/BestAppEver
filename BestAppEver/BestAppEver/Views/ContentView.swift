//
//  ContentView.swift
//  BestAppEver
//
//  Created by Student04 on 07/11/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            VStack{
                Text("App Name")
                Spacer()
                NavigationLink{
                    OCMainView()
                } label: {
                    Text("Click Here to Start modeling!")
                }
                .padding(15)
                .background(Color.yellow)
                .clipShape(Capsule())
                
                NavigationLink{
                    LibrairyView()
                } label: {
                    Text("Acces to Librairy")
                }
                .padding(15)
                .background(Color.yellow)
                .clipShape(Capsule())
                Spacer()
            }
            
            
        }
    }
}

#Preview {
    ContentView()
}
