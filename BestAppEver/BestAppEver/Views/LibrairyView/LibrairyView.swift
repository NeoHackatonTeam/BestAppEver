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
                        LibrairyCell(model: model)
                    }
                }
            }.background(Color.yellow)
        }
        }
}

#Preview {
    LibrairyView()
}
