//
//  CharacterViewModel.swift
//  MarvelComics
//
//  Created by admin on 3/10/22.
//

import UIKit

//MARK: ViewModel Protocols
protocol characterViewModelProtocol: AnyObject {
    
    func fetchListOfMarvelCharacters()
    func getErrorFrom(_ error: String)
    func getErrorCodeFromAPIResponse()
    
}

class CharacterViewModel {
    
    //MARK: Variables
    var characterDataModel: CharacterDataModel?
    weak var delegate: characterViewModelProtocol?
    private var publicKey = Utils.getAPIKeys()[KeyString.publicKey.rawValue] ?? ""
    private var privateKey = Utils.getAPIKeys()[KeyString.privateKey.rawValue] ?? ""
    
    //MARK: API Request to get Marvel Character List
    func getCharacterList() {
        let timeStamp = String(Int(Date().timeIntervalSinceNow))
        let hash = Utils.md5Hash("\(timeStamp)\(privateKey)\(publicKey)")
        let url = "\(baseUrl)characters?ts=\(timeStamp)&apikey=\(publicKey)&hash=\(hash)"
        
        MarvelAPIService.init().getRequest(url: url, completion: { jsonData, error, statuscode in
            
            if let error = error {
                self.delegate?.getErrorFrom(error.localizedDescription)
                return
            }
            
            if let statuscode = statuscode {
                if statuscode == 200, let responseData = jsonData {
                    let jsonDecoder = JSONDecoder()
                    self.characterDataModel = try? jsonDecoder.decode(CharacterDataModel.self, from: responseData)
                    self.delegate?.fetchListOfMarvelCharacters()
                } else {
                    self.delegate?.getErrorCodeFromAPIResponse()
                }
            }
        })
    }
}
