//
//  IntExtensions.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 10/16/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

extension Int {
    
    static func random(_ upperBound:Int) -> Int{
        return Int(arc4random_uniform(UInt32(upperBound)))
    }
    
}
