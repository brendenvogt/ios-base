//
//  LetterImageGenerator.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 10/15/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

class LetterImageGenerator: NSObject {
    class func imageWith(name: String?, _ textColor: UIColor = .gray, _ backgroundColor: UIColor = .white) -> UIImage? {
        print(textColor.toHexString())
        print(backgroundColor.toHexString())
        return imageWith(name: name, textColor.toHexString(), backgroundColor.toHexString())
    }
    
    class func imageWith(name: String?, _ textColor: String? = nil, _ backgroundColor: String? = nil) -> UIImage? {
        let textC = UIColor(hexString: textColor ?? "222222")
        let backgroundC = UIColor(hexString: backgroundColor ?? "ffffff")
        let frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        let nameLabel = UILabel(frame: frame)
        nameLabel.textAlignment = .center
        
        nameLabel.backgroundColor = backgroundC
        nameLabel.textColor = textC
        nameLabel.font = UIFont.boldSystemFont(ofSize: 60)
        var initials = ""
        if let initialsArray = name?.components(separatedBy: " ") {
            if let firstWord = initialsArray.first {
                if let firstLetter = firstWord.first {
                    initials += String(firstLetter).capitalized
                }
            }
            if initialsArray.count > 1, let lastWord = initialsArray.last {
                if let lastLetter = lastWord.first {
                    initials += String(lastLetter).capitalized
                }
            }
        } else {
            return nil
        }
        nameLabel.text = initials
        UIGraphicsBeginImageContext(frame.size)
        if let currentContext = UIGraphicsGetCurrentContext() {
            nameLabel.layer.render(in: currentContext)
            let nameImage = UIGraphicsGetImageFromCurrentImageContext()
            return nameImage
        }
        return nil
    }
}
