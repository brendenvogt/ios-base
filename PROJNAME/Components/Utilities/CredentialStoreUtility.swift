//
//  CredentialStoreUtility.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 9/25/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

class CredentialStoreUtility: NSObject {
    
    var authToken: String? = nil
    
    static let sharedInstance = CredentialStoreUtility()
    
    public class func isLoggedIn() -> Bool {
        return CredentialStoreUtility.sharedInstance.authToken != nil
    }
    
    public class func secAuthToken() -> String {
        return CredentialStoreUtility.sharedInstance.authToken ?? "";
    }
    
    public class func secLogin(_ authToken:String?) {
        CredentialStoreUtility.sharedInstance.authToken = authToken
        if let authToken = authToken {
            _ = KeychainUtility.set(key: KeychainKeys().kAuthToken, value: authToken)
        }
    }
    
    public class func secLoginFromKeychain() {
        CredentialStoreUtility.sharedInstance.authToken = KeychainUtility.get(key: KeychainKeys().kAuthToken)
    }
    
    public class func secLogout() -> Bool {
        CredentialStoreUtility.sharedInstance.authToken = nil
        let success = KeychainUtility.delete(key: KeychainKeys().kAuthToken)
        return success
    }
    
}
