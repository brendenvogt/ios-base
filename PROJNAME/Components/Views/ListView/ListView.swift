//
//  ListView.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 10/13/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

class ListView: UIView {
    
    @IBOutlet var stackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
