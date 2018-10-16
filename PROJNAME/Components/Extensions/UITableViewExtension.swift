//
//  UITableViewExtension.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 10/15/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

extension UITableView {
    func register(withNibClass cell: AnyClass){
        self.register(UINib(nibName: String(describing: cell.self), bundle: nil), forCellReuseIdentifier: String(describing: cell.self))
    }
    
    func dequeue(withNibClass cell: AnyClass, forIndexPath indexPath: IndexPath) -> UITableViewCell {
        return self.dequeueReusableCell(withIdentifier: String(describing: cell.self), for: indexPath)
    }
}
