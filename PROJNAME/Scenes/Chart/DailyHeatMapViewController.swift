//
//  DailyHeatMapViewController.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 11/7/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

class DailyHeatMapViewController: BaseUIViewController {

    static let spacing : CGFloat = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        fillData()
        let mainStack = makeMap(data: data, colors: getColors())

        self.view.addSubview(mainStack)
        mainStack.snapToSuperTop(withInsets: UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10))
    }

    func map(val: CGFloat, a1: CGFloat, a2: CGFloat, b1: CGFloat, b2: CGFloat ) -> CGFloat {
        let aRange = CGFloat(a2-a1)
        let bRange = CGFloat(b2-b1)
        let newVal = CGFloat(CGFloat(CGFloat(val-a1) * bRange) / aRange) + b1
        return newVal
    }
    
    func getColors() -> [UIColor] {
        let c0 = UIColor.init(hex: "EBEDF0")!
        let c1 = UIColor.init(hex: "CCE195")!
        let c2 = UIColor.init(hex: "8DC578")!
        let c3 = UIColor.init(hex: "4B9646")!
        let c4 = UIColor.init(hex: "2F5E2E")!
        let colors = [c0,c1,c2,c3,c4]
        return colors
    }
    
    var data : [Int] = []
    
    func fillData(){
        data.removeAll()
        for _ in 0...364 {
            data.append(Int.random(365))
        }
    }
    
    func makeMap(data:[Int], colors: [UIColor] ) -> UIView {
        let maxVal = data.max()!
        
        let mainStack = UIFactory.stack(spacing: DailyHeatMapViewController.spacing, axis: .horizontal, alignment: .fill, distribution: .fillEqually)()
        for i in 0...51 {
            let singleVStack = UIFactory.stack(spacing: DailyHeatMapViewController.spacing, axis: .vertical, alignment: .fill, distribution: .fillEqually)()
            for j in 0...6 {
                let v = UIView(frame: .zero)
                let index = Int(map(val: CGFloat(i)*CGFloat(j), a1: 0, a2: CGFloat(maxVal), b1: 0, b2: CGFloat(colors.count)))
                let color = colors[index]
                v.backgroundColor = color
                singleVStack.addArrangedSubview(v)
                v.heightAnchor.constraint(equalTo: singleVStack.widthAnchor, multiplier: 1.0).isActive = true
            }
            mainStack.addArrangedSubview(singleVStack)
        }
        return mainStack
    }
    
}
