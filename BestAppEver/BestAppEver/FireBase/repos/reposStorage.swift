//
//  reposStorage.swift
//  BestAppEver
//
//  Created by Student01 on 07/11/2023.
//

import Foundation
import FirebaseStorage

class ReposStorage {
    let storage = Storage.storage()
    
    func saveFile(localURL: URL, completion: @escaping (Error?) -> Void) {
        
        let storageRef = storage.reference(forURL: "gs://bestappever-eee4a.appspot.com")
        let fileName = localURL.lastPathComponent
        let fileRef = storageRef.child("object3d/" + fileName)
        let uploadTask = fileRef.putFile(from: localURL, metadata: nil) { (metadata, error) in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
                // Le fichier a été téléchargé avec succès
            }
        }
        
        uploadTask.observe(.progress) { snapshot in
            // Mise à jour de la progression
        }
        
        uploadTask.observe(.failure) { snapshot in
            if let error = snapshot.error {
                completion(error)
            }
        }
    }
    
    func loadFile(nameFile: String, urlLocal: String, completion: @escaping (String?, Error?) -> Void) {
        let storageRef = storage.reference(forURL: "gs://bestappever-eee4a.appspot.com")
        let islandRef = storageRef.child("object3d/" + nameFile)
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let localURL = documentsDirectory.appendingPathComponent(nameFile)

        let downloadTask = islandRef.write(toFile: localURL) { url, error in
            if let error = error {
                completion(nil, error)
            } else {
                completion(localURL.path, nil)
            }
        }
    }

}
