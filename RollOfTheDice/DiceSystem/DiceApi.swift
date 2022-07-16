//
//  DiceApi.swift
//  RollOfTheDice
//
//  Created by David Sadler on 7/16/22.
//

import Foundation

protocol DiceApi {
    func incrementCurrentNumber(byAmount increment: Int)
    func decrementCurrentNumber(byAmount increment: Int)
    func rollPlayerDiceNumber()
    func rollPlayerDiceType()
    func setPlayerDiceType(_ newType: DiceType)
}


