//
//  RandomExtensions.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 10/17/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit

// MARK: - Bool
extension Bool {
    
    /// Generates a random bool.
    ///
    /// - Returns: Bool.
    static func random() -> Bool {
        return arc4random_uniform(2) == 0
    }
}

// MARK: Double
public extension Double {
    
    /// Returns a random floating point number between 0.0 and 1.0, inclusive.
    public static var random: Double {
        return Double(arc4random()) / 0xFFFFFFFF
    }
    
    /// Generates a random double.
    ///
    /// - Parameters:
    ///   - min: Minimum value of the random value.
    ///   - max: Maximum value of the random value.
    /// - Returns: Generated value.
    public static func random(min: Double, max: Double) -> Double {
        return Double.random * (max - min) + min
    }
}

// MARK: Float Extension
public extension Float {
    
    /// Returns a random floating point number between 0.0 and 1.0, inclusive.
    public static var random: Float {
        return Float(arc4random()) / 0xFFFFFFFF
    }
}

extension CGFloat {
    
    /// Returns a random floating point number between 0.0 and 1.0, inclusive.
    public static var random: CGFloat {
        return CGFloat(Float.random)
    }
    
    /// Returns a random floating point number between the range
    public static func random(within: Range<CGFloat>) -> CGFloat {
        return CGFloat.random * (within.upperBound - within.lowerBound) + within.lowerBound
    }
    
    /// Returns a random floating point number between the range
    public static func random(within: ClosedRange<CGFloat>) -> CGFloat {
        return CGFloat.random * (within.upperBound - within.lowerBound) + within.lowerBound
    }
    
    /// Generates a random CGFloat.
    ///
    /// - Parameters:
    ///   - min: Minimum value of the random value.
    ///   - max: Maximum value of the random value.
    /// - Returns: Generated value.
    public static func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return CGFloat.random * (max - min) + min
    }
}

extension String {
    
    fileprivate static let lorem: String = {
        return "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    }()
    
    fileprivate static let loremItems: [String] = {
        let items = String.lorem.replacingOccurrences(of: ",.", with: "")
        return items.components(separatedBy: " ")
    }()
    
    fileprivate static func loremItem() -> String {
        let items = loremItems
        let randomNumber = Int.random(items.count)
        return "\(items[randomNumber])"
    }
    
    static func lorem(min: Int,max: Int) -> String {
        let randomNumber = Int.random(max-min)+min
        let shuffledItems = loremItems.shuffled()
        return shuffledItems.prefix(randomNumber).joined(separator: " ")
        
    }
    
}
