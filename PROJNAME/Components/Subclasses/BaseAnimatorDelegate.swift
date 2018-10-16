//
//  BaseAnimatorDelegate.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 10/16/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

class BaseAnimationDelegate: NSObject, CAAnimationDelegate {
    
    fileprivate let completion: () -> Void
    
    init(completion: @escaping () -> Void) {
        self.completion = completion
    }
    
    func animationDidStop(_: CAAnimation, finished: Bool) {
        completion()
    }
}
