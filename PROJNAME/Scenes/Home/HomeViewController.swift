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
    
    func collectionExample(){
        let listView: ListView = ListView.instantiateFromNib()
        view.addSubview(listView)
        let height = 100
        listView.snapToSuperBottom()
        listView.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
        
        // sample button
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: height, height: height)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(UINib(nibName: CircularImageCell.className, bundle: .main), forCellWithReuseIdentifier: "cell")
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .clear
        collection.dataSource = self
        collection.delegate = self

        listView.stackView.addArrangedSubview(collection)
    }
    
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
        
        collectionExample()
        
//        nibExample()
//
//        apiSignupExample()
//
//        apiSimpleExample()
    }
}

extension HomeViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CircularImageCell
        
        let imageUrl = SampleImageUtility.normal(size: .init(width: 100, height: 100))
//        let imageUrl = SampleImageUtility.grayscale(size: .init(width: 300, height: 300))
//        let imageUrl = SampleImageUtility.blurred(size: .init(width: 300, height: 300))
//        let imageUrl = SampleImageUtility.cropped(size: .init(width: 300, height: 300), gravity: .north)
//        let imageUrl = SampleImageUtility.specific(size: .init(width: 300, height: 300), index: 1)
        
        cell.common(imageUrl: imageUrl)
        return cell
    }
    
    
}
