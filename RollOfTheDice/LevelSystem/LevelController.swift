//
//  LevelController.swift
//  RollOfTheDice
//
//  Created by David Sadler on 7/16/22.
//

import UIKit

class LevelController {
    
    // MARK: - Initializer
    
    init(level: Level = .one, delegate: LevelControllerDelegate) {
        self.currentLevel = level
        self.gameBoard = currentLevel.gameBoard
        self.playerGridPosition = level.startPosition
        self.delegate = delegate
        
        setupGatePositions()
    }
    
    // MARK: - Internal Properties

    // MARK: - Internal Methods
    
    private func setup(withNewLevel level: Level) {
        self.currentLevel = level
        self.gameBoard = currentLevel.gameBoard
        self.playerGridPosition = level.startPosition
        setupGatePositions()
        evaluateGateConditions()
        delegate.didTransitionLevel()
    }
    
    private func setupGatePositions() {
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
    
    // MARK: - Exposed Properties
    
    public let tileSize: Int = 100
    public var diceSize: Int {
        tileSize - 20
    }
    
    public var currentLevel: Level
    public var playerGridPosition: Point
    public var gameBoard: TileBoard
    public var gatePositions: [Point] = []
    
    public var playerScreenPosition: CGPoint {
        return CGPoint(x: playerGridPosition.x * tileSize, y: -playerGridPosition.y * tileSize)
    }
    public var playerTile: TileEntity {
        return gameBoard[playerGridPosition.y][playerGridPosition.x]
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
        setup(withNewLevel: nextLevel)
    }
    
    public func goToPreviousLevel() {
        let previousLevelRaw = currentLevel.rawValue - 1
        guard let previousLevel = Level(rawValue: previousLevelRaw) else {
            print("LEVEL CONTROLLER ERROR - previous level \(previousLevelRaw) not found")
            return
        }
        setup(withNewLevel: previousLevel)
    }
    
    public func movePlayer(toGridCoordinate newPoint: Point) {
        // Validating that the point is a distance of 1
        let previousPoint = playerGridPosition
        let dx = (previousPoint.x - newPoint.x).magnitude
        let dy = (previousPoint.y - newPoint.y).magnitude
        guard dx < 2 && dy < 2 else {
            print("Player tapped on a tile out of range to move")
            return
            
        }
        playerGridPosition = newPoint
        handleMove(fromPreviousPosition: previousPoint)
    }
    
    public func handleMove(fromPreviousPosition previousPoint: Point) {
//        print("player is now at:", playerGridPosition)
        switch playerTile.tileType {
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
            delegate.playerDiceDidMove(toTileOfType: .barrier)
            return
        case .levelFinish:
//            goToNextLevel()
            break
        case .gate(isLocked: let isLocked, targetValue: let targetValue):
            if isLocked {
                // Cant move to tile
                playerGridPosition = previousPoint
                delegate.playerDiceDidMove(toTileOfType: .gate(isLocked: isLocked, targetValue: targetValue))
                return
            }
        case .mover(direction: let _):
            break
        case .diceChanger(type: let type):
            diceController.diceType = type
            if diceController.diceValue > type.numberOfSides {
                diceController.diceValue = type.numberOfSides
            }
        }
        delegate.playerDiceDidMove(toTileOfType: playerTile.tileType)
        
    }
}

// MARK: - Internal Types

extension LevelController {
    enum Level: Int, CaseIterable, CustomStringConvertible {
        case one = 1,
             two,
             three
        
        var gameBoard: [[TileEntity]] {
            switch self {
            case .one:
                return levelOneBoard
            case .two:
                return levelTwoBoard
            case .three:
                return levelThreeBoard
            }
        }
        var startPosition: Point {
            switch self {
            case .one:
                return Point(2,0)
            case .two:
                return .origin
            case .three:
                return Point(0,2)
            }
        }
        var description: String {
            return "Level \(self.rawValue)"
        }
    }
}
