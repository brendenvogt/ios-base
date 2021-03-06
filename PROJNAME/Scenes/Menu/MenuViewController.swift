//
//  MenuViewController.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 10/17/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

class BasicCell: BaseCell {
}

struct Section {
    var title: String
    var imageName: String
}



class MenuViewController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
    
    static let MenuHeight: CGFloat = 45.0
    
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
    
    ///Section Controller
    func setupCollectionView() {
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        view.backgroundColor = .white
        collectionView?.backgroundColor = .clear
        
        ///Register Cells
        collectionView?.register(withClass: BasicCell.self)
        
        ///menu bar insets
        collectionView?.contentInset = UIEdgeInsets(top: MenuViewController.MenuHeight, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: MenuViewController.MenuHeight, left: 0, bottom: 0, right: 0)
        
        //menu defaults
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.isPagingEnabled = true
    }
    ///End Section Controller
    
    ///Sections
    public var sections : [Section] = [Section(title: "Home", imageName: "ic_home_48pt"),
                                       Section(title: "Watching", imageName: "ic_star_48pt"),
                                       Section(title: "Inbox", imageName: "ic_inbox_48pt"),
                                       Section(title: "Account", imageName: "ic_person_48pt")]
    var currentSection: Int = 0
    ///End Section
    
    ///Nav Bar Title
    func setupNavTitle(){
        let titleLabel = UILabel(frame: .init(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .left
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
        
        setTitleForIndex(0)
    }
    private func setTitleForIndex(_ index: Int) {
        if let titleLabel = navigationItem.leftBarButtonItem?.customView as? UILabel {
            titleLabel.text = "  \(sections[index].title)"
        }
    }
    ///End Nav Bar Title
    
    ///Nav Bar
    func setupNavBarButtons() {
        let searchImage = UIImage(named: "ic_search_white")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let moreImage = UIImage(named: "ic_more_vert_white")?.withRenderingMode(.alwaysOriginal)
        let moreButton = UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(handleMore))
        
        navigationItem.rightBarButtonItems = [moreButton, searchBarButtonItem]
    }
    @objc func handleSearch(){
        print("search")
        
        let vc = AuthViewController()
        let root = BaseUINavigationController(rootViewController: vc)
        root.isNavigationBarHidden = true
        
        self.present(root, animated: true) {
            print("presented auth")
        }
        
    }
    @objc func handleMore(){
        print("more")
        settingsLauncher.showSettings()
    }
    ///End Nav Bar
    
    ///Section Menu
    lazy var menuBar: MenuBar = {
        let mb = MenuBar(frame: .zero, menu: self)
        return mb
    }()
    
    func scrollToMenuIndex(_ menuIndex: Int, _ animate: Bool = true) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: animate)
        setTitleForIndex(menuIndex)
    }
    
    private func setupMenuBar() {
        navigationController?.hidesBarsOnSwipe = false
        
        let menuView = UIView()
        menuView.backgroundColor = UIFactory.accentColor
        view.addSubview(menuView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuView)
        view.addConstraintsWithFormat(format: "V:[v0(\(MenuViewController.MenuHeight))]", views: menuView)
        
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:[v0(\(MenuViewController.MenuHeight))]", views: menuBar)
        
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
    }
    ///End Section Menu
    
    ///Settings Menu
    func showControllerForSetting(setting: Setting) {
        let dummySettingsViewController = UIViewController()
        dummySettingsViewController.view.backgroundColor = UIColor.white
        dummySettingsViewController.navigationItem.title = setting.name.rawValue
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.pushViewController(dummySettingsViewController, animated: true)
    }
    
    lazy var settingsLauncher: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.menuViewController = self
        return launcher
    }()
    ///End Settings Menu
    
    //main view collection
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / CGFloat(sections.count)
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / view.frame.width
        
        let indexPath = IndexPath(item: Int(index), section: 0)
        currentSection = Int(index)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        
        setTitleForIndex(Int(index))
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier: String = BasicCell.className
        let color = UIColor.white
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        var vc : UIViewController?
        
        if indexPath.item == 0 {
            vc = HomeViewController()
        } else if indexPath.item == 1 {
            vc = ChartViewController()
        } else if indexPath.item == 2 {
            vc = DailyHeatMapViewController()
        } else {
            vc = BaseAuthViewController()
        }
        
        if let vc = vc {
            self.addChild(vc)
            cell.contentView.addSubview(vc.view)
            vc.view.backgroundColor = .white
            vc.view.snapToSuper()
        }
        
        cell.backgroundColor = color
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var offset: CGFloat = 0.0
        if let tab = self.tabBarController {
            offset = tab.tabBar.isTranslucent ? 50 : 0
        }
        return CGSize(width: view.frame.width, height: view.frame.height - MenuViewController.MenuHeight-offset)
    }
    
    //orientation change
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.invalidateLayout()
        
        let menuLayout = menuBar.collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        menuLayout?.invalidateLayout()
        
        let settingsLayout = settingsLauncher.collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        settingsLayout?.invalidateLayout()
        
        scrollToMenuIndex(currentSection, false)
    }
    
}
