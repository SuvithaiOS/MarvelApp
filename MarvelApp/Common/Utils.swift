//
//  Utils.swift
//  MarvelComics
//
//  Created by admin on 3/10/22.
//

import Foundation
import UIKit
import CryptoKit

enum KeyString: String {
    case publicKey
    case privateKey
}

enum ErrorString: String {
    case error = "Error",
         serverMsg = "Wrong with the credentials",
         internetIssue = "Internet issue",
         connectToInternet = "Please connect to internet"
}


class Utils: NSObject {
    
    //MARK:- Genrate hash from Cryptokit
    class func md5Hash(_ source: String) -> String {
        let digest = Insecure.MD5.hash(data: source.data(using: .utf8) ?? Data())
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
    
    //MARK:- Get Keys from Marvel Plist file
    class func getAPIKeys() -> [String: Any] {
        if let path = Bundle.main.path(forResource: "MarvelPlist", ofType: "plist") {
            let plist = NSDictionary(contentsOfFile: path) ?? ["":""]
            let publicKey = plist[KeyString.publicKey.rawValue] as! String
            let privateKey = plist[KeyString.privateKey.rawValue] as! String
            let dict = [KeyString.publicKey.rawValue: publicKey, KeyString.privateKey.rawValue: privateKey]
            return dict
            
        }
        return ["": ""]
        
    }
    
    //MARK:- Set corner radius for Cell background view
    func setCornerRadius(view: UIView) {
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        
    }
    
    //MARK:- Show Error Message Alert
    func showAlertView(title : String,messsage: String)  {
        let alertController = UIAlertController(title: title, message: messsage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
        }
        alertController.addAction(okAction)
    }
    
}
