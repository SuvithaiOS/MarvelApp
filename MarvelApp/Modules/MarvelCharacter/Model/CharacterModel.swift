//
//  CharacterModel.swift
//  MarvelComics
//
//  Created by admin on 3/10/22.
//

import Foundation


// MARK: - Decoder
struct CharacterDataModel: Decodable {
    
    var data: CharacterResultModel?
    var status: String?
}

struct CharacterResultModel: Decodable {
    
    var results: [CharacterModel]?
    
}

struct CharacterModel: Decodable {
    
    var id: Int?
    var name: String?
    var description: String?
    var thumbnail: ThumbnailUrl?
    
}

struct ThumbnailUrl: Decodable {
    
    var path: String?
    var imageExtension: String?
    
    enum CodingKeys: String, CodingKey {
        case path
        case imageExtension = "extension"
    }
}

struct ErrorHandlingModel: Decodable {
    
    let code: String?
    let message: String?
}
