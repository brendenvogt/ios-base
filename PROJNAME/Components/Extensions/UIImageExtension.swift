//
//  UIImageExtension.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 9/25/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

extension UIImage{
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
    
    func getPixelColor(pos: CGPoint) -> UIColor {
        
        let pixelData = self.cgImage!.dataProvider!.data
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4
        
        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
    public func colors() -> (UIColor?, UIColor?, UIColor?) {
        let colors = self.findColors()
        return findMainColors(colors)
    }
    
    private func findColors() -> [String: Int] {
        guard let pixelData = self.cgImage?.dataProvider?.data else { return [:] }
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        let pixelThinner = 10
        var countedColors: [String: Int] = [:]
        
        let pixelsWide = Int(self.size.width * self.scale)
        let pixelsHigh = Int(self.size.height * self.scale)
        
        //  let widthRange = 0..<pixelsWide
        //  let heightRange = 0..<pixelsHigh
        
        let widthThinner = Int(pixelsWide / pixelThinner) + 1
        let heightThinner = Int(pixelsHigh / pixelThinner) + 1
        let widthRange = stride(from: 0, to: pixelsWide, by: widthThinner)
        let heightRange = stride(from: 0, to: pixelsHigh, by: heightThinner)
        
        for x in widthRange {
            for y in heightRange {
                let pixelInfo: Int = ((pixelsWide * y) + x) * 4
                let color = "\(data[pixelInfo]).\(data[pixelInfo + 1]).\(data[pixelInfo + 2])"
                if countedColors[color] == nil {
                    countedColors[color] = 0
                } else {
                    countedColors[color]! += 1
                }
            }
        }
        return countedColors
    }
    
    private func findMainColors(_ colors: [String: Int]) -> (UIColor?, UIColor?, UIColor?) {
        
        var primaryColor: UIColor?, secondaryColor: UIColor?, detailColor: UIColor?
        for (colorString, _) in colors.sorted(by: { $0.value > $1.value }) {
            let colorParts: [String] = colorString.components(separatedBy: ".")
            let color: UIColor = UIColor(red: CGFloat(Int(colorParts[0])!) / 255,
                                         green: CGFloat(Int(colorParts[1])!) / 255,
                                         blue: CGFloat(Int(colorParts[2])!) / 255,
                                         alpha: 1).color(withMinimumSaturation: 0.15)
            
            guard !color.isBlackOrWhite() else { continue }
            if primaryColor == nil {
                primaryColor = color
            } else if secondaryColor == nil {
                if primaryColor!.isDistinct(color) {
                    secondaryColor = color
                }
            } else if detailColor == nil {
                if secondaryColor!.isDistinct(color) && primaryColor!.isDistinct(color) {
                    detailColor = color
                    break
                }
            }
        }
        return (primaryColor, secondaryColor, detailColor)
    }
    
    /// Creates a circular outline image.
    class func outlinedEllipse(size: CGSize, color: UIColor, lineWidth: CGFloat = 1.0) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        context.setStrokeColor(color.cgColor)
        context.setLineWidth(lineWidth)
        // Inset the rect to account for the fact that strokes are
        // centred on the bounds of the shape.
        let rect = CGRect(origin: .zero, size: size).insetBy(dx: lineWidth * 0.5, dy: lineWidth * 0.5)
        context.addEllipse(in: rect)
        context.strokePath()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

}
