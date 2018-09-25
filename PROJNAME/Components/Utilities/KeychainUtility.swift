//
//  KeychainUtility.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 9/25/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit
import Security

public struct KeychainKeys {
    public let kAuthToken = "kAuthToken"
    public let kRefreshToken = "kRefreshToken"
    public let kUserId = "kUserId"
}

class KeychainUtility {
    
    //todo: fix identifier access group with AppIdentifierPrefix
    //"xxxxxxxxxx.Noxford.Ios" $(AppIdentifierPrefix).Noxford.Ios
    fileprivate static let kKeychainAccessGroupName = ""
    
    class func set(key: String, value: String) -> Bool{
        if let data = value.data(using: .utf8){
            return set(key: key, value: data)
        }
        return false
    }
    
    class func set(key: String, value: Data) -> Bool{
        let query: [String: Any] = [
            (kSecClass as String) : kSecClassGenericPassword,
            (kSecAttrAccount as String) : key,
            (kSecValueData as String) : value,
            (kSecAttrAccessGroup as String): kKeychainAccessGroupName as Any
        ]
        
        SecItemDelete(query as CFDictionary)
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == noErr
    }
    
    class func get(key: String) -> String?{
        if let data = getData(key: key){
            return String.init(data: data as Data, encoding: .utf8)
        }
        return nil
    }
    
    class func getData(key: String) -> NSData?{
        let query: [String: Any] = [
            (kSecClass as String) : kSecClassGenericPassword,
            (kSecAttrAccount as String) : key,
            (kSecReturnData as String) : kCFBooleanTrue,
            (kSecMatchLimit as String) : kSecMatchLimitOne,
            (kSecAttrAccessGroup as String): kKeychainAccessGroupName as Any
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        if status == noErr && dataTypeRef != nil{
            return dataTypeRef as? NSData
        }
        return nil
    }
    
    class func delete(key: String) -> Bool{
        let query: [String: Any] = [
            (kSecClass as String) : kSecClassGenericPassword,
            (kSecAttrAccount as String) : key,
            (kSecAttrAccessGroup as String): kKeychainAccessGroupName as Any
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        return status == noErr
    }
    
    class func clear() -> Bool{
        let query = [
            (kSecClass as String) : kSecClassGenericPassword,
            (kSecAttrAccessGroup as String) : kKeychainAccessGroupName as Any
        ]
        let status = SecItemDelete(query as CFDictionary)
        
        return status == noErr
    }
}
