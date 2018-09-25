//
//  CALayerExtensions.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 9/25/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

extension CALayer {
    func addShadow(offset:CGFloat, opacity:Float, radius:CGFloat) {
        self.shadowOffset = .init(width: 0, height: offset)
        self.shadowOpacity = opacity
        self.shadowRadius = radius
        self.shadowPath = UIBezierPath(rect: bounds).cgPath;
        self.shadowColor = UIColor.black.cgColor
        self.masksToBounds = false
    }
    
    func roundCorners(radius: CGFloat) {
        self.cornerRadius = radius
        self.masksToBounds = true
    }
}
