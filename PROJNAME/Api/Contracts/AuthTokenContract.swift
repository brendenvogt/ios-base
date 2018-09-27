//
//  AuthTokenContract.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 9/27/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit
import Foundation

//https://medium.com/whoknows-swift/swift-4-decodable-encodable-3085305a9618
//https://medium.com/@phillfarrugia/encoding-and-decoding-json-with-swift-4-3832bf21c9a8

public struct AuthTokenContract: Codable {
    static var Sample = """
        {
            "authToken": "auth aaa123",
            "refreshToken": "refresh aaa123"
        }
        """.data(using: .utf8)!

    var authToken: String
    var refreshToken: String
    
    init(authToken: String, refreshToken: String) {
        self.authToken = authToken
        self.refreshToken = refreshToken
    }
    
    enum CodingKeys: String, CodingKey {
        case authToken, refreshToken
    }
}
