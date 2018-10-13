//
//  LoginRequestContract.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 9/27/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

public struct LoginRequestContract: Codable {
    static var SampleData = LoginRequestContract.SampleString.data(using: .utf8)!
    static var SampleString = """
        {
            "email": "test@gmail.com",
            "password": "testpass"
        }
        """
    
    var email: String?
    var password: String?
    
    public init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    enum CodingKeys: String, CodingKey {
        case email, password
    }
}
