//
//  ComicsModel.swift
//  MarvelApp
//
//  Created by admin on 3/10/22.
//

import UIKit


// MARK: - Decoder
struct ComicsDataModel: Decodable {
    
    var data: ComicsResultModel?
}

struct ComicsResultModel: Decodable {
    
    var results: [ComicsModel]?
    
}

struct ComicsModel: Decodable {
    
    var title: String?
    var issueNumber: Int?
    var thumbnail: ThumbnailUrl?
    
}
