//
//  CircularImageCell.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 10/14/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit
import Kingfisher

class CircularImageCell: UICollectionViewCell {

    @IBOutlet var mainImage: UIImageView!
    @IBOutlet var gradientView: BaseUIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func common(imageUrl:String, colors : [UIColor]){
        self.layer.cornerRadius = self.bounds.width/2
        self.layer.masksToBounds = true
        
        //gradient view
        self.gradientView.topColor = colors.first ?? .white
        self.gradientView.bottomColor = colors.last ?? .white
        //letter image
        //self.mainImage.image = LetterImageGenerator.imageWith(name: "Brenden Vogt", "ffffff", "cccccc")
        
        //or load from internet
        //self.mainImage.kf.setImage(with: URL(string: imageUrl))
        //or fade in
        self.mainImage.kf.setImage(with: URL(string: imageUrl), placeholder: nil, options: [.transition(.fade(1))], progressBlock: nil, completionHandler: { (image, error, cacheType, URL) in
        })
        
    }
}
