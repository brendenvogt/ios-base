//
//  ErrorContract.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 9/27/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

public struct ErrorContract : Codable {
    static var SampleData = ErrorContract.SampleString.data(using: .utf8)!
    static var SampleString = """
        {
            "message": "Sample error message",
            "code": 1
        }
        """
    
    public init(message: String, code: Int) {
        self.message = message
        self.code = code
    }
    
    var message: String?
    var code: Int?
    
    enum CodingKeys: String, CodingKey {
        case message, code
    }
}
