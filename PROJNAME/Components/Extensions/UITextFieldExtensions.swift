//
//  UITextFieldExtensions.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 10/25/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

extension UITextField {
    func setPasswordTextEntry(){
        self.autocapitalizationType = .none
        self.autocorrectionType = .no
        self.spellCheckingType = .no
        self.keyboardType = .default
        self.keyboardAppearance = .dark
        self.returnKeyType = .next
        self.isSecureTextEntry = true
        
        if #available(iOS 11.0, *) {
            self.smartDashesType = .no
            self.smartInsertDeleteType = .no
            self.smartQuotesType = .no
            self.textContentType = UITextContentType.password
        } else {
            // Fallback on earlier versions
        }
    }
    
    func setEmailTextEntry(){
        self.textContentType = UITextContentType.emailAddress
        self.autocapitalizationType = .none
        self.autocorrectionType = .no
        self.spellCheckingType = .no
        self.keyboardType = .emailAddress
        self.keyboardAppearance = .dark
        self.returnKeyType = .next
        self.isSecureTextEntry = false
        
        if #available(iOS 11.0, *) {
            self.smartDashesType = .no
            self.smartInsertDeleteType = .no
            self.smartQuotesType = .no
        } else {
            // Fallback on earlier versions
        }
    }
}
