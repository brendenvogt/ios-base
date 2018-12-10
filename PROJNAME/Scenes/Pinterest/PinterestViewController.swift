//
//  PinterestViewController.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 12/4/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

//this is currently not working as the height calculation is not predictable

import UIKit
import Kingfisher

class PinterestViewModel : NSObject {
    
    public var page = 1
    public var pageSize = 30
    
    public var items: [PinterestItem] = []
    
    func generateMore(_ size : Int) -> [PinterestItem] {
        var l = [PinterestItem]()
        for _ in 0...size {
            let width = CGFloat.random(min: 300, max: 800)
            let height = CGFloat.random(min: 300, max: 800)
            let size = CGSize(width: width, height: height)
            l.append(PinterestItem(title: .lorem(min: 2, max: 10),subtitle: .lorem(min: 5, max: 20), width: width, height: height, color: UIColor.random(), imageUrl: SampleImageUtility.normal(size: size)))
        }
        return l
    }
    
    func fetchMore(completion : ()->Void) {
        items.append(contentsOf: generateMore(pageSize))
        page = page + 1
        completion()
    }
}



class SplitCollectionView : UICollectionView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var insets: CGFloat = 10.0
    private var padding: CGFloat = 10.0
    private var columnSpacing: CGFloat = 10.0
    private var lineSpacing: CGFloat = 10
    private var columns: Int = 2
    
    convenience init(layout: UICollectionViewFlowLayout, delegate :UICollectionViewDelegate, viewModel : PinterestViewModel){
        self.init(frame: .zero, collectionViewLayout: layout)
        self.delegate = delegate
        self.viewModel = viewModel
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        commonInit()
    }
    
    private func commonInit(){
        self.allowsMultipleSelection = false
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.backgroundColor = .clear
        self.register(withNibClass: PinterestCollectionViewCell.self)
        self.shouldAutoLoad = true
        self.autoLoadAmount = 10
        self.dataSource = self
        self.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var viewModel : PinterestViewModel?
    
    public var autoLoadAmount : Int = 10
    public var shouldAutoLoad : Bool = false
    
    public var shouldRefresh : Bool {
        get {
            if let vm = viewModel {
                if let last = visibleCells.last {
                    if (vm.items.count-autoLoadAmount < last.tag){
                        print("should fetch page: \(vm.page+1) and pageSize: \(vm.pageSize)")
                        return true
                    }
                }
            }
            return false
        }
    }
    
    func tryAutoReload() {
        if (shouldRefresh){
            reloadData()
        }
    }
    
    override func reloadData() {
        viewModel?.fetchMore {
            super.reloadData()
            self.invalidateIntrinsicContentSize()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let collectionView = collectionView as? SplitCollectionView {
            return collectionView.viewModel?.items.count ?? 0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeue(withClass: PinterestCollectionViewCell.self, forIndexPath: indexPath) as! PinterestCollectionViewCell
        
        if let collectionView = collectionView as? SplitCollectionView {
            if let item = collectionView.viewModel?.items[indexPath.item] {
                cell.item = item
            }
            cell.tag = indexPath.item
        }
        return cell
    }
    
}




class PinterestViewController: BaseUIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private var insets: CGFloat = 10.0
    private var padding: CGFloat = 10.0
    private var columnSpacing: CGFloat = 10.0
    private var lineSpacing: CGFloat = 10
    private var columns: Int = 2
    
    private var collectionViews : [SplitCollectionView] = []
    
    private var tallestScrollView : UIScrollView?
    private var maxSize: CGFloat = 0
    private var foundMax : Bool = false
    
    lazy private var collectionStack : UIStackView = {
        let s = UIStackView()
        s.spacing = columnSpacing
        s.distribution = .fillEqually
        s.axis = .horizontal
        return s
    }()
    
    func genCollectionView() -> SplitCollectionView {
        
        //layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = lineSpacing
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = .init(top: padding, left: 0, bottom: padding, right: 0)
        
        let width = (self.view.frame.width-(2*padding)-(CGFloat(columns-1)*insets))/CGFloat(columns)
        layout.estimatedItemSize = CGSize(width: width, height: 200)
        
        //viewModel
        let vm = PinterestViewModel()
        
        //collectionView
        let c = SplitCollectionView(layout: layout, delegate: self, viewModel: vm)
        c.viewModel = vm
        c.delegate = self
        
        return c
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViews()
        view.backgroundColor = .white
    }
    
    
    func setupCollectionViews() {
        for column in 0...columns-1 {
            let cv = genCollectionView()
            collectionViews.append(cv)
            cv.tag = column
            cv.reloadData()
            collectionStack.addArrangedSubview(cv)
        }
        view.addSubview(collectionStack)
        collectionStack.snapToSuper(withInsets: .init(top: 0, left: padding, bottom: 0, right: padding))
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        for collectionView in collectionViews {
            collectionView.contentOffset = scrollView.contentOffset
            collectionView.tryAutoReload()
        }
    }
}
