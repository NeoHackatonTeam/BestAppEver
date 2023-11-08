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
    
    let db: Firestore
    let aiPrompt: AiViewModel
    let namespaceCollection = "objects"
    
    
    init(){
        db = Firestore.firestore()
        aiPrompt = AiViewModel()
    }
    
    
    func startEncode(_ item: FBDataModel){
        //TODO: Utiliser la réponse de l'IA pour remplir la description
        aiPrompt.askToAi(item: item){item in
            addToDatabase(item)
        }
    }
    
    private func addToDatabase(_ item: FBDataModel){
        var ref: DocumentReference? = nil
        ref = db.collection(namespaceCollection).addDocument(data: [
            "name": item.name,
            "description": item.description,
            "url_image": item.urlImage,
            "url_model": item.urlModele])
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
            urlImage: document.get("url_image") as! String,
            urlModele: document.get("url_model") as! String,
            name: document.get("name") as! String,
            description: document.get("description") as! String)
        
        result.id = document.documentID
        
        return result
        
    }
}
