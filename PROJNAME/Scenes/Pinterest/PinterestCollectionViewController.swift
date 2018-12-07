//
//  PinterestCollectionViewController.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 12/3/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit
import AVFoundation

struct PinterestItem {
    public var title : String
    public var subtitle : String
    public var width : CGFloat
    public var height : CGFloat
    public var color : UIColor
    public var imageUrl : String
}

class PinterestCollectionViewController: UICollectionViewController {
    
    var items : [PinterestItem] = []
    
    init() {
        let layout = PinterestLayout()
        super.init(collectionViewLayout: layout)
        layout.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func generateMore(_ size : Int) -> [PinterestItem] {
        var l = [PinterestItem]()
        for _ in 0...size {
            let width = CGFloat.random(min: 300, max: 800)
            let height = CGFloat.random(min: 300, max: 800)
            let size = CGSize(width: width, height: height)
            let subtitle = String.lorem(min: 5, max: 20)
            let title = String.lorem(min: 2, max: 10)
            l.append(PinterestItem(title: title,subtitle: subtitle, width: width, height: height, color: UIColor.random(), imageUrl: SampleImageUtility.normal(size: size)))
        }
        return l
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(withNibClass: PinterestCollectionViewCell.self)
        items = generateMore(30)

        collectionView?.backgroundColor = UIColor.clear
        collectionView?.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
}

extension PinterestCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeue(withNibClass: PinterestCollectionViewCell.self, forIndexPath: indexPath)
        if let annotateCell = cell as? PinterestCollectionViewCell {
            annotateCell.item = items[indexPath.item]
        }
        return cell
    }
    
}

extension PinterestCollectionViewController : PinterestLayoutDelegate {

    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        let item = items[indexPath.item]
        if let layout = collectionView.collectionViewLayout as? PinterestLayout {
            let aspect: CGFloat = item.height/item.width
            return layout.collectionViewCellWidth*aspect+80
        }
        return 100
    }
    
}
