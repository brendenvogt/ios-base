//
//  ShadowView.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 10/21/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

class ShadowView: UIView {

    override var bounds: CGRect {
        didSet {
            setupShadow()
        }
    }
    
    private func setupShadow() {
        self.layer.addShadow(offset: 4, opacity: 0.25, radius: 10)
    }

}
