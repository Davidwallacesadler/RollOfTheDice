//
//  LevelController.swift
//  RollOfTheDice
//
//  Created by David Sadler on 7/16/22.
//

import UIKit

class LevelController {
    
    // MARK: - Initializer
    
    init(level: Level = .one, playerGridPosition: Point = Point(0,0), delegate: LevelControllerDelegate) {
        self.currentLevel = level
        self.gameBoard = currentLevel.gameBoard
        self.playerGridPosition = playerGridPosition
        self.delegate = delegate
    }
    
    // MARK: - Internal Properties

    
    
    // MARK: - Exposed Properties
    
    public let tileSize: Int = 200
    public var diceSize: Int {
        tileSize - (tileSize / 8)
    }
    
    public var currentLevel: Level
    public var playerGridPosition: Point
    public var gameBoard: TileBoard
    
    public var playerScreenPosition: CGPoint {
        return CGPoint(x: playerGridPosition.x * tileSize, y: -playerGridPosition.y * tileSize)
    }
    
    public var diceController = DiceController(player: DiceEntity())

    public var delegate: LevelControllerDelegate
}

// MARK: - Intentions

extension LevelController {
    
    public func goToNextLevel() {
        let nextLevelRaw = currentLevel.rawValue + 1
        guard let nextLevel = Level(rawValue: nextLevelRaw) else {
            print("LEVEL CONTROLLER ERROR - next level \(nextLevelRaw) not found")
            return
        }
        currentLevel = nextLevel
    }
    
    public func goToPreviousLevel() {
        let previousLevelRaw = currentLevel.rawValue - 1
        guard let nextLevel = Level(rawValue: previousLevelRaw) else {
            print("LEVEL CONTROLLER ERROR - previous level \(previousLevelRaw) not found")
            return
        }
        currentLevel = nextLevel
    }
    
    public func movePlayer(toGridCoordinate newPoint: Point) {
        // Need to validate we can go to where was tapped  - do pathfinding
        let previousPoint = playerGridPosition
        playerGridPosition = newPoint
        handleMove(fromPreviousPosition: previousPoint)
    }
    
    public func handleMove(fromPreviousPosition previousPoint: Point) {
        let newTile = gameBoard[playerGridPosition.y][playerGridPosition.x]
        switch newTile.tileType {
        case .standard:
            break
        case .incrementer:
            diceController.incrementCurrentNumber()
        case .decrementer:
            diceController.decrementCurrentNumber()
        case .reRoller:
            diceController.rollPlayerDiceType()
        case .barrier:
            // Move back to last point?
            playerGridPosition = previousPoint
            break
        case .levelFinish:
            goToNextLevel()
        }
        delegate.playerDiceDidMove(toTileOfType: newTile.tileType)
    }
}

// MARK: - Internal Types

extension LevelController {
    enum Level: Int, CaseIterable {
        case one = 1
        
        var gameBoard: [[TileEntity]] {
            switch self {
            case .one:
                return levelOneBoard
            }
        }
    }
}
