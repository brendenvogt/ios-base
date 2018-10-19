//
//  ViewControllerFactory.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 9/24/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

class HomeViewModel : NSObject {
    
}
class ViewControllerFactory: NSObject {

    static public func homeViewController(viewModel : HomeViewModel?) -> HomeViewController{
        let viewController = HomeViewController()
        viewController.viewModel = viewModel
        return viewController
    }
    
    static public func menuViewController() -> MenuViewController {
        let layout = UICollectionViewFlowLayout()
        return MenuViewController(collectionViewLayout: layout)
    }

}
