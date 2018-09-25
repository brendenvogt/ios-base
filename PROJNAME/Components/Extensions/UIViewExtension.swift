//
//  UIViewExtension.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 9/25/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

extension UIView {
    
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            if newValue == -1 {
                layer.cornerRadius = min(self.frame.size.width/2,self.frame.size.height/2)
            }else{
                layer.cornerRadius = newValue
            }
            layer.masksToBounds = newValue != 0
        }
    }
    
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            if newValue == -1 {
                layer.borderWidth = 1
            }else{
                layer.borderWidth = newValue
            }
        }
    }
    
    var borderColor: UIColor {
        get {
            return self.borderColor
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
}
