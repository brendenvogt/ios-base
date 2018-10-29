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
    let titleLabel = UIFactory.h4Label("")
    let subtitleLabel = UIFactory.p5Label("")
    
    let stackView = UIFactory.stack(spacing: 20, axis: .vertical, alignment: .center, distribution: .fillProportionally)()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews(){
        self.view.addSubview(stackView)
        stackView.snapToSuperCenter()
        stackView.snapToWidth()
        stackView.addArrangedSubview(imageView)
        imageView.setContentHuggingPriority(.fittingSizeLevel, for: .vertical)
        
        let s = UIFactory.spacerView()
        stackView.addArrangedSubview(s)
        s.setHeight(50)
        
        stackView.addArrangedSubview(titleLabel)
        titleLabel.textColor = UIFactory.darkGrayColor
        titleLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
        
        stackView.addArrangedSubview(subtitleLabel)
        subtitleLabel.textColor = UIFactory.darkGrayColor
        subtitleLabel.setContentHuggingPriority(.defaultLow, for: .vertical)

    }
    
}
