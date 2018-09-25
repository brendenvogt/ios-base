//
//  HeaderFactory.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 9/25/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

class HeaderFactory: NSObject {
    public class func GetAuthHeader() -> [String:String]{
        var value = "Bearer "
        value += CredentialStoreUtility.isLoggedIn() ? CredentialStoreUtility.secAuthToken() : ""
        return ["Authorization": value]
    }
}

