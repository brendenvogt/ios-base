//
//  DailyHeatMapViewController.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 11/7/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

class DailyHeatMapViewController: BaseUIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        fillData()
        
        setupChart()
        
        setupButton()
    }

    @objc func didTap(_ sender : UIButton) {
        fillData()
        setupChart()
    }
    
    let button = UIButton(frame: .zero)
    
    var data : [Int] = []
    
    func fillData(){
        data.removeAll()
        for _ in 0...364 {
            data.append(Int.random(365))
        }
    }
    
    func setupChart(){
        let mainStack = DailyHeatmapView(data: data, colors: DailyHeatmapView.Colors.normal, spacing: 2)
        self.view.addSubview(mainStack)
        mainStack.snapToSuperTop(withInsets: UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    func setupButton(){
        self.view.addSubview(button)
        button.snapToSuperBottom(withInsets: UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20))
        button.setHeight(50)
        button.addTarget(self, action: #selector(didTap(_:)), for: .touchUpInside)
        button.setTitle("Shuffle", for: .normal)
        button.setTitleColor(DailyHeatmapView.Colors.normal.last, for: .normal)
        button.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
    }
    
}
