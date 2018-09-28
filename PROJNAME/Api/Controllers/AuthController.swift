//
//  AuthController.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 9/27/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

class AuthController: NSObject {
    
    public class func getApi(completion: @escaping (BoolContract?, ErrorContract?) -> Void) {
        Alamofire.request(UrlFactory.api()).responseJSON { response in
            if let error: ErrorContract? = try? JSONDecoder().decode(ErrorContract.self, from: json.data(using: .utf8)!)
            if let result: BoolContract? = try? JSONDecoder().decode(BoolContract.self, from: json.data(using: .utf8)!)
            completion(result, error)
        }
    }
    
    static func getAuthFromJson(json : String) -> AuthRequestContract? {
        if let decoded = try? JSONDecoder().decode(AuthRequestContract.self, from: json.data(using: .utf8)!) {
            return decoded
        }
        return nil
    }
    
    static func getAuth(credentials : AuthRequestContract) -> AuthRequestContract? {
        if let encoded = try? JSONEncoder().encode(credentials){
            if let decoded = try? JSONDecoder().decode(AuthRequestContract.self, from: encoded) {
                return decoded
            }
        }
        return nil
    }
}
