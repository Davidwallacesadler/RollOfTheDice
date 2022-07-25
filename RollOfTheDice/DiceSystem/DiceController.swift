//
//  DiceController.swift
//  RollOfTheDice
//
//  Created by David Sadler on 7/16/22.
//

import Foundation

class DiceController: RandomNumberApi {
    
    // MARK: - Initializer
    
    init(player: DiceEntity) {
        self.playerDice = player
    }
    
    // MARK: - Internal Properties
    
    private var playerDice: DiceEntity
    
    // MARK: - Exposed Properties
    
    public var diceValue: Int {
        get {
            return playerDice.currentNumber
        }
        set {
            playerDice.currentNumber = newValue
        }
    }
    
    public var diceType: DiceType {
        get {
            return playerDice.currentType
        }
        set {
            playerDice.currentType = newValue
        }
    }
    
    public var diceAssetName: String {
        get {
            return diceType.assetName + "-\(diceValue)"
        }
    }
}

// MARK: - Api Implementation

extension DiceController: DiceApi {
    
    func incrementCurrentNumber(byAmount increment: Int = 1) {
        let newValue = playerDice.currentNumber + increment
        // For now if we increment up to the top number we dont restart at the beginning?
        if playerDice.currentType.valueRange.contains(newValue) {
            playerDice.currentNumber = newValue
        }
    }
    
    func decrementCurrentNumber(byAmount increment: Int = 1) {
        let newValue = playerDice.currentNumber - increment
        // For now if we decrement down to the bottom number we dont restart at the beginning?
        if playerDice.currentType.valueRange.contains(newValue) {
            playerDice.currentNumber = newValue
        }
    }
    
    func rollPlayerDiceNumber() {
        let newRollValue = getRandomNumber(inClosedRange: playerDice.currentType.valueRange)
        playerDice.currentNumber = newRollValue
    }
    
    func rollPlayerDiceType() {
        let diceSideCounts = DiceType.allCases.map({ $0.numberOfSides })
        let newDiceSideCount = getRandomNumber(inArray: diceSideCounts)
        guard let newDiceType = DiceType(rawValue: newDiceSideCount) else { return }
        playerDice.currentType = newDiceType
    }
    
    func setPlayerDiceType(_ newType: DiceType) {
        playerDice.currentType = newType
    }
}
