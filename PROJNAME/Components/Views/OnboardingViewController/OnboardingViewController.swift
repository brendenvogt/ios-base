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
    let subtitleLabel = UIFactory.h6Label("")
    
    let stackView = UIFactory.stack(spacing: 10, axis: .vertical, alignment: .center, distribution: .fillProportionally)()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews(){
        self.view.addSubview(stackView)
        stackView.snapToSuper()
        
        stackView.addArrangedSubview(imageView)
        imageView.setContentHuggingPriority(.fittingSizeLevel, for: .vertical)
        
        stackView.addArrangedSubview(titleLabel)
        titleLabel.textColor = UIFactory.darkGrayColor
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        
        stackView.addArrangedSubview(subtitleLabel)
        subtitleLabel.textColor = UIFactory.grayColor
        subtitleLabel.setContentHuggingPriority(.required, for: .vertical)

    }
    
}
