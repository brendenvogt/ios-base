//
//  NSObjectExtensions.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 10/15/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

extension UIView {
    var className: String {
        return String(describing: type(of: self)).components(separatedBy: ".").last!
    }
    
    class var className: String {
        return String(describing: self).components(separatedBy: ".").last!
    }
}
