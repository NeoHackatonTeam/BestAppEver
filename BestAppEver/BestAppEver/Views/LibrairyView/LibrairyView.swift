//
//  LibrairyView.swift
//  BestAppEver
//
//  Created by Tony Izzi on 07/11/2023.
//

import SwiftUI
import ARKit

struct LibrairyView: View {
    @EnvironmentObject var data :AppDataModel

    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    ForEach(data.modelsList){ model in
                        NavigationLink{
                            if let folderManager = data.scanFolderManager {
                                ModelView(modelFile: URL(string: model.urlModele)!){}
                            }
                        } label: {
                            LibrairyCell(model: model)
                        }
                    }
                }
            }
            .onAppear{
                data.initModelList()
            }
        }
    }
}

//#Preview {
//    LibrairyView()
//}
