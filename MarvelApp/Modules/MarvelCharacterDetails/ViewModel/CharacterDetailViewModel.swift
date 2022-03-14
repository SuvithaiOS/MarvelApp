//
//  CharacterDetailModel.swift
//  MarvelComics
//
//  Created by admin on 3/10/22.
//

import Foundation

//MARK:- CharacterDetailViewModelProtocol Methods
protocol CharacterDetailViewModelProtocol: AnyObject {
    
    func getCharacterDetails()
    func getError(_ error: String)
    func getErrorCodeFromAPIResponse()
}

class CharacterDetailViewModel {
    
    //MARK:- Variables
    var comicsDataModel: ComicsDataModel?
    weak var delegate: CharacterDetailViewModelProtocol?
    private var publicKey = Utils.getAPIKeys()[KeyString.publicKey.rawValue] ?? ""
    private var privateKey = Utils.getAPIKeys()[KeyString.privateKey.rawValue] ?? ""
    var charcterId: String?
    
    //MARK:- Initializer
    init(id: String) {
        self.charcterId = id
    }
    
    //MARK:- Request for Marvel Character Comics API
    func getRequestCharacterComicsAPI() {
        
        let ts = String(Int(Date().timeIntervalSinceNow))
        let hash = Utils.md5Hash("\(ts)\(privateKey)\(publicKey)")
        let url = "\(baseUrl)characters/\(self.charcterId ?? "")/comics?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
        
        MarvelAPIService.init().getRequest(url: url, completion: { jsonData, error, statuscode in
            
            if let error = error {
                self.delegate?.getError(error.localizedDescription)
                return
            }
            
            if let statuscode = statuscode {
                if statuscode == 200, let responseData = jsonData {
                    let jsonDecoder = JSONDecoder()
                    self.comicsDataModel = try? jsonDecoder.decode(ComicsDataModel.self, from: responseData)
                    self.delegate?.getCharacterDetails()
                } else {
                    self.delegate?.getErrorCodeFromAPIResponse()
                }
            }
        })
    }
}
