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
    
    public class func secLogin(_ authToken:String?) -> Bool {
        CredentialStoreUtility.sharedInstance.authToken = authToken
        if let authToken = authToken {
            _ = KeychainUtility.set(key: KeychainKeys().kAuthToken, value: authToken)
        }
        return CredentialStoreUtility.isLoggedIn()
    }
    
    public class func secLoginFromKeychain() -> Bool {
        CredentialStoreUtility.sharedInstance.authToken = KeychainUtility.get(key: KeychainKeys().kAuthToken)
        return CredentialStoreUtility.isLoggedIn()
    }
    
    public class func secLogout() -> Bool {
        CredentialStoreUtility.sharedInstance.authToken = nil
        _ = KeychainUtility.delete(key: KeychainKeys().kAuthToken)
        return CredentialStoreUtility.isLoggedIn()
    }
    
}
