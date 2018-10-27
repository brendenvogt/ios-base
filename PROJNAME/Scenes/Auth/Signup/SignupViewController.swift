//
//  SignupViewController.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 10/22/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

class SignupViewController: BaseUIViewController {

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
    
    let usernameTextfield = UIFactory.usernameTextfield("Phone, email or username")
    let passwordTextfield = UIFactory.passwordTextfield("Password")
    let passwordConfirmTextfield = UIFactory.passwordTextfield("Password Confirm")
    
    let titleLabel : UILabel = UIFactory.h1Label("Sign Up")
    
    let titleImage : UIImageView = {
        let v = UIImageView(frame: .zero)
        v.tintColor = UIColor.init(hex: "84CCF6")
        v.contentMode = .scaleAspectFit
        v.image = UIImage(named: "ic_home_48pt")?.withRenderingMode(.alwaysTemplate)
        return v
    }()

    let signupButton : BaseUIButton = {
        let b = UIFactory.accentButton("Create Account  >")
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
        let s1 = UIFactory.spacerView()
        stackView.addArrangedSubview(s1)
        s1.setHeight(15)

        //title
        stackView.addArrangedSubview(titleLabel)

        //spacer 2
        let s2 = UIFactory.spacerView()
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
        
        //password confirm
        stackView.addArrangedSubview(passwordConfirmTextfield)
        passwordConfirmTextfield.subscribeTo(view)
        passwordConfirmTextfield.addToolbar()
        passwordConfirmTextfield.subscribeTo(scrollView)
        
        //signup button
        stackView.addArrangedSubview(signupButton)
        signupButton.setHeight(UIFactory.buttonHeight)
        
        //bottom spacer
        let bs = UIFactory.spacerView()
        stackView.addArrangedSubview(bs)
        bs.setHeight(30)

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = CGSize(width: stackView.frame.width, height: max(stackView.frame.height, view.frame.height-navHeight))
    }
    
}
