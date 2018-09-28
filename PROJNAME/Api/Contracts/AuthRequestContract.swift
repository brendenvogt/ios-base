//
//  AuthRequestContract.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 9/27/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

public struct AuthRequestContract: Codable {
    static var SampleData = AuthRequestContract.SampleString.data(using: .utf8)!
    static var SampleString = """
        {
            "username": "brendenvogt",
            "password": "testpass"
        }
        """
    
    var username: String
    var password: String
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    enum CodingKeys: String, CodingKey {
        case username, password
    }
}
