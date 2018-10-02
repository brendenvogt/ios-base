//
//  BoolContract.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 9/27/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

public struct BoolContract : Codable {
    static var SampleData = BoolContract.SampleString.data(using: .utf8)!
    static var SampleString = """
        {
            "result": true
        }
        """
    
    public init(response:Bool) {
        self.response = response
    }
    
    var response : Bool?
    
    enum CodingKeys: String, CodingKey {
        case response
    }
}
