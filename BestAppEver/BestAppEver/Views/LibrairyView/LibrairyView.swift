//
//  LibrairyView.swift
//  BestAppEver
//
//  Created by Tony Izzi on 07/11/2023.
//

import SwiftUI

struct LibrairyView: View {
    
    @StateObject var viewModel = LibrairyViewModel()

    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    ForEach(viewModel.listModel){ model in
                        NavigationLink(destination: LibrairyDetailView()){
                            LibrairyCell(model: model)
                        }
                        
                    }
                }
            }
            .searchable(text: $viewModel.searchText, prompt: "Look for a model")
        }
        }
}

#Preview {
    LibrairyView()
}
