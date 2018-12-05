//
//  PinterestCollectionViewController.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 12/3/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//


import UIKit
import AVFoundation

class PinterestCollectionViewController: UICollectionViewController {
    
    var photos : [PinterestItem] = []
    
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
        photos = generateMore(30)

        collectionView?.backgroundColor = UIColor.clear
        collectionView?.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)

    }
    
}

extension PinterestCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeue(withNibClass: PinterestCollectionViewCell.self, forIndexPath: indexPath)
        if let annotateCell = cell as? PinterestCollectionViewCell {
            annotateCell.item = photos[indexPath.item]
        }
        return cell
    }
    
}

extension PinterestCollectionViewController : PinterestLayoutDelegate {

    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        let item = photos[indexPath.item]
        if let layout = collectionView.collectionViewLayout as? PinterestLayout {
            let aspect: CGFloat = item.height/item.width
            return layout.collectionViewCellWidth*aspect+80
        }
        return 100
    }
    
}
