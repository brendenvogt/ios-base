//
//  BaseUIViewController.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 10/16/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

open class BaseUIViewController: UIViewController {
    
    private var _statusBarHidden: Bool = false
    @IBInspectable var statusBarHidden: Bool{
        get{ return self._statusBarHidden }
        set{
            self._statusBarHidden = newValue
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    private var _lightStatusBar: Bool = false
    @IBInspectable var lightStatusBar: Bool{
        get{ return self._lightStatusBar }
        set{
            self._lightStatusBar = newValue
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override open var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {return UIStatusBarAnimation.slide}
    override open var prefersStatusBarHidden: Bool {return statusBarHidden}
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return self._lightStatusBar ? UIStatusBarStyle.lightContent : UIStatusBarStyle.default
    }
    
}
