//
//  BaseCell.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 10/18/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
    }
}
