//
//  MarvelCharacterDetailTests.swift
//  MarvelAppTests
//
//  Created by admin on 3/17/22.
//

import XCTest
@testable import MarvelApp

class MarvelCharacterDetailTests: XCTestCase {
    
    var characterModel: CharacterDataModel?
    var errorModel: ErrorHandlingModel?
    
    private var publicKey = Utils.getAPIKeys()[KeyString.publicKey.rawValue] ?? ""
    private var privateKey = Utils.getAPIKeys()[KeyString.privateKey.rawValue] ?? ""
    
    //MARK:- Test the get Character Detail request with empty key string
    func testCharacterDetailApiResourceWithEmptyStringRturnsError() {
        
        let expectation = self.expectation(description: "emptyString")
        let url = "\(baseUrl)characters/?ts=&apikey=&hash="
        
        MarvelAPIService.init().getRequest(url: url, completion: { jsonData, error, statuscode in
            
            if let data = jsonData {
                let jsonDecoder = JSONDecoder()
                self.errorModel = try? jsonDecoder.decode(ErrorHandlingModel.self, from: data)
                XCTAssertEqual(self.errorModel?.code, "ResourceNotFound")
                expectation.fulfill()
            }
        })
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    //MARK:- Test the get Character Detail request with invalid key params
    func testCharacterDetailApiResourceWithInvalidHashParametersRturnsError() {
        
        let expectation = self.expectation(description: "invalid")
        let url = "\(baseUrl)characters/-1?ts=4837722&apikey=sdjgfabsakdf37284&hash=sdvhfsgfwncxbz374672shadvhsa"
        
        MarvelAPIService.init().getRequest(url: url, completion: { jsonData, error, statuscode in
            
            if let data = jsonData {
                let jsonDecoder = JSONDecoder()
                self.errorModel = try? jsonDecoder.decode(ErrorHandlingModel.self, from: data)
                XCTAssertEqual(self.errorModel?.message, ErrorMessage.invalidAPIKey.rawValue)
                XCTAssertEqual(self.errorModel?.code, ErrorMessage.invalidCredetial.rawValue)
                expectation.fulfill()
            }
        })
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    //MARK:- Test the get Character Detail request with missing timestamp
    func testCharacterDetailApiResourceWithMissingtsReturnsError() {
        
        let expectation = self.expectation(description: "missedTimeStamp")
        let ts = String(Int(Date().timeIntervalSinceNow))
        let hash = Utils.md5Hash("\(ts)\(privateKey)\(publicKey)")
        let url = "\(baseUrl)characters/1011334?apikey=\(publicKey)&hash=\(hash)"
        
        MarvelAPIService.init().getRequest(url: url, completion: { jsonData, error, statuscode in
            
            if let data = jsonData {
                let jsonDecoder = JSONDecoder()
                self.errorModel = try? jsonDecoder.decode(ErrorHandlingModel.self, from: data)
                XCTAssertEqual(self.errorModel?.message, ErrorMessage.vaildTimeStamp.rawValue)
                XCTAssertEqual(self.errorModel?.code, ErrorMessage.missingParams.rawValue)
                expectation.fulfill()
            }
        })
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    //MARK:- Test Character Detail request with params
    func testCharacterDetailApiResourceWithvalidHashParametersReturnsCorrectResponse() {
        
        let expectation = self.expectation(description: "ValidKeyParamsAndTimestamp")
        let ts = String(Int(Date().timeIntervalSinceNow))
        
        let hash = Utils.md5Hash("\(ts)\(privateKey)\(publicKey)")
        let url = "\(baseUrl)characters/1011334?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
        MarvelAPIService.init().getRequest(url: url, completion: { jsonData, error, statuscode in
            
            if let data = jsonData {
                let jsonDecoder = JSONDecoder()
                self.characterModel = try? jsonDecoder.decode(CharacterDataModel.self, from: data)
                XCTAssertNotNil(self.characterModel?.data?.results)
                XCTAssertEqual(self.characterModel?.status, "Ok")
                expectation.fulfill()
            }
            
        })
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}
