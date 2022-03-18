//
//  MarvelCharacterTests.swift
//  MarvelCharacterTests
//
//  Created by admin on 3/10/22.
//

import XCTest
@testable import MarvelApp

class MarvelCharacterTests: XCTestCase {
    
    var characterModel: CharacterDataModel?
    var errorModel: ErrorHandlingModel?
    
    private var publicKey = Utils.getAPIKeys()[KeyString.publicKey.rawValue] ?? ""
    private var privateKey = Utils.getAPIKeys()[KeyString.privateKey.rawValue] ?? ""
    
    //MARK:- Test the get Characters request with passing empty key params.
    func testCharacterListApiResourceWithEmptyStringRturnsError() {
        
        let expectation = self.expectation(description: "PassingEmptyKeyParams")
        let url = "\(baseUrl)characters?ts=&apikey=&hash="
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
    
    //MARK:- Test the get Characters request with passing invalid key params
    func testCharacterListApiResourceWithInvalidHashParametersRturnsError() {
        
        let expectation = self.expectation(description: "PassingInvalidKeyParams")
        let url = "\(baseUrl)characters?ts=0000000&apikey=jdfsjafgsbfj3845839745983&hash=snbfjbf84r4nsdf4u57346372"
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
    
    //MARK:- Test the get Characters requeset without timeStamp
    func testCharacterListApiResourceWithMissingtsReturnsError() {
        
        let expectation = self.expectation(description: "missedTimeStamp")
        let ts = String(Int(Date().timeIntervalSinceNow))
        let hash = Utils.md5Hash("\(ts)\(privateKey)\(publicKey)")
        let url = "\(baseUrl)characters?apikey=\(publicKey)&hash=\(hash)"
        
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
    
    //MARK:- Test the get Characters with valid key params and timestamp
    func testCharacterListApiResourceWithvalidHashParametersReturnsCorrectResponse() {
        let expectation = self.expectation(description: "ValidKeyParamsAndTimestamp")
        let ts = String(Int(Date().timeIntervalSinceNow))
        
        let hash = Utils.md5Hash("\(ts)\(privateKey)\(publicKey)")
        let url = "\(baseUrl)characters?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
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
