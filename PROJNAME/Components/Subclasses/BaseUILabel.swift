//
//  BaseUILabel.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 10/16/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

@IBDesignable class BaseUILabel: UILabel {
    
    private let gradientLayer = CAGradientLayer()
    
    @IBInspectable var topColor: UIColor = UIColor.clear{
        didSet{
            configureGradient()
        }
    }
    @IBInspectable var bottomColor: UIColor = UIColor.clear{
        didSet{
            configureGradient()
        }
    }
    @IBInspectable var gradientAngle: CGFloat = 0.0{
        didSet{
            configureGradient()
        }
    }
    @IBInspectable var gradientOpacity: CGFloat = 1.0{
        didSet{
            configureGradient()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(gradientLayer)
        configureGradient()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.addSublayer(gradientLayer)
        configureGradient()
    }
    
    override func layoutSubviews() {
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
        gradientLayer.opacity = Float(gradientOpacity)
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func updateColors() {
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
    }
    
    var _buttonPadding: CGFloat = 50
    @IBInspectable var buttonPadding: CGFloat {
        get {
            return _buttonPadding
        }
        set {
            _buttonPadding = newValue
        }
    }
    
    //button padding
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + buttonPadding, height: size.height)
    }
    
    //animation
    func animateTouchUpInside(completion: @escaping () -> Void) {
        isUserInteractionEnabled = false
        layer.masksToBounds = true
        
        let fillLayer = CALayer()
        fillLayer.backgroundColor = layer.borderColor
        fillLayer.frame = layer.bounds
        layer.insertSublayer(fillLayer, at: 0)
        
        let center = CGPoint(x: fillLayer.bounds.midX, y: fillLayer.bounds.midY)
        let radius: CGFloat = max(frame.width / 2 , frame.height / 2)
        
        let circularAnimation = BaseCircularRevealAnimator(layer: fillLayer, center: center, startRadius: 0, endRadius: radius)
        circularAnimation.duration = 0.2
        circularAnimation.completion = {
            fillLayer.opacity = 0
            let opacityAnimation = CABasicAnimation(keyPath: "opacity")
            opacityAnimation.fromValue = 1
            opacityAnimation.toValue = 0
            opacityAnimation.duration = 0.2
            opacityAnimation.delegate = BaseAnimationDelegate {
                fillLayer.removeFromSuperlayer()
                self.isUserInteractionEnabled = true
                completion()
            }
            fillLayer.add(opacityAnimation, forKey: "opacity")
        }
        circularAnimation.start()
    }
        
}
