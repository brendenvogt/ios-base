//
//  RoundedShadowView.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 10/22/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

class RoundedShadowView: UIView {
    
    var shadowOptions : ShadowOptions = ShadowOptions(offset: 0, opacity: 0, radius: 0)
    var borderOptions : BorderOptions = BorderOptions(color: .clear, width: 0)
    var roundingOptions : RoundingOptions = RoundingOptions(radius:0)
    
    let roundedView: UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = .white
        v.layer.cornerRadius(0)
        return v
    }()
    
    func base(){

        self.addSubview(roundedView)
        roundedView.snapToSuper()
        
        // border radius
        roundedView.layer.cornerRadius = roundingOptions.radius
        
        // border
        roundedView.layer.borderColor = borderOptions.color.cgColor
        roundedView.layer.borderWidth = borderOptions.width
        
        // drop shadow
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = shadowOptions.opacity
        self.layer.shadowRadius = shadowOptions.radius
        self.layer.shadowOffset = CGSize(width: 0,height: shadowOptions.offset)
    }
    
    convenience init(_ frame: CGRect,_ shadowOptions:ShadowOptions?,_ roundingOptions : RoundingOptions?, _ borderOptions: BorderOptions?) {
        self.init(frame: frame)
        self.shadowOptions = shadowOptions ?? ShadowOptions(offset: 0, opacity: 0, radius: 0)
        self.borderOptions = borderOptions ?? BorderOptions(color: .clear, width: 0)
        self.roundingOptions = roundingOptions ?? RoundingOptions(radius:0)
        base()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        base()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        base()
    }
    
}
