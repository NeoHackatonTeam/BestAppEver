//
//  ModelAi.swift
//  BestAppEver
//
//  Created by Tony Izzi on 08/11/2023.
//
import Foundation

struct AiModel: Decodable{
    let caption: CaptionModel
}

struct CaptionModel: Decodable{
    let text: String
}
