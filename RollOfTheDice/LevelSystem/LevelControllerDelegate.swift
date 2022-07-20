//
//  LevelControllerDelegate.swift
//  RollOfTheDice
//
//  Created by David Sadler on 7/17/22.
//

import Foundation

protocol LevelControllerDelegate {
    func playerDiceDidMove(toTileOfType tileType: TileType)
    func playerDiceDidUpdateNumber()
    func didUpdateGateConditions()
    func didTransitionLevel()
}
