//
//  BaseUITextField.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 10/16/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

@IBDesignable public class BaseUITextField: UITextField, UITextFieldDelegate {
    
    private var _underscoreHeight: CGFloat = 0.0
    @IBInspectable public var underscoreHeight: CGFloat {
        get {
            return self._underscoreHeight
        }
        set {
            if newValue == -1 {
                self._underscoreHeight = 1
            }else{
                self._underscoreHeight = newValue
            }
        }
    }
    
    private var _underscoreColor: UIColor = .white
    @IBInspectable public var underscoreColor: UIColor {
        get {
            return self._underscoreColor
        }
        set {
            self._underscoreColor = newValue
        }
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        delegate = self
    }
    
    required public override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
        
    }
    
    open func textFieldDidBeginEditing(_ textField: UITextField) {
//        print("focused")
    }
    open func textFieldDidEndEditing(_ textField: UITextField) {
//        print("lost focus")
    }
    
    override public func layoutSubviews() {
        let str = NSAttributedString(string: self.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor:UIColor.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)])
        self.attributedPlaceholder = str
        
        super.layoutSubviews()
        if self.underscoreHeight != 0 {
            let border = CALayer()
            border.frame = CGRect(x: 0, y: self.frame.size.height - self.underscoreHeight, width:  self.frame.size.width, height: self.underscoreHeight)
            border.backgroundColor = self.underscoreColor.cgColor
            border.shadowColor = UIColor.clear.cgColor
            self.layer.addSublayer(border)
        }
    }
}
