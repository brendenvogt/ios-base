//
//  LoginViewController.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 10/22/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

class LoginViewController: BaseUIViewController {
    
    static let itemSpacing: CGFloat = 15
    static let itemHeight: CGFloat = 30
    static let buttonHeight: CGFloat = 50
    
    @objc func goPressed(_ sender: UIButton) {
        print("go")
        if let nav = self.navigationController{
            nav.dismiss(animated: true) {
                print("dismissed")
            }
        }
    }
    
    @objc func cancelPressed(_ sender: UIButton) {
        print("cancel")
        if let nav = self.navigationController{
            nav.popViewController(animated: true)
        }
    }
    
    @objc func morePressed(_ sender: UIButton) {
        print("more")
        
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
        l.font = .systemFont(ofSize: 30, weight: .black)
        l.textColor = .black
        l.text = "Log In"
        return l
    }()
    
    let titleImage : UIImageView = {
        let v = UIImageView(frame: .zero)
        v.tintColor = UIColor.init(hex: "84CCF6")
        v.image = UIImage(named: "ic_home_48pt")?.withRenderingMode(.alwaysTemplate)
        return v
    }()
    
    let spacerView : UIView = {
        let v = UIView(frame:.zero)
        v.backgroundColor = .clear
        return v
    }()
    
    let signupButton : BaseUIButton = {
        let b = BaseUIButton(frame: .zero)
        b.backgroundColor = UIColor.init(hex: "84CCF6")
        b.cornerRadius = buttonHeight/2
        b.setTitleColor(.white, for: .normal)
        b.setTitle("Log In  >", for: .normal)
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
    
    let stackNav : UIStackView = {
        let s = UIStackView(frame: .zero)
        s.axis = .horizontal
        s.distribution = .equalSpacing
        return s
    }()
    
    let cancelButton : UIButton = {
        let b = UIButton(frame: .zero)
        b.setTitle("Back", for: .normal)
        b.setTitleColor(.darkGray, for: .normal)
        b.addTarget(self, action: #selector(cancelPressed(_:)), for: .touchUpInside)
        return b
    }()
    
    let moreButton : UIButton = {
        let b = UIButton(frame: .zero)
        b.setTitle("More", for: .normal)
        b.setTitleColor(.darkGray, for: .normal)
        b.addTarget(self, action: #selector(morePressed(_:)), for: .touchUpInside)
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        ///stackview
        setupStackView()
    }
    
    func setupStackView(){
        self.view.addSubview(stackNav)
        stackNav.snapToSuperTop(withInsets:.init(top: 0, left: 15, bottom: 0, right: 15))
        stackNav.setHeight(50)
        stackNav.addArrangedSubview(cancelButton)
        stackNav.addArrangedSubview(titleImage)
        stackNav.addArrangedSubview(moreButton)
        
        ///add stack view
        self.view.addSubview(stackView)
        stackView.snapToSuperTop(withInsets:.init(top: 15, left: 15, bottom: 80, right: 15))
        
        ///add subviews to stackview
        stackView.addArrangedSubview(titleLabel)
        
        stackView.addArrangedSubview(spacerView)
        spacerView.setHeight(20)
        
        stackView.addArrangedSubview(usernameTextfield)
        stackView.addArrangedSubview(passwordTextfield)
        stackView.addArrangedSubview(signupButton)
        titleLabel.setHeight(SignupViewController.itemHeight)
        usernameTextfield.setHeight(SignupViewController.itemHeight)
        passwordTextfield.setHeight(SignupViewController.itemHeight)
        signupButton.setHeight(SignupViewController.buttonHeight)
        
    }
}
