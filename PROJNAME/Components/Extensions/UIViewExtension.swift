//
//  UIViewExtension.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 9/25/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

extension UIView {
    
    class func instantiateFromNib<T: UIView>() -> T {
        return UINib(nibName: "\(self)", bundle: nil).instantiate(withOwner: nil, options: nil).first as! T
    }
    
    func snapToSuper(withInsets insets: UIEdgeInsets = .zero){
        if let superView = self.superview {
            self.translatesAutoresizingMaskIntoConstraints = false
            self.topAnchor.constraint(equalTo: superView.topAnchor, constant: insets.top).isActive = true
            self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -insets.bottom).isActive = true
            self.leftAnchor.constraint(equalTo: superView.leftAnchor, constant: insets.left).isActive = true
            self.rightAnchor.constraint(equalTo: superView.rightAnchor, constant: -insets.right).isActive = true
            if #available(iOS 11, *) {
                let guide = superView.safeAreaLayoutGuide
                self.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -insets.bottom).isActive = true
            }
        }
    }
    
    func snapToSuperBottom(withInsets insets: UIEdgeInsets = .zero){
        if let superView = self.superview {
            self.translatesAutoresizingMaskIntoConstraints = false
            self.topAnchor.constraint(greaterThanOrEqualTo: superView.topAnchor, constant: insets.top).isActive = true
            self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -insets.bottom).isActive = true
            self.leftAnchor.constraint(equalTo: superView.leftAnchor, constant: insets.left).isActive = true
            self.rightAnchor.constraint(equalTo: superView.rightAnchor, constant: -insets.right).isActive = true
            if #available(iOS 11, *) {
                let guide = superView.safeAreaLayoutGuide
                self.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -insets.bottom).isActive = true
            }
        }
    }
    
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
            return UIColor(cgColor:layer.borderColor ?? UIColor.clear.cgColor) 
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
}
