//
//  UICollectionViewExtension.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 10/15/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

extension UICollectionView {
    func register(withNibClass cell: AnyClass){
        self.register(UINib(nibName: String(describing: cell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: cell.self))
    }
    
    func dequeue(withNibClass cell: AnyClass, forIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        return self.dequeueReusableCell(withReuseIdentifier: String(describing: cell.self), for: indexPath)
    }
}
