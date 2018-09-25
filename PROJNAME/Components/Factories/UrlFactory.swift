//
//  UrlFactory.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 9/24/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

class UrlFactory: NSObject {

    public class func baseProtocolSecure() -> String {
        return "https://"
    }
    
    public class func baseProtocol() -> String {
        return "http://"
    }
    
    public class func baseUrl() -> String {
        let debug = true
        if debug {
            return baseProtocol() + "localhost:5000/"
        }
    }
    
    /// Base url api endpoints
    public class func api() -> String {
        return baseUrl() + "api/"
    }
    
}
