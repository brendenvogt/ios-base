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
        let b = BaseUIButton(frame: .zero)
        b.backgroundColor = UIColor.init(hex: "84CCF6")
        b.setTitleColor(.white, for: .normal)
        b.cornerRadius = 10
        b.setTitle("load auth", for: .normal)
        b.addTarget(self, action: #selector(goPressed(_:)), for: .touchUpInside)
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.view.addSubview(loadButton)
        loadButton.snapToSuper(withInsets: UIEdgeInsets(top: 100, left: 50, bottom: 100, right: 50))
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
