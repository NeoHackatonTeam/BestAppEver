//
//  LibrairyView.swift
//  BestAppEver
//
//  Created by Tony Izzi on 07/11/2023.
//

import SwiftUI

struct LibrairyView: View {
    
    @StateObject var viewModel = LibrairyViewModel()

    var columns: [GridItem] = [
        GridItem(.adaptive(minimum: 100)),
        GridItem(.adaptive(minimum: 100))
    ]

    
    var body: some View {
        NavigationStack{
        ScrollView{
                LazyVGrid(columns: columns,
                          alignment: .leading){
                    ForEach(viewModel.listModel){ model in
                        AsyncImage(url: URL(string: model.url))
                        { img in
                            img
                                .resizable()
                                .frame(width: 250, height: 250)
                                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                        } placeholder: {
                            Image(systemName: "network.slash")
                                .resizable()
                                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                        }
                        }
                    }
                }
            }.background(Color.black)
        }
}

#Preview {
    LibrairyView()
}
