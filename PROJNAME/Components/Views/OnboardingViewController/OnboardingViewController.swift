//
//  OnboardingViewController.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 10/28/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {

    convenience init(image: String, title: String, subtitle: String){
        self.init()
        self.imageView.image = UIImage(named: image)
        self.titleLabel.text = title
        self.subtitleLabel.text = subtitle
    }
    
    let imageView : UIImageView = {
        let i = UIImageView(frame: .zero)
        i.contentMode = .scaleAspectFit
        return i
    }()
    let titleLabel = UIFactory.h3Label("")
    let subtitleLabel = UIFactory.h6Label("")
    
    let stackView = UIFactory.stack(spacing: 0, axis: .vertical, alignment: .center, distribution: UIStackView.Distribution.fill)()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews(){
        self.view.addSubview(stackView)
        stackView.snapToSuper()
        
        
        let s0 = UIFactory.spacerView()
        stackView.addArrangedSubview(s0)
        s0.setHeight(40)
        
        stackView.addArrangedSubview(imageView)
        
        let s1 = UIFactory.spacerView()
        stackView.addArrangedSubview(s1)
        s1.setHeight(20)
        
        stackView.addArrangedSubview(titleLabel)
        titleLabel.textColor = UIFactory.darkGrayColor
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        
        let s2 = UIFactory.spacerView()
        stackView.addArrangedSubview(s2)
        s2.setHeight(10)
        
        stackView.addArrangedSubview(subtitleLabel)
        subtitleLabel.textColor = UIFactory.grayColor
        subtitleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        
        let s3 = UIFactory.spacerView()
        stackView.addArrangedSubview(s3)
        s3.setHeight(30)
    }
    
}
