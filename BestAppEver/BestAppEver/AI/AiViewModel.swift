//
//  AiViewModel.swift
//  BestAppEver
//
//  Created by Tony Izzi on 08/11/2023.
//

import Foundation



class AiViewModel{
    
    let api_key = "7FCADDCD-EA27-409C-98B8-CF37895530370A00049C-B9AE-4DD8-8803-19151FD3E7EF"
    
    func askToAi(item: FBDataModel, action: (FBDataModel) -> Void){
        
        let jsonData = [
            "tkn": api_key,
            "modelVersion": "2.1_full",
            "input": item.urlImage,
            "visionParams": "describe_all",
            "gpt_prompt": "",
            "gpt_length": "125"
        ] as [String : Any]
        
        let data = try! JSONSerialization.data(withJSONObject: jsonData, options: [])
        
        let url = URL(string: "https://vision.astica.ai/describe")!
        let headers = [
            "Content-Type": "application/json"
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = data as Data
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
            } else if let data = data {
                
                let product = try? JSONDecoder().decode(AiModel.self, from: data)
                item.description = product?.caption.text ?? "Mode free is Over"
                action(item)
                
            }
        }
        
        task.resume()
    }
}
