//
//  DailyHeatMapViewController.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 11/7/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

class DailyHeatMapViewController: BaseUIViewController, DailyHeatmapDataDelegate {
    
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
        let chart = DailyHeatmapView(data: data, colors: DailyHeatmapView.Colors.normal, spacing: 2)
        self.view.addSubview(chart)
        chart.snapToSuperTop(withInsets: UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10))
        chart.delegate = self
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
    
    func didSelectItem(atIndex index: CGPoint) {
        print("did select \(index)")
        let i = Int(index.x * index.y)
        print(data[i])
    }
    
    func didEndSelectItem(atIndex index: CGPoint) {
        print("did end select \(index)")
    }
}
