//
//  reposStorage.swift
//  BestAppEver
//
//  Created by Student01 on 07/11/2023.
//

import Foundation
import FirebaseStorage

enum FileType: String {
    case image
    case objet3d
    case autre
}

extension FileType {
    func toString() -> String {
        return self.rawValue
    }
}


class ReposStorage {
    let storage = Storage.storage()
    let urlStorage : String = "gs://bestappever-47608.appspot.com"
    
    
    func saveFile(localURL: URL, typeFile: FileType, completion: @escaping (String?, Error?) -> Void) {
        let storageRef = storage.reference(forURL: urlStorage)
        let fileName = UUID().uuidString + "_" + localURL.lastPathComponent
        let fileRef = storageRef.child(typeFile.toString() + "/" + fileName)
        let uploadTask = fileRef.putFile(from: localURL, metadata: nil) { (metadata, error) in
            if let error = error {
                completion(nil, error)
            } else {
                completion(fileName, nil)
                // Le fichier a été téléchargé avec succès
            }
        }

        uploadTask.observe(.progress) { snapshot in
            // Mise à jour de la progression
        }

        uploadTask.observe(.failure) { snapshot in
            if let error = snapshot.error {
                completion(nil, error)
            }
        }
    }

    func loadFile(typeFile: FileType, nameFile: String, urlLocal: String, completion: @escaping (String?, Error?) -> Void) {
        let storageRef = storage.reference(forURL: urlStorage)
        let islandRef = storageRef.child(typeFile.toString() + "/" + nameFile)

        // Utilisez directement l'URL fournie dans urlLocal
        let localURL = URL(fileURLWithPath: urlLocal)

        let downloadTask = islandRef.write(toFile: localURL) { url, error in
            if let error = error {
                completion(nil, error)
            } else {
                completion(localURL.path, nil)
            }
        }
    }

}
