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
    
    
    
    @objc func buttonClicked(button:UIButton){
        print("\(button.tag) button clicked")
    }
    
    func nibExample(){
        // sample list view
        let listView: ListView = ListView.instantiateFromNib()
        view.addSubview(listView)
        listView.snapToSuperBottom()
        listView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        // sample button
        var button = UIButton(frame: .zero)
        button.setTitle("Blue Button", for: .normal)
        button.backgroundColor = .blue
        button.tag = 0
        button.addTarget(self, action: #selector(buttonClicked(button:)), for: .touchUpInside)
        listView.stackView.addArrangedSubview(button)
        
        // sample button
        button = UIButton(frame: .zero)
        button.setTitle("Green Button", for: .normal)
        button.backgroundColor = .green
        button.tag = 1
        button.addTarget(self, action: #selector(buttonClicked(button:)), for: .touchUpInside)
        listView.stackView.addArrangedSubview(button)
    }
    
    func apiSignupExample(){
        // sample api signup call
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
    }
    
    func apiSimpleExample(){
        // api example
        ApiController.getApi(completion: { (result, err) in
            if let err = err {
                print(err)
            }
            if let result = result {
                print(result)
                self.label.text = String(result.response ?? false)
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        nibExample()
        
        apiSignupExample()
        
        apiSimpleExample()
    }
}

