//
//  AuthController.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 9/27/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

class AuthController: NSObject {

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
