//
//  UIFactory.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 10/27/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

class UIFactory: NSObject {
    
    //colors
    static let accentColor : UIColor  = UIColor.init(hex: "0080D9") ?? UIFactory.defaultButtonColor
    static let grayColor : UIColor = UIColor(white: 0.8, alpha: 1.0)
    static let darkGrayColor : UIColor = UIColor(white: 0.3, alpha: 1.0)

    
    //labels
    private static let h1Size : CGFloat = 32.0
    private static let h2Size : CGFloat = 28.0
    private static let h3Size : CGFloat = 24.0
    private static let h4Size : CGFloat = 20.0
    private static let h5Size : CGFloat = 16.0
    private static let h6Size : CGFloat = 12.0

    private static func label(fontSize : CGFloat) -> ((String) -> UILabel) {
        return { (text:String) -> UILabel in
            let l = UILabel(frame: .zero)
            l.font = .systemFont(ofSize: fontSize, weight: .black)
            l.textColor = .black
            l.text = text
            return l
        }
    }
    
    static let h1Label = UIFactory.label(fontSize: UIFactory.h1Size)
    static let h2Label = UIFactory.label(fontSize: UIFactory.h2Size)
    static let h3Label = UIFactory.label(fontSize: UIFactory.h3Size)
    static let h4Label = UIFactory.label(fontSize: UIFactory.h4Size)
    static let h5Label = UIFactory.label(fontSize: UIFactory.h5Size)
    static let h6Label = UIFactory.label(fontSize: UIFactory.h6Size)
    
    //buttons
    static let buttonHeight : CGFloat = 40.0
    static let defaultButtonColor : UIColor = UIFactory.grayColor
    static let accentButtonColor : UIColor = UIFactory.accentColor
    
    private static func button(fontSize : CGFloat, backgroundColor : UIColor, titleColor: UIColor) -> ((String) -> BaseUIButton) {
        return { (text:String) -> BaseUIButton in
            let b = BaseUIButton(frame: .zero)
            b.backgroundColor = backgroundColor
            b.setTitleColor(titleColor, for: .normal)
            b.cornerRadius = buttonHeight/2
            b.setTitle(text, for: .normal)
            b.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize)
            return b
        }
    }
    
    static let standardButton = UIFactory.button(fontSize: UIFactory.h5Size, backgroundColor: defaultButtonColor, titleColor: .white)
    static let accentButton = UIFactory.button(fontSize: UIFactory.h5Size, backgroundColor: accentButtonColor, titleColor: .white)
    
    //text fields
    private enum TextFieldType {
        case login
        case password
    }
    
    private static func textField(type:TextFieldType) -> ((String) -> BaseUITextField) {
        return { (placeholder:String) -> BaseUITextField in
            let t = BaseUITextField(frame: .zero)
            t.underscoreColor = .lightGray
            t.underscoreHeight = 0.5
            let placeholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
            t.attributedPlaceholder = placeholder
            switch type {
            case .login:
                t.setEmailTextEntry()
            case .password:
                t.setPasswordTextEntry()
            }
            return t
        }
    }
    
    static let usernameTextfield = UIFactory.textField(type: .login)
    static let passwordTextfield = UIFactory.textField(type: .password)

    //spacer
    static let spacerView = { () -> UIView in
        let v = UIView(frame:.zero)
        v.backgroundColor = .clear
        return v
    }
    
}
