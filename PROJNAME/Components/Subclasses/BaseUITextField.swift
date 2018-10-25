//
//  BaseUITextField.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 10/16/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

@IBDesignable public class BaseUITextField: UITextField, UITextFieldDelegate {
    
    private var presenter : UIView?
    private var scrollView : UIScrollView?
    
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
        print("focused")
        if let scroll = self.scrollView {
            scroll.setContentOffset(textField.frame.origin.applying(.init(translationX: 0, y: -20)), animated: true)
        }
    }
    open func textFieldDidEndEditing(_ textField: UITextField) {
        print("lost focus")
    }
    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    public func subscribeTo(_ scrollView:UIScrollView){
        scrollView.keyboardDismissMode = .onDrag
        self.scrollView = scrollView
    }
    
    ///tap gesture
    public func subscribeTo(_ view:UIView){
        presenter = view
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapEndEditingAction(_:))))
    }
    ///tap gesture action
    @objc func tapEndEditingAction(_ sender: UITextField) {
        if let view = presenter {
            view.endEditing(true)
        }
    }
    
    ///add toolbar with done button
    public func addToolbar(){
        let toolbar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: 0, height: 30))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem:    .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction(_:)))
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        
        self.inputAccessoryView = toolbar
    }
    ///done button toolbar action
    @objc func doneButtonAction(_ sender: UITextField) {
        if let view = presenter {
            view.endEditing(true)
        }
        if let scroll = self.scrollView {
            scroll.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
    }
    
    override public func layoutSubviews() {
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
