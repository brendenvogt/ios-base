//
//  LoginViewController.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 10/22/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

class LoginViewController: BaseUIViewController {
    
    static let itemSpacing: CGFloat = 20
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
        t.setEmailTextEntry()
        return t
    }()
    
    let passwordTextfield : BaseUITextField = {
        let t = BaseUITextField(frame: .zero)
        t.underscoreColor = .lightGray
        t.underscoreHeight = 0.5
        let placeholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        t.attributedPlaceholder = placeholder
        t.setPasswordTextEntry()
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
        v.contentMode = .scaleAspectFit
        v.image = UIImage(named: "ic_home_48pt")?.withRenderingMode(.alwaysTemplate)
        return v
    }()
    
    let spacerView = { () -> UIView in
        let v = UIView(frame:.zero)
        v.backgroundColor = .clear
        return v
    }
    
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
        s.alignment = .fill
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
    
    let scrollView : UIScrollView = {
        let s = UIScrollView(frame: .zero)
        
        return s
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        ///stackview
        setupStackView()
        
    }
    
    private let navHeight : CGFloat = 70.0
    private let inset : CGFloat = 15.0
    
    func setupStackView(){
        
        //nav bar view
        view.addSubview(stackNav)
        stackNav.snapToSuperTop(withInsets:.init(top: 0, left: inset, bottom: 0, right: inset))
        stackNav.setHeight(navHeight)
        stackNav.addArrangedSubview(cancelButton)
        stackNav.addSubview(titleImage)
        stackNav.addArrangedSubview(moreButton)
        titleImage.snapToSuperCenter()
        titleImage.setHeight(navHeight - 20)
        
        ///MAIN
        
        //add stack view
        view.addSubview(scrollView)
        scrollView.snapToSuper(withInsets: .init(top: navHeight + 20, left: 0, bottom: 0, right: 0), override: true)
        
        scrollView.addSubview(stackView)
        stackView.snapToSuper(withInsets: .init(top: 0, left: inset, bottom: inset, right: inset), override: true)
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -2.0 * inset).isActive = true
        
        //spacer
        let s1 = spacerView()
        stackView.addArrangedSubview(s1)
        s1.setHeight(15)
        
        //title
        stackView.addArrangedSubview(titleLabel)
        
        //spacer 2
        let s2 = spacerView()
        stackView.addArrangedSubview(s2)
        s2.setHeight(40)
        
        //username
        stackView.addArrangedSubview(usernameTextfield)
        usernameTextfield.subscribeTo(view)
        usernameTextfield.addToolbar()
        usernameTextfield.subscribeTo(scrollView)
        
        //password
        stackView.addArrangedSubview(passwordTextfield)
        passwordTextfield.subscribeTo(view)
        passwordTextfield.addToolbar()
        passwordTextfield.subscribeTo(scrollView)
        
        //signup button
        stackView.addArrangedSubview(signupButton)
        signupButton.setHeight(SignupViewController.buttonHeight)
        
        //bottom spacer
        let bs = spacerView()
        stackView.addArrangedSubview(bs)
        bs.setHeight(30)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = CGSize(width: stackView.frame.width, height: max(stackView.frame.height, view.frame.height-navHeight))
    }
    
}
