//
//  AuthViewController.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 10/22/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

class AuthViewController: BaseUIViewController {

    @objc func signupPressed(_ sender: UIButton) {
        print("signup")
        let vc = SignupViewController()
        if let nav = self.navigationController{
            nav.pushViewController(vc, animated: true)
        }
    }
    
    @objc func loginPressed(_ sender: UIButton) {
        print("login")
        let vc = LoginViewController()
        if let nav = self.navigationController{
            nav.pushViewController(vc, animated: true)
        }
    }
    
    static let itemSpacing: CGFloat = 20

    let loginButton : BaseUIButton = {
        let b = UIFactory.standardButton("Log In")
        b.addTarget(self, action: #selector(loginPressed(_:)), for: .touchUpInside)
        return b
    }()
    
    let signupButton : BaseUIButton = {
        let b = UIFactory.accentButton("Sign Up")
        b.addTarget(self, action: #selector(signupPressed(_:)), for: .touchUpInside)
        return b
    }()
    
    let titleLabel = UIFactory.h1Label("Welcome")
    
    let stackView : UIStackView = {
        let s = UIStackView(frame: .zero)
        s.axis = .vertical
        s.distribution = .equalSpacing
        s.spacing = itemSpacing
        return s
    }()
    
    let backgroundImage: UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.alpha = 0.3
        return iv
    }()
    
    let gradientView: BaseUIView = {
        let g = BaseUIView(frame: .zero)
        g.topColor = .lightGray
        g.bottomColor = .darkGray
        g.gradientAngle = 70
        g.alpha = 0.5
        return g
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        ///setup background Image
//        setupBackgroundImage()
        
        ///setup stack view
        setupStackView()
        
        ///setup vc
        setupVc()
        
        ///rounded shadow view example
        //setupShadow()
        
    }

    func setupVc(){
        self.lightStatusBar = true
    }
    
    func setupBackgroundImage(){
        
        ///adding image
        self.view.insertSubview(backgroundImage, at: 0)
        backgroundImage.snapToSuper()
        let image = SampleImageUtility.grayscale(size: self.view?.bounds.size ?? CGSize(width: 300, height: 600))
        backgroundImage.kf.setImage(with: URL(string: image), placeholder: nil, options: [.transition(.fade(1))], progressBlock: nil, completionHandler: { (image, error, cacheType, URL) in
        })
        
        ///adding gradient view
        self.view.insertSubview(gradientView, at: 0)
        gradientView.snapToSuper()

    }
    func setupStackView(){
        ///add stack view
        self.view.addSubview(stackView)
        stackView.snapToSuperTop(withInsets:.init(top: 0, left: 40, bottom: 40, right: 40))

        ///add subviews to stackview
        stackView.addArrangedSubview(titleLabel)
        
        let s1 = UIFactory.spacerView()
        stackView.addArrangedSubview(s1)
        s1.setHeight(10)
        
        stackView.addArrangedSubview(signupButton)
        signupButton.setHeight(UIFactory.buttonHeight)
        stackView.addArrangedSubview(loginButton)
        loginButton.setHeight(UIFactory.buttonHeight)

    }
    
    func setupShadow(){
        ///shadow common
        let offset: CGFloat = 50.0
        let shadowOptions = ShadowOptions(offset: 10, opacity: 0.5, radius:30)
        let roundingOptions = RoundingOptions(radius:20)
        let shadowView = RoundedShadowView(.zero, shadowOptions, roundingOptions, nil)
        
        ///sample 1
        self.view.addSubview(shadowView)
        shadowView.snapToSuper(withOffset: offset)
        
        ///sample 2
        //        let blackView = UIView(frame: .zero)
        //        blackView.backgroundColor = UIColor(white: 0.2, alpha: 0.5)
        //        UIApplication.shared.keyWindow!.addSubview(blackView)
        //        blackView.snapToSuper()
        //        UIApplication.shared.keyWindow!.addSubview(shadowView)
        //        shadowView.snapToSuper(withOffset: offset)

    }
    
}
