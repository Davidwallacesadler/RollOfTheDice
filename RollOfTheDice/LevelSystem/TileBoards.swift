//
//  Levels.swift
//  RollOfTheDice
//
//  Created by David Sadler on 7/16/22.
//

import Foundation

let levelOneBoard: TileBoard = {
    let typeBoard: TileTypeBoard = [
        [.levelFinish, .barrier, .standard, .standard, .standard],
        [.standard, .gate(isLocked: true, targetValue: 3, targetDiceType: .d4), .standard , .barrier, .decrementer],
        [.barrier, .barrier, .mover(direction: .down), .barrier, .mover(direction: .up)],
        [.barrier, .standard, .incrementer, .barrier, .mover(direction: .up)],
        [.barrier, .mover(direction: .down), .barrier, .barrier, .standard],
        [.standard, .standard, .standard, .standard, .standard],
    ]
    return TileController.createTileBoard(fromTypeBoard: typeBoard)
}()

let levelTwoBoard: TileBoard = {
    let typeBoard: TileTypeBoard = [
        [.standard, .standard, .standard, .standard, .standard],
        [.barrier, .barrier, .incrementer, .barrier, .standard],
        [.levelFinish, .barrier, .gate(isLocked: true, targetValue: 3, targetDiceType: .d4), .barrier, .standard],
        [.standard, .barrier, .standard, .mover(direction: .right), .standard],
        [.standard, .gate(isLocked: true, targetValue: 4, targetDiceType: .d6), .incrementer, .barrier, .decrementer],
    ]
    return TileController.createTileBoard(fromTypeBoard: typeBoard)
}()

let levelThreeBoard: TileBoard = {
    let typeBoard: TileTypeBoard = [
        [.standard, .barrier, .standard, .standard, .barrier],
        [.standard, .barrier, .standard, .barrier, .standard],
        [.standard, .standard, .barrier, .standard, .decrementer],
        [.diceChanger(type: .d10), .standard, .gate(isLocked: true, targetValue: 10, targetDiceType: .d10), .standard, .standard],
        [.standard, .barrier, .barrier, .barrier, .standard],
        [.barrier, .standard, .levelFinish, .standard, .gate(isLocked: true, targetValue: 3, targetDiceType: nil)],
    ]
    return TileController.createTileBoard(fromTypeBoard: typeBoard)
}()

