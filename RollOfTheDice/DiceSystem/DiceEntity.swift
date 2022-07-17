//
//  PlayerDice.swift
//  RollOfTheDice
//
//  Created by David Sadler on 7/16/22.
//

import Foundation

class DiceEntity {
    
    // MARK: - Initializers
    
    init() {
        self.currentType = DiceType.defaultDice
        self.currentNumber = 1
    }
    
    init(number: Int, type: DiceType) {
        self.currentNumber = number
        self.currentType = type
    }
    
    // MARK: - Properties
    
    public var currentNumber: Int
    public var currentType: DiceType
    
}
