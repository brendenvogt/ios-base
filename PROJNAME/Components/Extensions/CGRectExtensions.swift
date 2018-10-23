//
//  CGRectExtensions.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 10/22/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

extension CGRect {
    func insetBy(_ inset: CGFloat) -> CGRect {
        return self.inset(by: UIEdgeInsets(top: inset, left: inset, bottom: 2*inset, right: 2*inset))
    }
}
