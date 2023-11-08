//
//  DatabaseViewModel.swift
//  BestAppEver
//
//  Created by Tony Izzi on 07/11/2023.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
      

class DatabaseViewModel{
    
    static var instance = DatabaseViewModel()
    
    let db: Firestore
    let aiPrompt: AiViewModel
    let namespaceCollection = "objects"
    
    
    init(){
        db = Firestore.firestore()
        aiPrompt = AiViewModel()
    }
    
    
    func addToDatabase(_ image: String, _ model: String, name: String){
        var ref: DocumentReference? = nil
        ref = db.collection(namespaceCollection).addDocument(data: [
            "name": name,
            "description": aiPrompt.askToAi(urlImage: image),
            "url_image": image,
            "url_model": model])
        { err in
          if let err = err {
            print("Error adding document: \(err)")
          } else {
            print("Document added with ID: \(ref!.documentID)")
          }
        }
    }
    
    func getListToDatabase() -> [FBDataModel]{
        var listModel = [FBDataModel]()
        
        db.collection(namespaceCollection).getDocuments() {
            (querySnapshot, err) in
          if let err = err {
            print("Error getting documents: \(err)")
          } else {
            for document in querySnapshot!.documents {
                listModel.append(self.createDataModel(document: document))
            }
          }
        }
        
        return listModel
    }
    
    private func createDataModel(document: QueryDocumentSnapshot) -> FBDataModel{
        
         var result = FBDataModel(
            id: document.documentID,
            urlImage: document.get("url_image") as! String,
            urlModele: document.get("url_model") as! String,
            name: document.get("name") as! String,
            description: document.get("description") as! String)
        
        
        
        return result
        
    }
}
