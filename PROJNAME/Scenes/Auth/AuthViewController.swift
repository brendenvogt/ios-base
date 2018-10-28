//
//  AuthViewController.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 10/22/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

class AuthViewController: BaseUIViewController {
    
    static let itemSpacing: CGFloat = 20
    
    @objc func signupPressed(_ sender: UIButton) {
        print("signup")
        let vc = SignupViewController()
        if let nav = self.navigationController{
            nav.interactivePopGestureRecognizer?.delegate = vc as UIGestureRecognizerDelegate
            nav.interactivePopGestureRecognizer?.isEnabled = true
            nav.pushViewController(vc, animated: true)
        }
    }
    
    @objc func loginPressed(_ sender: UIButton) {
        print("login")
        let vc = LoginViewController()
        if let nav = self.navigationController{
            nav.interactivePopGestureRecognizer?.delegate = vc as UIGestureRecognizerDelegate
            nav.interactivePopGestureRecognizer?.isEnabled = true
            nav.pushViewController(vc, animated: true)
        }
    }
    
    @objc func pageChanged(_ sender: UIPageControl){
        guard let vcs = self.pageViewController.viewControllers, let firstViewController = vcs.first, let index = self.viewcontrollers.index(of: firstViewController) else {
            return
        }
        if sender.currentPage > index {
            self.pageViewController.next(animated: true, completion: nil)
            return
        }
        if sender.currentPage < index {
            self.pageViewController.previous(animated: true, completion: nil)
            return
        }
    }
    
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
    
    let stackView : UIStackView = UIFactory.stack(spacing: AuthViewController.itemSpacing, axis: .vertical, alignment: .fill, distribution: UIStackView.Distribution.fill)()
    
    let backgroundImage: UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.alpha = 0.3
        return iv
    }()
    
    let gradientView: BaseUIView = UIFactory.accentGradient()
    
    let pageViewController : UIPageViewController = {
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        return vc
    }()
    
    let pageControl : UIPageControl = {
        let p = UIPageControl(frame: .zero)
        p.currentPage = 0
        p.pageIndicatorTintColor = UIColor.init(white: 0.88, alpha: 1.0)
        p.currentPageIndicatorTintColor = UIColor.gray
        p.hidesForSinglePage = true
        return p
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        ///pageViewController
        setupPageViewController()
        
        ///setup background Image
        //setupBackgroundImage()
        
        ///setup stack view
        setupStackView()
        
        ///setup vc
        setupVc()
        
        ///rounded shadow view example
        //setupShadow()
        
    }

    let viewcontrollers : [UIViewController] = {
        let v1 = OnboardingViewController(image: "iphone8", title: String.lorem(min: 4, max: 9), subtitle: .lorem(min: 10, max: 20))
        let v2 = OnboardingViewController(image: "heart", title: String.lorem(min: 4, max: 9), subtitle: .lorem(min: 10, max: 20))
        let v3 = OnboardingViewController(image: "pay", title: String.lorem(min: 4, max: 9), subtitle: .lorem(min: 10, max: 20))
        let v4 = OnboardingViewController(image: "checkmark", title: String.lorem(min: 4, max: 9), subtitle: .lorem(min: 10, max: 20))
        return [v1,v2,v3,v4]
    }()
    
    func setupPageViewController(){
        
        pageViewController.delegate = self
        pageViewController.dataSource = self
        guard let vc = viewcontrollers.first else {
            return
        }
        pageViewController.setViewControllers([vc], direction: .forward, animated: true, completion: nil)
        pageControl.addTarget(self, action: #selector(pageChanged(_:)), for: .valueChanged)
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
        stackView.snapToSuper(withInsets:.init(top: 40, left: 40, bottom: 40, right: 40))
        
        ///welcome label
        stackView.addArrangedSubview(titleLabel)
        
        ///page view
        self.addChild(pageViewController)
        stackView.addArrangedSubview(pageViewController.view)
        
        ///page control
        stackView.addArrangedSubview(pageControl)
        pageControl.numberOfPages = viewcontrollers.count
        pageControl.setContentHuggingPriority(.required, for: .horizontal)
        
        ///buttons
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
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        var hidden = true
        switch UIDevice.current.orientation{
        case .portrait,.portraitUpsideDown:
            hidden = false
        case .landscapeLeft, .landscapeRight:
            hidden = true
        default:
            hidden = true
        }
        self.pageViewController.view.isHidden = hidden
        pageControl.isHidden = hidden
    }
    
}

extension AuthViewController : UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let first = pageViewController.viewControllers?.first{
            if let index = viewcontrollers.index(of: first){
                self.pageControl.isHidden = false
                self.pageControl.currentPage = index
                return
            }
        }
        self.pageControl.isHidden = true
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return viewcontrollers.count
    }
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = self.viewcontrollers.first, let firstViewControllerIndex = self.viewcontrollers.index(of: firstViewController) else {
                return 0
        }
        return firstViewControllerIndex
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = viewcontrollers.index(of: viewController) else {
            return nil
        }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {
            return nil
        }
        guard viewcontrollers.count > previousIndex else {
            return nil
        }
        return viewcontrollers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = viewcontrollers.firstIndex(of: viewController) else {
            return nil
        }
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = viewcontrollers.count
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        return viewcontrollers[nextIndex]
    }
    
}

extension UIPageViewController {
    func next(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        if let currentViewController = viewControllers?.first {
            if let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentViewController) {
                setViewControllers([nextPage], direction: .forward, animated: animated, completion: completion)
            }
        }
    }
    func previous(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        if let currentViewController = viewControllers?.first {
            if let nextPage = dataSource?.pageViewController(self, viewControllerBefore: currentViewController) {
                setViewControllers([nextPage], direction: .reverse, animated: animated, completion: completion)
            }
        }
    }
}
