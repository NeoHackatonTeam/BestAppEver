//
//  AiView.swift
//  BestAppEver
//
//  Created by Tony Izzi on 08/11/2023.
//

import SwiftUI

let viewModel = AiViewModel()

struct AiView: View {
    var body: some View {
        VStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Button(action: {viewModel.startConnect()}){
                Text("Go AI")
            }
        }
    }
}

#Preview {
    AiView()
}
