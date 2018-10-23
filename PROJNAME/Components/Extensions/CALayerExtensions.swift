//
//  CALayerExtensions.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 9/25/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

public struct ShadowOptions {
    var offset: CGFloat
    var opacity: Float
    var radius: CGFloat
}

public struct BorderOptions {
    var color: UIColor
    var width: CGFloat
}

public struct RoundingOptions {
    var radius: CGFloat
}

extension CALayer {
    func shadow(_ options:ShadowOptions) {
        self.shadowOffset = .init(width: 0, height: options.offset)
        self.shadowOpacity = options.opacity
        self.shadowRadius = options.radius
        self.shadowPath = UIBezierPath(rect: bounds).cgPath;
        self.shadowColor = UIColor.black.cgColor
        self.masksToBounds = false
    }
    
    func shadow(_ offset:CGFloat,_ opacity:Float,_ radius:CGFloat) {
        self.shadowOffset = .init(width: 0, height: offset)
        self.shadowOpacity = opacity
        self.shadowRadius = radius
        self.shadowPath = UIBezierPath(rect: bounds).cgPath;
        self.shadowColor = UIColor.black.cgColor
        self.masksToBounds = false
    }
    
    func cornerRadius(_ radius: CGFloat) {
        self.cornerRadius = radius
        self.masksToBounds = true
    }
}
