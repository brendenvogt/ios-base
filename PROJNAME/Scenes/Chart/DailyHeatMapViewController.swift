//
//  DailyHeatMapViewController.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 11/7/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit


class DailyHeatmapView : UIView {
    
    class Colors {
        
        ///rainbow
        static let rainbow = [
            UIColor.red,
            UIColor.orange,
            UIColor.yellow,
            UIColor.green,
            UIColor.blue,
            UIColor.purple
        ]
        
        ///grayscale
        static let gray = [
            UIColor.init(white: 0.1, alpha: 1.0),
            UIColor.init(white: 0.3, alpha: 1.0),
            UIColor.init(white: 0.5, alpha: 1.0),
            UIColor.init(white: 0.7, alpha: 1.0),
            UIColor.init(white: 0.9, alpha: 1.0)
        ]
        
        ///normal
        static let normal = [
            UIColor.init(hex: "EBEDF0")!,
            UIColor.init(hex: "CCE195")!,
            UIColor.init(hex: "8DC578")!,
            UIColor.init(hex: "4B9646")!,
            UIColor.init(hex: "2F5E2E")!
        ]
        
        //generator
        static func fromColor(_ color:UIColor, range:Int) -> [UIColor] {
            var colors : [UIColor] = []
            for i in 1...range+1{
                colors.append(color.withAlphaComponent((CGFloat(i)/CGFloat(range))/1.0))
            }
            return colors
        }
    }
    
    var spacing : CGFloat = 1 {
        didSet{
            commonInit()
            return
        }
    }

    private var colors : [UIColor] = []
    private var data : [Int] = []
    private var view : UIView?
    
    private let defaultGray = UIColor.init(white: 0.9, alpha: 1.0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        colors = DailyHeatmapView.Colors.normal
        commonInit()
    }
    
    convenience init(data : [Int]?, colors:[UIColor]?, spacing: CGFloat?) {
        self.init(frame: .zero)
        self.colors = colors ?? DailyHeatmapView.Colors.normal
        self.data = data ?? []
        self.spacing = spacing ?? 1
        commonInit()
    }
    
    private func commonInit() {
        if let view = self.view {
            view.removeFromSuperview()
        }
        
        let view = self.makeMap(data: data, colors: colors)
        self.addSubview(view)
        view.snapToSuper()
        self.view = view
    }
    
    static func map(val: CGFloat, a1: CGFloat, a2: CGFloat, b1: CGFloat, b2: CGFloat ) -> CGFloat {
        let aRange = CGFloat(a2-a1)
        if (aRange == 0) {
            return 0.0
        }
        let bRange = CGFloat(b2-b1)
        let newVal = CGFloat(CGFloat(CGFloat(val-a1) * bRange) / aRange) + b1
        return newVal
    }
    
    public func setColors(_ colors:[UIColor]){
        self.colors = colors
        commonInit()
    }
    
    public func setData(_ data:[Int]){
        self.data = data
        commonInit()
    }
    
    private func makeMap(data:[Int], colors: [UIColor] ) -> UIView {
        let colors = colors.count == 0 ? [defaultGray] : colors
        let maxVal = data.max() ?? 0
        
        let mainStack = UIFactory.stack(spacing: spacing, axis: .horizontal, alignment: .fill, distribution: .fillEqually)()
        for i in 1...52 {
            let singleVStack = UIFactory.stack(spacing: spacing, axis: .vertical, alignment: .fill, distribution: .fillEqually)()
            for j in 1...7 {
                let v = UIView(frame: .zero)
                let index = data.count == 0 ? 0 : Int(DailyHeatmapView.map(val: CGFloat(data[i*j]), a1: 0, a2: CGFloat(maxVal+1), b1: 0, b2: CGFloat(colors.count)))
                let color = colors[index]
                v.backgroundColor = color
                singleVStack.addArrangedSubview(v)
                v.heightAnchor.constraint(equalTo: singleVStack.widthAnchor, multiplier: 1.0).isActive = true
            }
            mainStack.addArrangedSubview(singleVStack)
        }
        return mainStack
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


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
