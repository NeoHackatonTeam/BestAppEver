//
//  LibrairyViewModel.swift
//  BestAppEver
//
//  Created by Tony Izzi on 07/11/2023.
//

import Foundation

class LibrairyViewModel: ObservableObject{
    
    @Published var listModel = [FBDataModel]()
    
    init(){
        for cpt in (0...4){
            listModel.append(FBDataModel(id: cpt, url: "https://i.pinimg.com/736x/5e/8d/fc/5e8dfc7210d98ff44bd04a2804875562.jpg", name: "Name", description: "Description"))
        }
        
        
        /*listModel = [
            FBDataModel(id: 0, url: ""),
            FBDataModel(id: 1, url: "https://img.freepik.com/photos-gratuite/fille-dans-ciel_1340-27755.jpg?w=740&t=st=1699358253~exp=1699358853~hmac=e0abb0ad93c70190ccacf8748055fa7c478fef55735e23a528604de37b8c3501"),
            FBDataModel(id: 2, url:"https://img.freepik.com/photos-gratuite/fille-aux-cheveux-roses-guitare-sa-chemise_1340-32655.jpg?w=1060&t=st=1699358276~exp=1699358876~hmac=d0a8a0fc0bd01a667fe0f78794346d2ceaa784624f26a8be68c275bc478e82a8"),
            FBDataModel(id: 3, url: "https://img.freepik.com/photos-gratuite/fille-fleur-tete_1340-30886.jpg?w=740&t=st=1699358289~exp=1699358889~hmac=cd7417cf73e6ef00e4f23403b32a43862777b0fdb3be9aa8b36e606cd1c48082"),
            FBDataModel(id: 4, url: "https://img.freepik.com/photos-gratuite/fille-aux-cheveux-noirs-chemise-blanche-jupe-noire-jupe-noire_1340-27763.jpg?w=740&t=st=1699358312~exp=1699358912~hmac=b1c257f2a2d36b28e990571e75a0fb0701afd4e2158f83d4d1d136f5c69de5dc"),
        ]*/
    }
    
}
