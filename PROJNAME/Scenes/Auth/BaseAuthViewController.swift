//
//  BaseAuthViewController.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 10/24/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

class BaseAuthViewController: UIViewController {

    @objc func goPressed(_ sender: UIButton) {
        print("go")
        let vc = AuthViewController()
        let root = BaseUINavigationController(rootViewController: vc)
        root.isNavigationBarHidden = true
        
        self.present(root, animated: true) {
            print("presented auth")
        }
    }
    
    let loadButton : BaseUIButton = {
        let b = UIFactory.accentButton("Load auth")
        b.addTarget(self, action: #selector(goPressed(_:)), for: .touchUpInside)
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let height: CGFloat = 50.0
        
        
        self.view.addSubview(loadButton)
        loadButton.snapToSuperBottom(withInsets: .init(top: 0, left: 40, bottom: 100, right: 40))
        loadButton.cornerRadius = height / 2
        loadButton.setHeight(height)
    }


}
