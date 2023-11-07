//
//  ContentView.swift
//  BestAppEver
//
//  Created by Student04 on 07/11/2023.
//

import SwiftUI

//
//  ContentView.swift
//  BestAppEver
//
//  Created by Student04 on 07/11/2023.
//

import SwiftUI

import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) private var presentationMode
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        private let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let uiImage = info[.originalImage] as? UIImage {
                if let data = uiImage.jpegData(compressionQuality: 0.8),
                   let localURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("image.jpg") {
                    do {
                        try data.write(to: localURL)
                        print(localURL)
                        let reposStorage: ReposStorage = ReposStorage()
                        reposStorage.saveFile(localURL: localURL, typeFile: FileType.image) { (fileName, error) in
                            if let error = error {
                                print("Erreur lors de l'envoi de l'image : \(error.localizedDescription)")
                            } else {
                                print("Image envoyée avec succès")
                                if let fileName = fileName {
                                    print("nom du fichier : \(fileName)")
                                }
                            }
                        }
                    } catch {
                        print("Erreur lors de la création de l'URL locale : \(error.localizedDescription)")
                    }
                }
                
                parent.selectedImage = uiImage
            }

            parent.presentationMode.wrappedValue.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        // Nothing to do here
    }
}

struct ContentView: View {
    @State private var selectedImage: UIImage?

    var body: some View {
        VStack {
            
            TabView{
                Group{
                    LibrairyView()
                        .tabItem {
                            Image(systemName: "list.bullet")
                               
                        }
                    
                    OCMainView()
                        .tabItem {
                            Image(systemName: "camera")
                        }

                }
                .toolbarBackground(.black, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarColorScheme(.dark, for: .tabBar)
            }
            
            
            
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
            } else {
                Text("Aucune image sélectionnée")
            }

            Button("Sélectionner une image") {
                selectedImage = nil
            }.padding()

            ImagePicker(selectedImage: $selectedImage)
            
            Button(action: {
                
                let reposStorage: ReposStorage = ReposStorage()
                reposStorage.loadFile(typeFile: FileType.image, nameFile: "image.jpg", urlLocal: "path/to/your/Hackaton/") {
                    localPath, error in
                    if let error = error {
                        print("Erreur lors du téléchargement du fichier : \(error.localizedDescription)")
                    } else if let localPath = localPath {
                        print("Téléchargement réussi. Le fichier a été enregistré à l'emplacement : \(localPath)")
                    }
                }
                
            }) {
                Text("Lister les images")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}

#Preview {
    ContentView()
}
