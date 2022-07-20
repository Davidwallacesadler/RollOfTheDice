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
        [.standard, .incrementer, .standard, .decrementer, .standard],
        [.standard, .standard, .standard, .standard, .standard],
        [.barrier, .barrier, .gate(isLocked: true, targetValue: 3), .barrier, .barrier],
        [.standard, .standard, .standard, .standard, .standard],
        [.standard, .standard, .levelFinish, .standard, .standard],
    ]
    return TileController.createTileBoard(fromTypeBoard: typeBoard)
}()

let levelTwoBoard: TileBoard = {
    let typeBoard: TileTypeBoard = [
        [.standard, .standard, .standard, .standard, .standard],
        [.barrier, .barrier, .incrementer, .barrier, .standard],
        [.levelFinish, .barrier, .gate(isLocked: true, targetValue: 3), .barrier, .standard],
        [.standard, .barrier, .standard, .barrier, .standard],
        [.standard, .gate(isLocked: true, targetValue: 4), .incrementer, .barrier, .decrementer],
    ]
    return TileController.createTileBoard(fromTypeBoard: typeBoard)
}()

let levelThreeBoard: TileBoard = {
    let typeBoard: TileTypeBoard = [
        [.barrier, .standard, .standard, .standard, .barrier],
        [.standard, .barrier, .standard, .barrier, .standard],
        [.standard, .standard, .barrier, .standard, .decrementer],
        [.reRoller, .standard, .gate(isLocked: true, targetValue: 6), .standard, .standard],
        [.standard, .barrier, .barrier, .barrier, .standard],
        [.barrier, .standard, .levelFinish, .standard, .gate(isLocked: true, targetValue: 3)],
    ]
    return TileController.createTileBoard(fromTypeBoard: typeBoard)
}()

