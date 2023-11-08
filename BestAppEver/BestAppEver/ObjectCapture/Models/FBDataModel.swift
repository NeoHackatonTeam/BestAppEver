//
//  FBDataModel.swift
//  BestAppEver
//
//  Created by Tony Izzi on 07/11/2023.
//

import Foundation

struct FBDataModel: Identifiable{
    var id: String = ""
    let url: URL? //distant
    let modelURL: URL? //distant
    let localModelURL: URL?
    let name: String
    let description: String
    
    init(id:String, url: URL?, modelURL: URL?, localeModelURL: URL?, name: String, description: String) {
        self.id = id //généré
        self.url = url // url locale -> url distant
        self.modelURL = modelURL //url locale -> url distant
        self.localModelURL = localeModelURL //méthode locale
        self.name = name
        self.description = description // init IA
    }
}
