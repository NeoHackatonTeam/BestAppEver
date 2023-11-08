//
//  LibrairyCell.swift
//  BestAppEver
//
//  Created by Tony Izzi on 07/11/2023.
//

import SwiftUI

struct LibrairyCell: View {
    let model :FBDataModel
    @State var url :URL = URL(string: "")!
    
    var body: some View {
        HStack{
            AsyncImage(url: url){ img in
                img
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
            } placeholder: {
                Image(systemName: "network.slash")
                    .resizable()
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
            }
            VStack{
                Text(model.name)
                    .font(.title)
                Text(model.description)
                    .font(.footnote)
                    .lineLimit(5)
                Spacer()
            }
            .foregroundColor(.black)

            Spacer()
        }
        .onAppear{
            ReposStorage.instance.loadFile(typeFile: FileType.image, nameFile: model.urlImage) { result in
                switch result {
                case .success(let imageFilename):
                    url = imageFilename
                case .failure:
                    break
                }
            }
        }
    }
}

//#Preview {
//    LibrairyCell(
//        model: FBDataModel(id: 0, url: "https://i.pinimg.com/736x/5e/8d/fc/5e8dfc7210d98ff44bd04a2804875562.jpg", modelURL: "", name: "Name", description: "Description")
//    )
//}
