//
//  LoginViewController.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 10/22/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

class LoginViewController: BaseUIViewController, UIGestureRecognizerDelegate {
    
    static let itemSpacing: CGFloat = 20
    static let itemHeight: CGFloat = 30
    
    private let navHeight : CGFloat = 70.0
    private let inset : CGFloat = 30.0
    
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
    
    @objc func forgotPasswordAction(_ sender: UIBarButtonItem) {
        print("forgot password")
    }
    
    @objc func doneAction(_ sender: UIBarButtonItem) {
        print("done with keyboard")
        self.view.endEditing(true)
    }
    
    let usernameTextfield : BaseUITextField = {
        let t = UIFactory.usernameTextfield("Phone, email or username")
        return t
    }()
    
    let passwordTextfield : BaseUITextField = {
        let t = UIFactory.passwordTextfield("Password")
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
        v.tintColor = UIFactory.accentColor
        v.contentMode = .scaleAspectFit
        v.image = UIImage(named: "ic_home_48pt")?.withRenderingMode(.alwaysTemplate)
        return v
    }()
    
    let signupButton : BaseUIButton = {
        let b = UIFactory.accentButton("Log In  >")
        b.addTarget(self, action: #selector(goPressed(_:)), for: .touchUpInside)
        return b
    }()
    
    let stackView : UIStackView = UIFactory.stack(spacing: LoginViewController.itemSpacing, axis: .vertical, alignment: .fill, distribution: .equalSpacing)()
    let stackNav : UIStackView = UIFactory.stack(spacing: 0, axis: .horizontal, alignment: .center, distribution: .equalSpacing)()
    
    let backButton : UIButton = {
        let b = UIButton(frame: .zero)
        b.setTitle("Back", for: .normal)
        b.setTitleColor(UIFactory.darkGrayColor, for: .normal)
        b.addTarget(self, action: #selector(cancelPressed(_:)), for: .touchUpInside)
        return b
    }()
    
    let moreButton : UIButton = {
        let b = UIButton(frame: .zero)
        b.setTitle("More", for: .normal)
        b.setTitleColor(UIFactory.darkGrayColor, for: .normal)
        b.addTarget(self, action: #selector(morePressed(_:)), for: .touchUpInside)
        return b
    }()
    
    let scrollView : UIScrollView = {
        let s = UIScrollView(frame: .zero)
        
        return s
    }()
    
    let forgotPasswordButton = { () -> UIBarButtonItem in
        let b = UIBarButtonItem(title: "Forgot Password?", style: .plain, target: self, action: #selector(forgotPasswordAction(_:)))
        b.tintColor = UIFactory.accentButtonColor
        return b
    }
    
    let doneButton = { () -> UIBarButtonItem in
        let b = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneAction(_:)))
        b.tintColor = UIFactory.accentButtonColor
        return b
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        ///stackview
        setupStackView()
        
    }

    func setupStackView(){
        
        //nav bar view
        view.addSubview(stackNav)
        stackNav.snapToSuperTop(withInsets:.init(top: 0, left: inset, bottom: 0, right: inset))
        stackNav.setHeight(navHeight)
        stackNav.addArrangedSubview(backButton)
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
        let s1 = UIFactory.spacerView()
        stackView.addArrangedSubview(s1)
        s1.setHeight(10)
        
        //title
        stackView.addArrangedSubview(titleLabel)
        
        //spacer 2
        let s2 = UIFactory.spacerView()
        stackView.addArrangedSubview(s2)
        s2.setHeight(10)
        
        //username
        stackView.addArrangedSubview(usernameTextfield)
        usernameTextfield.subscribeTo(view)
        usernameTextfield.addToolbar(leftButton: forgotPasswordButton(), rightButton: doneButton())
        //usernameTextfield.subscribeTo(scrollView)
        
        //password
        stackView.addArrangedSubview(passwordTextfield)
        passwordTextfield.subscribeTo(view)
        passwordTextfield.addToolbar(leftButton: forgotPasswordButton(), rightButton: doneButton())
        //passwordTextfield.subscribeTo(scrollView)
        
        //signup button
        stackView.addArrangedSubview(signupButton)
        signupButton.setHeight(UIFactory.buttonHeight)
        
        //bottom spacer
        let bs = UIFactory.spacerView()
        stackView.addArrangedSubview(bs)
        bs.setHeight(180)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = CGSize(width: stackView.frame.width, height: max(stackView.frame.height, view.frame.height-navHeight))
    }
    
}
