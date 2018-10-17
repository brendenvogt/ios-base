//
//  BaseUIView.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 10/16/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

@IBDesignable public class BaseUIView: UIView {
    
    private let gradientLayer = CAGradientLayer()
    
    @IBInspectable var topColor: UIColor = UIColor.clear
    @IBInspectable var bottomColor: UIColor = UIColor.clear
    @IBInspectable var gradientAngle: CGFloat = 0.0{
        didSet{
            configureGradient()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureGradient()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureGradient()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = bounds
    }
    
    private func configureGradient() {
        let newx = cos(gradientAngle * CGFloat(Double.pi) / 180.0)*sqrt(2)
        let newy = sin(gradientAngle * CGFloat(Double.pi) / 180.0)*sqrt(2)
        let minmaxx = min(max(newx,-1),1)
        let minmaxy = min(max(newy,-1),1)
        gradientLayer.startPoint = CGPoint(x: (1-minmaxx)*0.5, y: (1-minmaxy)*0.5)
        gradientLayer.endPoint = CGPoint(x: (1+minmaxx)*0.5, y: (1+minmaxy)*0.5)
        updateColors()
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func updateColors() {
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
    }
}
