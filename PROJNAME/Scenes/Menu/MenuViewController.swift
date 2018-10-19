//
//  MenuViewController.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 10/17/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

class Section1: BaseCell {
    
}

class Section2: BaseCell {
    
}

class Section3: BaseCell {
    
}


class MenuViewController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
    
    ///Section Controller
    func setupCollectionView() {
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(withClass: Section1.self)
        collectionView?.register(withClass: Section2.self)
        collectionView?.register(withClass: Section3.self)
        
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
        
        collectionView?.isPagingEnabled = true
    }
    
    ///Nav Title
    let titles = ["Home", "Trending", "Subscriptions", "Account"]
    func setupNavTitle(){
        let titleLabel = UILabel(frame: .init(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "  Home"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
    }
    private func setTitleForIndex(_ index: Int) {
        if let titleLabel = navigationItem.titleView as? UILabel {
            titleLabel.text = "  \(titles[index])"
        }
    }
    
    ///Navigation Bar
    func setupNavBarButtons() {
        let searchImage = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let moreImage = UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal)
        let moreButton = UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(handleMore))
        
        navigationItem.rightBarButtonItems = [moreButton, searchBarButtonItem]
    }
    @objc func handleSearch(){
        print("search")
    }
    @objc func handleMore(){
        print("more")
    }
    ///end Navigation Bar
    
    
    ///Menu
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.menuViewController = self
        return mb
    }()
    
    func scrollToMenuIndex(_ menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        setTitleForIndex(menuIndex)
    }
    
    private func setupMenuBar() {
        navigationController?.hidesBarsOnSwipe = true
        
        let menuView = UIView()
        menuView.backgroundColor = UIColor.rgb(230, 32, 31)
        view.addSubview(menuView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuView)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: menuView)
        
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: menuBar)
        
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
    }
    ///end Menu
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //title
        setupNavTitle()
        //collectionView
        setupCollectionView()
        //menu
        setupMenuBar()
        //nav
        setupNavBarButtons()
        
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
    }

    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / view.frame.width
        
        let indexPath = IndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        
        setTitleForIndex(Int(index))
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier: String
        if indexPath.item == 0 {
            identifier = Section1.className
        } else if indexPath.item == 1 {
            identifier = Section2.className
        } else {
            identifier = Section3.className
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50)
    }
}
