//
//  DatabaseView.swift
//  BestAppEver
//
//  Created by Tony Izzi on 07/11/2023.
//

import SwiftUI

struct DatabaseView: View {
    
    let viewModel = DatabaseViewModel()
    
    var body: some View {
        VStack{
            Button(action: {
                viewModel.addToDatabase(
                    FBDataModel(
                        urlImage: "Labas",
                        urlModele: "IciBas",
                        name: "Ce nom",
                        description: "Ceci")
                )}){
                        Text("Add to Firebase")}
            
            Button(action: {
                viewModel.getListToDatabase()}){
                        Text("Get list from Firebase")}
        }
    }
}
        

#Preview {
    DatabaseView()
}
