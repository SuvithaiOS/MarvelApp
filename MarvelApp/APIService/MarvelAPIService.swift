//
//  MarvelAPIService.swift
//  MarvelComics
//
//  Created by admin on 3/10/22.
//

import UIKit
import Foundation
import SystemConfiguration

var baseUrl = "https://gateway.marvel.com/v1/public/"

class MarvelAPIService: NSObject {
    
    //MARK: Marvel Characters Get API Request
    func getRequest(url : String,completion:@escaping (_ jsonData:Data? , _ error:Error?, _ statuscode: Int?) -> ()) {
        
        if InternetConnectCheckClass.isConnectedToNetwork() {
            let request = URLRequest(url: URL.init(string: url)!)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.async {
                    guard let httpResponse = response as? HTTPURLResponse else{return}
                    if let error = error {
                        completion(nil,error,httpResponse.statusCode)
                        return
                    }
                    guard let responseData = data else {
                        return
                    }
                    if httpResponse.statusCode == 200 {
                        completion(responseData,nil,httpResponse.statusCode)
                    } else {
                        completion(responseData,nil,httpResponse.statusCode)
                    }
                }
            }
            task.resume()
        }
        else {
            Utils().showAlertView(title: ErrorString.internetIssue.rawValue, messsage: ErrorString.connectToInternet.rawValue)
        }
    }
}

class InternetConnectCheckClass {
    
    //MARK: Check Network Connectivity method
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
        
    }
}
