//
//  SampleImageUtility.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 10/15/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

enum CropGravity {
    case north, east, south, west, center
}

class SampleImageUtility: NSObject {
    static var size: CGSize = .zero
    static var gravity: CropGravity = .center
    static var index: Int = 0
    
    class func normal(size: CGSize){
        self.size = size
        let width = Int(size.width)
        let height = Int(size.height)
        let url = "https://picsum.photos/\(width)/\(height)"
        print(url)
    }
    
    class func grayscale(size: CGSize){
        self.size = size
        let width = Int(size.width)
        let height = Int(size.height)
        let url = "https://picsum.photos/g/\(width)/\(height)"
        print(url)
    }
    
    class func specific(size: CGSize, index: Int){
        self.size = size
        let width = Int(size.width)
        let height = Int(size.height)
        let url = "https://picsum.photos/\(width)/\(height)?image=\(index)"
        print(url)
    }
    
    class func blurred(size: CGSize){
        self.size = size
        let width = Int(size.width)
        let height = Int(size.height)
        let url = "https://picsum.photos/\(width)/\(height)/?blur"
        print(url)
    }
    
    class func cropped(size: CGSize, gravity:CropGravity){
        self.size = size
        let width = Int(size.width)
        let height = Int(size.height)
        let url = "https://picsum.photos/\(width)/\(height)/?gravity=\(gravity)"
        print(url)
    }
}
