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
                NavigationLink{
                    OCMainView()
                } label: {
                    Text("Click Here to Start modeling!")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
