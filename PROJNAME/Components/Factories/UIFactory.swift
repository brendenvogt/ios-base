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
    //ff7b00
    //ffbb00
    //ff3700
    
    ///accent1
    static let accentColor : UIColor = UIColor.init(hex: "ff3700") ?? UIFactory.defaultButtonColor
//    static let accentColor : UIColor = UIColor.init(hex: "0080D9") ?? UIFactory.defaultButtonColor
    
    ///accent2
    static let accentColor2 : UIColor = UIColor.init(hex: "ffbb00") ?? UIFactory.defaultButtonColor
//    static let accentColor2 : UIColor = UIColor.init(hex: "00a2d9") ?? UIFactory.defaultButtonColor
    
    static let highlighted : UIColor = UIColor.rgb(91, 14, 13)
//    static let highlighted : UIColor = UIColor.init(hex: "005590") ?? UIFactory.darkGrayColor
    
    static let grayColor : UIColor = UIColor(white: 0.8, alpha: 1.0)
    static let darkGrayColor : UIColor = UIColor(white: 0.3, alpha: 1.0)

    
    //labels
    private static let h1Size : CGFloat = 32.0
    private static let h2Size : CGFloat = 28.0
    private static let h3Size : CGFloat = 24.0
    private static let h4Size : CGFloat = 20.0
    private static let h5Size : CGFloat = 16.0
    private static let h6Size : CGFloat = 12.0

    private static func hLabel(fontSize : CGFloat) -> ((String) -> UILabel) {
        return { (text:String) -> UILabel in
            let l = UILabel(frame: .zero)
            l.font = .systemFont(ofSize: fontSize, weight: .black)
            l.textColor = .black
            l.text = text
            l.numberOfLines = 0
            return l
        }
    }
    
    private static func pLabel(fontSize : CGFloat) -> ((String) -> UILabel) {
        return { (text:String) -> UILabel in
            let l = UILabel(frame: .zero)
            l.font = .systemFont(ofSize: fontSize, weight: .light)
            l.textColor = .black
            l.text = text
            l.numberOfLines = 0
            return l
        }
    }
    
    static let h1Label = UIFactory.hLabel(fontSize: UIFactory.h1Size)
    static let h2Label = UIFactory.hLabel(fontSize: UIFactory.h2Size)
    static let h3Label = UIFactory.hLabel(fontSize: UIFactory.h3Size)
    static let h4Label = UIFactory.hLabel(fontSize: UIFactory.h4Size)
    static let h5Label = UIFactory.hLabel(fontSize: UIFactory.h5Size)
    static let h6Label = UIFactory.hLabel(fontSize: UIFactory.h6Size)
    
    static let p1Label = UIFactory.pLabel(fontSize: UIFactory.h1Size)
    static let p2Label = UIFactory.pLabel(fontSize: UIFactory.h2Size)
    static let p3Label = UIFactory.pLabel(fontSize: UIFactory.h3Size)
    static let p4Label = UIFactory.pLabel(fontSize: UIFactory.h4Size)
    static let p5Label = UIFactory.pLabel(fontSize: UIFactory.h5Size)
    static let p6Label = UIFactory.pLabel(fontSize: UIFactory.h6Size)
    
    
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
    
    private static func button(fontSize : CGFloat, topColor : UIColor, bottomColor : UIColor, titleColor: UIColor) -> ((String) -> BaseUIButton) {
        return { (text:String) -> BaseUIButton in
            let b = BaseUIButton(frame: .zero)
            b.topColor = topColor
            b.bottomColor = bottomColor
            b.gradientAngle = -35
            b.setTitleColor(titleColor, for: .normal)
            b.cornerRadius = buttonHeight/2
            b.setTitle(text, for: .normal)
            b.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize)
            return b
        }
    }
    
    static let standardButton = UIFactory.button(fontSize: UIFactory.h5Size, backgroundColor: defaultButtonColor, titleColor: .white)
    static let accentButton = UIFactory.button(fontSize: UIFactory.h5Size, topColor: UIFactory.accentColor, bottomColor: UIFactory.accentColor2, titleColor: .white)
    
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
    
    //stack view
    public static func stack(spacing: CGFloat, axis : NSLayoutConstraint.Axis, alignment: UIStackView.Alignment, distribution: UIStackView.Distribution) -> (() -> UIStackView) {
        return { () -> UIStackView in
            let s = UIStackView(frame: .zero)
            s.axis = axis
            s.distribution = distribution
            s.alignment = alignment
            s.spacing = spacing
            return s
        }
    }
    
    //gradient
    public static func gradient(top: UIColor, bottom : UIColor, angle: CGFloat) -> (() -> BaseUIView) {
        return { () -> BaseUIView in
            let g = BaseUIView(frame: .zero)
            g.topColor = top
            g.bottomColor = bottom
            g.gradientAngle = angle
            g.alpha = 1.0
            return g
        }
    }
    
    public static let accentGradient = gradient(top: UIFactory.accentColor, bottom: UIFactory.accentColor2, angle: 135)
    public static let grayGradient = gradient(top: .white, bottom: UIFactory.grayColor, angle: 90)

}
