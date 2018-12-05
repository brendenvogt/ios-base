//
//  SplitCollectionViewCell.swift
//  BioWavesQue
//
//  Created by Brenden Vogt on 12/1/18.
//  Copyright © 2018 BioWavesQue. All rights reserved.
//

import UIKit
import Kingfisher

class PinterestCollectionViewCell: UICollectionViewCell {

    @IBOutlet fileprivate weak var image: UIImageView!
    @IBOutlet fileprivate weak var title: UILabel!
    @IBOutlet fileprivate weak var subtitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.cornerRadius = 10
        
        image.cornerRadius = 10
        
        title.textAlignment = .left
        subtitle.textAlignment = .left
    }

    var item: PinterestItem? {
        didSet {
            if let item = item {
                image.kf.setImage(with: URL(string: item.imageUrl), placeholder: nil, options: [.transition(.fade(1))], progressBlock: nil, completionHandler: nil)
                title.text = item.title
                subtitle.text = item.subtitle
            }
        }
    }
    
}



