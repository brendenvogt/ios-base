//
//  UIColorExtensions.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 9/25/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

#if os(iOS) || os(tvOS)

import UIKit


extension UIColor {
    
    static func rgb(_ red: CGFloat,_ green: CGFloat,_ blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }

    var coreImageColor: CIColor {
        return CIColor(color: self)
    }
    
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        let coreImageColor = self.coreImageColor
        return (coreImageColor.red, coreImageColor.green, coreImageColor.blue, coreImageColor.alpha)
    }
    
    func isDarkColor() -> Bool {
        let luminate: CGFloat = 0.2126 * components.red + 0.7152 * components.green + 0.0722 * components.blue
        if luminate < 0.5 { return true }
        return false
    }
    
    func isDistinct(_ compareColor: UIColor) -> Bool {
        
        let (r, g, b, a) = components
        let (r1, g1, b1, a1) = compareColor.components
        
        let threshold1: CGFloat = 0.25
        guard abs(r - r1) > threshold1 ||
            abs(g - g1) > threshold1 ||
            abs(b - b1) > threshold1 ||
            abs(a - a1) > threshold1 else { return false }
        
        // check for grays, prevent multiple gray colors
        let threshold2: CGFloat = 0.03
        guard abs( r - g ) < threshold2 &&
            abs( r - b ) < threshold2 &&
            abs(r1 - g1) < threshold2 &&
            abs(r1 - b1) < threshold2 else { return true }
        
        return false
    }
    
    func color(withMinimumSaturation minSaturation: CGFloat) -> UIColor {
        
        var hue: CGFloat = 0, saturation: CGFloat = 0, brightness: CGFloat = 0, alpha: CGFloat = 0
        getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        
        if saturation < minSaturation {
            return UIColor(hue: hue, saturation: minSaturation, brightness: brightness, alpha: alpha)
        } else {
            return self
        }
    }
    
    func isBlackOrWhite() -> Bool {
        
        let (r, g, b, _) = components
        
        // isWhite
        if r > 0.91 &&
            g > 0.91 &&
            b > 0.91 {
            return true
        }
        
        // isBlack
        if r < 0.09 &&
            g < 0.09 &&
            b < 0.09 {
            return true
        }
        
        return false
    }
    
    func isContrastingColor(_ color: UIColor) -> Bool {
        
        let (r, g, b, _) = components
        let (r2, g2, b2, _) = color.components
        
        let bLum: CGFloat = 0.2126 * r + 0.7152 * g + 0.0722 * b
        let fLum: CGFloat = 0.2126 * r2 + 0.7152 * g2 + 0.0722 * b2
        
        var contrast: CGFloat = 0.0
        if bLum > fLum {
            contrast = (bLum + 0.05) / (fLum + 0.05)
        } else {
            contrast = (fLum + 0.05) / (bLum + 0.05)
        }
        //return contrast > 3.0; //3-4.5 W3C recommends a minimum ratio of 3:1
        return contrast > 1.6
    }
    
}

extension UIColor {
    
    public convenience init(r: UInt8, g: UInt8 , b: UInt8 , a: UInt8) {
        self.init(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: CGFloat(a)/255)
    }
    
    public convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    
    public convenience init?(hex: String, alpha: CGFloat = 1.0) {
        var formatted = hex.replacingOccurrences(of: "0x", with: "")
        formatted = formatted.replacingOccurrences(of: "#", with: "")
        if let hex = Int(formatted, radix: 16) {
            let red = CGFloat(CGFloat((hex & 0xFF0000) >> 16)/255.0)
            let green = CGFloat(CGFloat((hex & 0x00FF00) >> 8)/255.0)
            let blue = CGFloat(CGFloat((hex & 0x0000FF) >> 0)/255.0)
            self.init(red: red, green: green, blue: blue, alpha: alpha)        } else {
            return nil
        }
    }
    
    public convenience init(gray: CGFloat, alpha: CGFloat = 1.0) {
        self.init(white: gray, alpha: alpha)
    }
    
    public var redComponent: Int {
        var r: CGFloat = 0
        getRed(&r, green: nil, blue: nil, alpha: nil)
        return Int(r * 255)
    }
    
    public var greenComponent: Int {
        var g: CGFloat = 0
        getRed(nil, green: &g, blue: nil, alpha: nil)
        return Int(g * 255)
    }
    
    public var blueComponent: Int {
        var b: CGFloat = 0
        getRed(nil, green: nil, blue: &b, alpha: nil)
        return Int(b * 255)
    }
    
    public var alpha: CGFloat {
        var a: CGFloat = 0
        getRed(nil, green: nil, blue: nil, alpha: &a)
        return a
    }
    
    public static func random(randomAlpha: Bool = false) -> UIColor {
        let randomRed = CGFloat.random
        let randomGreen = CGFloat.random
        let randomBlue = CGFloat.random
        let alpha = randomAlpha ? CGFloat.random : 1.0
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: alpha)
    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}

#endif
