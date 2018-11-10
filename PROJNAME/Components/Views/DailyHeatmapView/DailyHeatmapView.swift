//
//  DailyHeatmapView.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 11/8/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

@objc public protocol DailyHeatmapDataDelegate {
    @objc optional func didSelectItem(atIndex index:CGPoint)
    @objc optional func didEndSelectItem(atIndex index:CGPoint)
}

public class DailyHeatmapView : UIView {
    
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
    
    public var delegate : DailyHeatmapDataDelegate?
    private var view : UIView?
    
    public var hideIndicator: Bool = false
    private var indicator : UIView?
    private var indicatorLabel : UILabel?
    
    private var selectedIndex : CGPoint?
    
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
    
    private func makeIndicator() -> UIView? {
        if (hideIndicator == false) {
            return nil
        }
        
        let view = UIView(frame:.init(x: 0, y: 0, width: 100, height: 50))
        view.backgroundColor = .lightGray
        view.cornerRadius = 10
        view.layer.masksToBounds = true
        
        let label = UIFactory.h4Label("")
        label.textAlignment = .center
        label.textColor = .white
        view.addSubview(label)
        label.snapToSuper()
        
        indicatorLabel = label
        self.addSubview(view)
        return view
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func getLocation(_ touch:UITouch) -> CGPoint {
        var location = touch.location(in: self)
        
        location.y = location.y - 60
        return location
    }
    
    private func getCell(_ touch:UITouch) -> CGPoint {
        let location = touch.location(in: self)
        
        let cols : CGFloat = 52.0
        let rows : CGFloat = 7.0
        
        let currentX = location.x * (cols/self.frame.width)
        let currentY = location.y * (rows/self.frame.height)
        
        let finalX = max(min(ceil(currentX), cols),0)
        let finalY = max(min(ceil(currentY), rows), 0)
        
        return CGPoint(x: finalX, y: finalY)
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let point = getCell(touch)
            delegate?.didSelectItem?(atIndex: point)

            if let indicator = self.indicator {
                indicator.center = getLocation(touch)
            }else{
                let i = makeIndicator()
                i?.center = getLocation(touch)
                indicator = i
            }
        }
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let point = getCell(touch)
            let index = Int(point.x * point.y)
            delegate?.didSelectItem?(atIndex: point)

            if let indicatorLabel = self.indicatorLabel {
                indicatorLabel.text = "\(self.data[index])"
            }
            
            if let indicator = self.indicator {
                indicator.center = getLocation(touch)
            }
        }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let point = getCell(touch)
            delegate?.didEndSelectItem?(atIndex: point)
        }
        if let indicator = self.indicator {
            indicator.removeFromSuperview()
            self.indicator = nil
        }
    }
    
}
