//
//  DiceType.swift
//  RollOfTheDice
//
//  Created by David Sadler on 7/16/22.
//

import Foundation

enum DiceType: Int, CaseIterable, CustomStringConvertible {
    case d4 = 4,
         d6 = 6,
//         d8 = 8,
         d10 = 10
//         d20 = 20
    
    var description: String {
        switch self {
        case .d4:
            return "d4"
        case .d6:
            return "d6"
        case .d10:
            return "d10"
        }
    }
     
    var numberOfSides: Int {
        return self.rawValue
    }
    
    var valueRange: ClosedRange<Int> {
        return 1...self.rawValue
    }
    
    var assetName: String {
        return "dice_d\(self.rawValue)"
    }
    
    var symbolName: String {
        switch self {
        case .d4:
            return "triangle"
        case .d6:
            return "square"
        case .d10:
            return "diamond"
        }
    }
    
    var textSymbol: String {
        switch self {
        case .d4:
            return "△"
        case .d6:
            return "□"
        case .d10:
            return "◇"
        }
    }
    
    static let defaultDice: DiceType = .d6
}
