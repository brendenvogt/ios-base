//
//  BaseUINavigationController.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 10/16/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

class BaseUINavigationController : UINavigationController {
    
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
    
    private var _navBarIsTranslucent: Bool = false
    @IBInspectable var navBarIsTranslucent: Bool{
        get{ return self._navBarIsTranslucent }
        set{
            self._navBarIsTranslucent = newValue
            self.navigationBar.isTranslucent = self._navBarIsTranslucent
        }
    }
    
    private var _navBarTintColor: UIColor = UIColor.white
    @IBInspectable var navBarTintColor: UIColor{
        get{ return self._navBarTintColor }
        set{
            self._navBarTintColor = newValue
            self.navigationBar.barTintColor = self._navBarTintColor
        }
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barTintColor = self._navBarTintColor
        self.navigationBar.isTranslucent = self._navBarIsTranslucent
    }
    
    override open var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {return UIStatusBarAnimation.slide}
    override open var prefersStatusBarHidden: Bool {return statusBarHidden}
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return self._lightStatusBar ? UIStatusBarStyle.lightContent : UIStatusBarStyle.default
    }
    
}
