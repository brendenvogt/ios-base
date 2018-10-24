//
//  SignupViewController.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 10/22/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

class SignupViewController: BaseUIViewController {

    static let itemSpacing: CGFloat = 15
    static let itemHeight: CGFloat = 30
    static let buttonHeight: CGFloat = 50

    @objc func goPressed(_ sender: UIButton) {
        print("go")
    }
    
    let usernameTextfield : BaseUITextField = {
        let t = BaseUITextField(frame: .zero)
        t.underscoreColor = .lightGray
        t.underscoreHeight = 0.5
        let placeholder = NSAttributedString(string: "Phone, email or username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        t.attributedPlaceholder = placeholder
        return t
    }()
    
    let passwordTextfield : BaseUITextField = {
        let t = BaseUITextField(frame: .zero)
        t.underscoreColor = .lightGray
        t.underscoreHeight = 0.5
        let placeholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        t.attributedPlaceholder = placeholder
        return t
    }()
    
    let titleLabel : UILabel = {
        let l = UILabel(frame: .zero)
        l.font = .systemFont(ofSize: 40, weight: .black)
        l.textColor = .black
        l.text = "Welcome"
        return l
    }()
    
    let signupButton : BaseUIButton = {
        let b = BaseUIButton(frame: .zero)
        b.backgroundColor = UIColor.init(hex: "84CCF6")
        b.cornerRadius = buttonHeight/2
        b.setTitleColor(.white, for: .normal)
        b.setTitle("Create Account  >", for: .normal)
        b.addTarget(self, action: #selector(goPressed(_:)), for: .touchUpInside)
        return b
    }()
    
    let stackView : UIStackView = {
        let s = UIStackView(frame: .zero)
        s.axis = .vertical
        s.distribution = .equalSpacing
        s.spacing = itemSpacing
        return s
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        ///stackview
        setupStackView()
        
    }

    func setupStackView(){
        ///add stack view
        self.view.addSubview(stackView)
        stackView.snapToSuperTop(withInsets:.init(top: 40, left: 40, bottom: 80, right: 40))
        
        ///add subviews to stackview
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(usernameTextfield)
        stackView.addArrangedSubview(passwordTextfield)
        stackView.addArrangedSubview(signupButton)
        titleLabel.setHeight(SignupViewController.itemHeight)
        usernameTextfield.setHeight(SignupViewController.itemHeight)
        passwordTextfield.setHeight(SignupViewController.itemHeight)
        signupButton.setHeight(SignupViewController.buttonHeight)
        
    }
    
}
