//
//  Levels.swift
//  RollOfTheDice
//
//  Created by David Sadler on 7/16/22.
//

import Foundation

let levelOneBoard: TileBoard = {
    let typeBoard: TileTypeBoard = [
        [.standard, .standard, .standard, .standard, .standard],
        [.standard, .incrementer, .reRoller, .decrementer, .standard],
        [.standard, .standard, .standard, .standard, .standard],
        [.barrier, .barrier, .gate(isLocked: true, targetValue: 6), .barrier, .barrier],
        [.standard, .standard, .standard, .standard, .standard],
        [.standard, .standard, .levelFinish, .standard, .standard],
    ]
    return TileController.createTileBoard(fromTypeBoard: typeBoard)
}()


