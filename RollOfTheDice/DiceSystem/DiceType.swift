//
//  DiceType.swift
//  RollOfTheDice
//
//  Created by David Sadler on 7/16/22.
//

import Foundation

enum DiceType: Int, CaseIterable {
    case d4 = 4,
         d6 = 6,
         d8 = 8,
         d10 = 10,
         d20 = 20
     
    var numberOfSides: Int {
        return self.rawValue
    }
    
    var valueRange: ClosedRange<Int> {
        return 1...self.rawValue
    }
    
    var assetName: String {
        return "dice_d\(self.rawValue)"
    }
    
    static let defaultDice: DiceType = .d6
}
