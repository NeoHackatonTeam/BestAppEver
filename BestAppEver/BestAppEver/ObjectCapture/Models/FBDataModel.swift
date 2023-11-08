//
//  FBDataModel.swift
//  BestAppEver
//
//  Created by Tony Izzi on 07/11/2023.
//

import Foundation

class FBDataModel: Identifiable{
    var id: String = ""
    var urlImage: String
    var urlModele: String
    var name: String
    var description: String
    
    init(id:String, urlImage: String, urlModele: String, name: String, description: String) {
        self.id = id //généré
        self.urlImage = urlImage
        self.urlModele = urlModele //url locale -> url distant
        self.name = name
        self.description = description // init IA
    }
}
