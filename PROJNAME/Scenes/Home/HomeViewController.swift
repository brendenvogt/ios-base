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
    
    var button : BaseUIButton = {
        let b = BaseUIButton(frame: .zero)
        b.topColor = UIColor(hex:"00ddff") ?? .white
        b.bottomColor = .blue
        b.gradientAngle = 90
        return b
    }()
    var views = [UIView]()
    func colorsExample(){
        let listView: ListView = ListView.instantiateFromNib()
        view.addSubview(listView)
        let height = 400
        listView.snapToSuperTop()
        listView.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
        for _ in 0...2 {
            let view = UIView(frame: .zero)
            view.backgroundColor = .blue
            listView.stackView.addArrangedSubview(view)
            views.append(view)
        }
    }
    
    func buttonExample(){
        view.addSubview(button)
        button.snapToSuperTop()
        button.heightAnchor.constraint(equalToConstant: 100).isActive = true
        button.cornerRadius = 50
        button.addTarget(self, action: #selector(buttonClicked(button:)), for: .touchUpInside)
    }
    
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
        collection.register(withNibClass: CircularImageCell.self)
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
        
        colorsExample()
        
//        buttonExample()
        
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CircularImageCell.self), for: indexPath) as! CircularImageCell
        
        let imageUrl = SampleImageUtility.normal(size: .init(width: .random(10)+100, height: .random(10)+100))
        
        cell.common(imageUrl: imageUrl, colors: [.darkGray, .lightGray])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        if let cell = collectionView.cellForItem(at: indexPath) as? CircularImageCell {
            let (p,s,d) = (cell.mainImage?.image?.colors())!
            views[0].backgroundColor = p
            views[1].backgroundColor = s
            views[2].backgroundColor = d
        }

    }
    
}
