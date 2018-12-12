//
//  SurveyViewController.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 12/11/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit
import Kingfisher

struct SurveyItem {
    var name :String
    var color: UIColor
    var imageURL: String
}

class SurveyCell : UICollectionViewCell {
    var imageView : UIImageView
    
    override init(frame: CGRect) {
        imageView = UIImageView(frame: .zero)
        super.init(frame: frame)
        imageView.contentMode = .scaleAspectFill
        contentView.addSubview(imageView)
        imageView.snapToSuper()
        imageView.layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(item : SurveyItem){
        imageView.kf.setImage(with: URL(string:item.imageURL))
    }
}






class SurveyViewController: BaseUIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var stack: UIStackView!
    
    var items : [SurveyItem] = []
    
    private var itemSize : CGSize {
        get {
            return self.collectionView.frame.size
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        setupCollectionView()
        setupUI()
        self.pageControl.numberOfPages = items.count
    }
    
    
    func setupUI(){
        let titleStyle = UIFactory.h4Label("")
        mainLabel.font = titleStyle.font
        mainLabel.textColor = titleStyle.textColor
        let subtitle = UIFactory.p5Label("")
        subtitleLabel.font = subtitle.font
        subtitleLabel.textColor = subtitle.textColor
        
    }
    
    func setupCollectionView(){
        collectionView.register(withClass: SurveyCell.self)
        collectionView.isPagingEnabled = true
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
            layout.scrollDirection = .horizontal
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
        }
    }

    
    
    @objc func selectedItem(_ sender: UIButton){
        print("selected \(sender.tag)")
    }
    
    
    
    
    func createButton(item : SurveyItem, _ index : Int) -> UIButton{
        let b = UIButton(frame: .zero)
        b.setTitle(item.name, for: .normal)
        b.backgroundColor = .white
        b.titleLabel?.font = UIFactory.h5Label("").font
        b.setTitleColor(item.color, for: .normal)
        b.tag = index
        b.addTarget(self, action: #selector(SurveyViewController.selectedItem(_:)), for: .touchUpInside)
        return b
    }
    
    func setupButtons(){
        for (index, item) in items.enumerated() {
            stack.addArrangedSubview(createButton(item: item, index))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(withClass: SurveyCell.self, forIndexPath: indexPath) as! SurveyCell
        cell.setupView(item: items[indexPath.item])
        return cell
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemSize
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x/itemSize.width)
        self.pageControl.currentPage = index
    }
}
