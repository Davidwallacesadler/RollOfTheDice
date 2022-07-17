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
        
        var gatePositions = [Point]()
        var x = 0
        var y = 0
        while y < currentLevel.gameBoard.count {
            while x < currentLevel.gameBoard[y].count {
                let tile = currentLevel.gameBoard[y][x]
                if tile.tileType.isAGate {
                    gatePositions.append(Point(x,y))
                }
                x += 1
            }
            y += 1
            x = 0
        }
        self.gatePositions = gatePositions
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
    public var gatePositions: [Point]
    
    public var playerScreenPosition: CGPoint {
        return CGPoint(x: playerGridPosition.x * tileSize, y: -playerGridPosition.y * tileSize)
    }
    
    public var diceController = DiceController(player: DiceEntity())

    public var delegate: LevelControllerDelegate
}

// MARK: - Intentions

extension LevelController {
    
    public func evaluateGateConditions() {
        let currentDiceValue = diceController.diceValue
        for point in gatePositions {
            switch gameBoard[point.y][point.x].tileType {
            case .gate(isLocked: _, targetValue: let targetValue):
                let newState = currentDiceValue != targetValue
                let newGateType: TileType = .gate(isLocked: newState, targetValue: targetValue)
                gameBoard[point.y][point.x].tileType = newGateType
            default:
                break
            }
        }
        delegate.didUpdateGateConditions()
    }
    
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
            let previousNumber = diceController.diceValue
            diceController.incrementCurrentNumber()
            if diceController.diceValue == previousNumber {
                // No change - treat like a standard move
                delegate.playerDiceDidMove(toTileOfType: .standard)
                return
            }
            evaluateGateConditions()
        case .decrementer:
            let previousNumber = diceController.diceValue
            diceController.decrementCurrentNumber()
            if diceController.diceValue == previousNumber {
                // No change - treat like a standard move
                delegate.playerDiceDidMove(toTileOfType: .standard)
                return
            }
            evaluateGateConditions()
        case .reRoller:
            diceController.rollPlayerDiceNumber()
            evaluateGateConditions()
        case .barrier:
            // Move back to last point?
            playerGridPosition = previousPoint
            break
        case .levelFinish:
            goToNextLevel()
        case .gate(isLocked: let isLocked, targetValue: _):
            if isLocked {
                // Cant move to tile
                playerGridPosition = previousPoint
            }
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
