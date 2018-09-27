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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sample = AuthRequestContract.SampleString
        if let fromJson = AuthController.getAuthFromJson(json: sample) {
            print("success json")
            print(fromJson)
        }else {
            print("result json failed")
        }
        
        
        let authRequest = AuthRequestContract(username: "brendenvogt", password: "testpass")
        if let result = AuthController.getAuth(credentials: authRequest) {
            print("success")
            print(result)
        }else {
            print("result failed")
        }
    }

}

