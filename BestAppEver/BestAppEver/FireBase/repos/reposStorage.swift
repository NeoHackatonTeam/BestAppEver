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
    static let instance = ReposStorage()
    private init() {}
    
    let storage = Storage.storage()
    let urlStorage: String = "gs://bestappever-47608.appspot.com"
    
    func saveFile(localURL: URL, typeFile: FileType, completion: @escaping (Result<String, Error>) -> Void) {
        let storageRef = storage.reference(forURL: urlStorage)
        let fileName = UUID().uuidString + "_" + localURL.lastPathComponent
        let fileRef = storageRef.child(typeFile.toString() + "/" + fileName)
        let uploadTask = fileRef.putFile(from: localURL, metadata: nil) { (metadata, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(fileName))
                // Le fichier a été téléchargé avec succès
            }
        }

        uploadTask.observe(.progress) { snapshot in
            // Mise à jour de la progression
        }

        uploadTask.observe(.failure) { snapshot in
            if let error = snapshot.error {
                completion(.failure(error))
            }
        }
    }
    
    
    

    func loadFile(typeFile: FileType, nameFile: String, completion: @escaping (Result<URL, Error>) -> Void) {
        let storageRef = storage.reference(forURL: urlStorage)
        let islandRef = storageRef.child(typeFile.toString() + "/" + nameFile)

        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let localURL = documentsDirectory.appendingPathComponent(nameFile)

        if FileManager.default.fileExists(atPath: localURL.path) {
            completion(.success(localURL))
        } else {
            // Le fichier n'existe pas localement, on peut le télécharger
            let downloadTask = islandRef.write(toFile: localURL) {
                url, error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(localURL))
                }
            }
        }
    }

}
