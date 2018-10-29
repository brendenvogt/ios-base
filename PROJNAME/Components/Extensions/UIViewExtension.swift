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
    
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
    func snapToSuper(withOffset offset: CGFloat = 0, override: Bool = false){
        if let superView = self.superview {
            self.translatesAutoresizingMaskIntoConstraints = false
            self.topAnchor.constraint(equalTo: superView.topAnchor, constant: offset).isActive = true
            self.leftAnchor.constraint(equalTo: superView.leftAnchor, constant: offset).isActive = true
            self.rightAnchor.constraint(equalTo: superView.rightAnchor, constant: -offset).isActive = true
            if #available(iOS 11, *), !override {
                let guide = superView.safeAreaLayoutGuide
                self.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -offset).isActive = true
            }else{
                self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -offset).isActive = true
            }
        }
    }
    
    func snapToSuper(withInsets insets: UIEdgeInsets, override:Bool = false){
        if let superView = self.superview {
            self.translatesAutoresizingMaskIntoConstraints = false
            self.topAnchor.constraint(equalTo: superView.topAnchor, constant: insets.top).isActive = true
            self.leftAnchor.constraint(equalTo: superView.leftAnchor, constant: insets.left).isActive = true
            self.rightAnchor.constraint(equalTo: superView.rightAnchor, constant: -insets.right).isActive = true
            if #available(iOS 11, *), !override {
                let guide = superView.safeAreaLayoutGuide
                self.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -insets.bottom).isActive = true
            }else{
                self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -insets.bottom).isActive = true
            }
        }
    }
    
    func snapToSuperBottom(withInsets insets: UIEdgeInsets = .zero){
        if let superView = self.superview {
            self.translatesAutoresizingMaskIntoConstraints = false
            self.topAnchor.constraint(greaterThanOrEqualTo: superView.topAnchor, constant: insets.top).isActive = true
            self.leftAnchor.constraint(equalTo: superView.leftAnchor, constant: insets.left).isActive = true
            self.rightAnchor.constraint(equalTo: superView.rightAnchor, constant: -insets.right).isActive = true
            if #available(iOS 11, *) {
                let guide = superView.safeAreaLayoutGuide
                self.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -insets.bottom).isActive = true
            }else{
                self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -insets.bottom).isActive = true
            }
        }
    }
    
    func snapToSuperCenter(override:Bool = false){
        if let superView = self.superview {
            self.translatesAutoresizingMaskIntoConstraints = false
            self.centerXAnchor.constraint(lessThanOrEqualTo: superView.centerXAnchor, constant: 0).isActive = true
            if #available(iOS 11, *), !override {
                let guide = superView.safeAreaLayoutGuide
                self.centerYAnchor.constraint(equalTo: guide.centerYAnchor, constant: 0).isActive = true
            }else{
                self.centerYAnchor.constraint(equalTo: superView.centerYAnchor, constant: 0).isActive = true
            }
        }
    }
    
    func snapToWidth(override:Bool = false){
        if let superView = self.superview {
            self.translatesAutoresizingMaskIntoConstraints = false
            if #available(iOS 11, *), !override {
                let guide = superView.safeAreaLayoutGuide
                self.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: 0).isActive = true
                self.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: 0).isActive = true
            }else{
                self.rightAnchor.constraint(equalTo: superView.rightAnchor, constant: 0).isActive = true
                self.leftAnchor.constraint(equalTo: superView.leftAnchor, constant: 0).isActive = true
            }
        }
    }
    
    func snapToSuperTop(withInsets insets: UIEdgeInsets = .zero){
        if let superView = self.superview {
            self.translatesAutoresizingMaskIntoConstraints = false
            self.bottomAnchor.constraint(lessThanOrEqualTo: superView.bottomAnchor, constant: -insets.top).isActive = true
            self.leftAnchor.constraint(equalTo: superView.leftAnchor, constant: insets.left).isActive = true
            self.rightAnchor.constraint(equalTo: superView.rightAnchor, constant: -insets.right).isActive = true
            if #available(iOS 11, *) {
                let guide = superView.safeAreaLayoutGuide
                self.topAnchor.constraint(equalTo: guide.topAnchor, constant: insets.bottom).isActive = true
            }else{
                self.topAnchor.constraint(equalTo: superView.topAnchor, constant: insets.bottom).isActive = true
            }
        }
    }
    
    func setHeight(_ height:CGFloat){
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
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
