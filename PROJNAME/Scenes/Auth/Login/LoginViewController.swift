//
//  LoginViewController.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 10/22/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

class LoginViewController: BaseUIViewController {

    let backingView: UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = .white
        v.layer.shadow(5, 0.5, 10)
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
