//
//  HomeViewController.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 9/24/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var viewModel : HomeViewModel?
    
    var label : UILabel = {
        let l = UILabel(frame: .zero)
        l.text = "hello"
        l.font = .boldSystemFont(ofSize: 14)
        l.textAlignment = .center
        l.numberOfLines = -1
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(label)
        label.snapToSuper()

        /// signup example
        let email = "test\(Date())@gmail.com"
        let password = "testpass"
        let signup = SignupRequestContract(email: email, password: password, passwordConfirm: password)
        UserController.userSignup(signup: signup) { (result, error) in
            if let error = error {
                print(error)
            }
            if let result = result {
                print(result)
                self.label.text = String(result.token ?? "")
            }
        }
        
        /// api example
        //        ApiController.getApi(completion: { (result, err) in
        //            if let err = err {
        //                print(err)
        //            }
        //            if let result = result {
        //                print(result)
        //                self.label.text = String(result.response ?? false)
        //            }
        //        })
    }
}

