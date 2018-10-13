//
//  SignupRequestContract.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 10/13/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

public struct SignupRequestContract: Codable {
    static var SampleData = SignupRequestContract.SampleString.data(using: .utf8)!
    static var SampleString = """
        {
            "email": "test@gmail.com",
            "password": "testpass"
            "passwordConfirm": "testpass"
        }
        """
    
    var email: String?
    var password: String?
    var passwordConfirm: String?

    public init(email: String, password: String, passwordConfirm: String) {
        self.email = email
        self.password = password
        self.passwordConfirm = passwordConfirm
    }
    
    enum CodingKeys: String, CodingKey {
        case email, password, passwordConfirm
    }
}
