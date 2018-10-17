//
//  CGFloatExtensions.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 9/25/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

#if os(iOS) || os(tvOS)
    
import UIKit

extension CGFloat {
    
    public var center: CGFloat { return (self / 2) }
    
    @available(*, deprecated: 1.8, renamed: "degreesToRadians")
    public func toRadians() -> CGFloat {
        return (.pi * self) / 180.0
    }
    
    public func degreesToRadians() -> CGFloat {
        return (.pi * self) / 180.0
    }
    
    public mutating func toRadiansInPlace() {
        self = (.pi * self) / 180.0
    }
    
    public static func degreesToRadians(_ angle: CGFloat) -> CGFloat {
        return (.pi * angle) / 180.0
    }
    
    public func radiansToDegrees() -> CGFloat {
        return (180.0 * self) / .pi
    }
    
    public mutating func toDegreesInPlace() {
        self = (180.0 * self) / .pi
    }
    
    public static func radiansToDegrees(_ angleInDegrees: CGFloat) -> CGFloat {
        return (180.0 * angleInDegrees) / .pi
    }
    
    public static func shortestAngleInRadians(from first: CGFloat, to second: CGFloat) -> CGFloat {
        let twoPi = CGFloat(.pi * 2.0)
        var angle = (second - first).truncatingRemainder(dividingBy: twoPi)
        if angle >= .pi {
            angle -= twoPi
        }
        if angle <= -.pi {
            angle += twoPi
        }
        return angle
    }
}
    
#endif
