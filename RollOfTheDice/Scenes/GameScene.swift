//
//  GameScene.swift
//  RollOfTheDice
//
//  Created by David Sadler on 7/16/22.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    // MARK: - System Controllers
    
    private var levelController: LevelController!
    
    // MARK: - Nodes
    
    private var playerNode: SKSpriteNode!
    private var cameraNode = SKCameraNode()
    private var tileNodes: [SKSpriteNode] = []
    private var currentLevelLabel: SKLabelNode!
    
    let moverTileAtlas = SKTextureAtlas(named: "MoverTileImages")
    
    // MARK: - View LifeCycle
    
    override func didMove(to view: SKView) {
        // Called when the Scene is presented
        levelController = LevelController(delegate: self)
        setupNodes()
        addNodesToScene()
    }
    
    // MARK: - Loop
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        cameraNode.position.y = playerNode.position.y
        cameraNode.position.x = playerNode.position.x
    }
    
    // MARK: - Touch Overrides
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    private func touchDown(atPoint pos: CGPoint) {
        let nodes = nodes(at: pos)
        guard let tileTappedName = nodes.first(where: { $0.name?.contains(",") ?? false })?.name else { return }
        let coordinates = tileTappedName.split(separator: ",").compactMap({ Int(String($0)) })
        guard coordinates.count > 1 else { return }
        levelController.movePlayer(toGridCoordinate: Point(coordinates[0], coordinates[1]))
    }
}

// MARK: - Level Delegate Implementation

extension GameScene: LevelControllerDelegate {
    func didTransitionLevel() {
        // Remove player and tiles from level
        playerNode.removeFromParent()
        for tile in tileNodes {
            tile.removeFromParent()
        }
        tileNodes = []
        // Re-setup player and tiles
        setupPlayerNode()
        setupTileNodes()
        currentLevelLabel.text = levelController.currentLevel.description
        // Re-add player and tiles
        addChild(playerNode)
        for tileNode in tileNodes {
            addChild(tileNode)
        }
    }
    
    func playerDiceDidUpdateNumber() {
        // ??
    }
    
    func didUpdateGateConditions() {
        for gatePoint in levelController.gatePositions {
            let nameFromPoint = "\(gatePoint.x),\(gatePoint.y)"
            guard let tileFromName = findSprite(withName: nameFromPoint) else { return }
            tileFromName.texture = SKTexture(imageNamed: levelController.gameBoard[gatePoint.y][gatePoint.x].tileType.assetName)
//            guard let firstLabel = tileFromName.children.first as? SKLabelNode else { return }
//            switch levelController.gameBoard[gatePoint.y][gatePoint.x].tileType {
//
//            case .gate(isLocked: let isLocked, targetValue: _):
//                firstLabel.fontColor = isLocked ? .red : .white
//            default:
//                return
//            }
            
        }
    }
    
    func playerDiceDidMove(toTileOfType tileType: TileType) {
        let move = SKAction.move(to: self.levelController.playerScreenPosition, duration: 0.25)
        move.timingMode = .easeInEaseOut
        
        switch tileType {
        case .standard:
            playerNode.run(move)
        case .incrementer:
            let shrink = SKAction.scaleX(to: 0.1, duration: 0.25)
            let update = SKAction.run { [unowned self] in self.playerNode.texture = SKTexture(imageNamed: self.levelController.diceController.diceAssetName) }
            let expand = SKAction.scaleX(to: 1, duration: 0.25)
            let fadeOut = SKAction.fadeOut(withDuration: 0.25)
            let fadeIn = SKAction.fadeIn(withDuration: 0.25)
            let goOut = SKAction.group([shrink, fadeOut])
            goOut.timingMode = .easeIn
            let comeBack = SKAction.group([expand, fadeIn])
            comeBack.timingMode = .easeOut
            playerNode.run(SKAction.sequence([move, goOut, update, comeBack]))
        case .decrementer:
            let shrink = SKAction.scaleY(to: 0.1, duration: 0.25)
            let update = SKAction.run { [unowned self] in self.playerNode.texture = SKTexture(imageNamed: self.levelController.diceController.diceAssetName) }
            let expand = SKAction.scaleY(to: 1, duration: 0.25)
            let fadeOut = SKAction.fadeOut(withDuration: 0.25)
            let fadeIn = SKAction.fadeIn(withDuration: 0.25)
            let goOut = SKAction.group([shrink, fadeOut])
            goOut.timingMode = .easeIn
            let comeBack = SKAction.group([expand, fadeIn])
            comeBack.timingMode = .easeOut
            playerNode.run(SKAction.sequence([move, goOut, update, comeBack]))
        case .reRoller:
            let rotateOut = SKAction.rotate(byAngle: 3, duration: 0.25)
            let rotateIn = SKAction.rotate(byAngle: -3, duration: 0.25)
            let shrink = SKAction.scaleY(to: 0.1, duration: 0.25)
            let update = SKAction.run { [unowned self] in self.playerNode.texture = SKTexture(imageNamed: self.levelController.diceController.diceAssetName) }
            let expand = SKAction.scaleY(to: 1, duration: 0.25)
            let fadeOut = SKAction.fadeOut(withDuration: 0.25)
            let fadeIn = SKAction.fadeIn(withDuration: 0.25)
            let goOut = SKAction.group([shrink, fadeOut, rotateOut])
            goOut.timingMode = .easeIn
            let comeBack = SKAction.group([expand, fadeIn, rotateIn])
            comeBack.timingMode = .easeOut
            playerNode.run(SKAction.sequence([move, goOut, update, comeBack]))
        case .barrier:
            let moveLeft = SKAction.move(by: CGVector(dx: 10, dy: 0), duration: 0.1)
            let moveRight = SKAction.move(by: CGVector(dx: -20, dy: 0), duration: 0.1)
            let reCenter = SKAction.move(by: CGVector(dx: 10, dy: 0), duration: 0.1)
            playerNode.run(SKAction.sequence([moveLeft, moveRight, reCenter]))
        case .levelFinish:
            let goToNext = SKAction.run { [unowned self] in self.levelController.goToNextLevel() }
            playerNode.run(SKAction.sequence([move, goToNext]))
        case .gate(isLocked: let isLocked, targetValue: _):
            if isLocked {
                let moveLeft = SKAction.move(by: CGVector(dx: 10, dy: 0), duration: 0.1)
                let moveRight = SKAction.move(by: CGVector(dx: -20, dy: 0), duration: 0.1)
                let reCenter = SKAction.move(by: CGVector(dx: 10, dy: 0), duration: 0.1)
                playerNode.run(SKAction.sequence([moveLeft, moveRight, reCenter]))
            } else {
                playerNode.run(move)
            }
        case .mover(direction: let direction):
            // Need to re-direct the player based on direction
//            playerNode.run(move)
            let newPoint = Point(levelController.playerGridPosition.x + direction.dx, levelController.playerGridPosition.y + direction.dy)
            levelController.movePlayer(toGridCoordinate: newPoint)
            print("Player landed on mover and should be moved \(direction.dx) in the X direction, and \(direction.dy) in the Y direction.")
        }
    }
}

// MARK: - Setup Methods

extension GameScene {
    
    func setupNodes() {
        setupCameraNode()
        setupHud()
        setupPlayerNode()
        setupTileNodes()
    }
    
    func addNodesToScene() {
        addChild(cameraNode)
        addChild(playerNode)
        for tileNode in tileNodes {
            addChild(tileNode)
        }
    }
    
    func setupPlayerNode() {
        let player = SKSpriteNode()
        player.texture = SKTexture(imageNamed: levelController.diceController.diceAssetName)
        player.position = levelController.playerScreenPosition
        player.size = CGSize(width: levelController.diceSize, height: levelController.diceSize)
        player.zPosition = ObjectDepth.foreground.zPosition
        
        self.playerNode = player
    }
    
    func setupCameraNode() {
        camera = cameraNode
        cameraNode.position = CGPoint.zero
    }
    
    func setupHud() {
        currentLevelLabel = SKLabelNode(fontNamed: "Arial")
        currentLevelLabel.text = levelController.currentLevel.description
        currentLevelLabel.fontColor = .white
        currentLevelLabel.zPosition = ObjectDepth.hud.zPosition
        cameraNode.addChild(currentLevelLabel)
        currentLevelLabel.position = CGPoint(x: 0, y: size.height * 0.5 - 50.0)
    }
    
    func setupTileNodes() {
        let tileSize = CGFloat(Double(levelController.tileSize))
        var tileXOrigin: CGFloat = 0
        var tileYOrigin: CGFloat = 0
        
        var tileSprites: [SKSpriteNode] = []
        var xPosition = 0
        var yPosition = 0
        for tileRow in levelController.gameBoard {
            for tile in tileRow {
                let tileNode = SKSpriteNode()
                switch tile.tileType {
                case .gate(isLocked: _, targetValue: let targetValue):
                    tileNode.texture = SKTexture(imageNamed: tile.tileType.assetName)
                    let valueLabel = SKLabelNode(text: "\(targetValue)")
                    valueLabel.verticalAlignmentMode = .center
                    tileNode.addChild(valueLabel)
                case .mover(direction: let direction):
                    
                    let moverAnimationFrames: [SKTexture] = TileController.getAnimationFrameNames(forTileType: tile.tileType).map({ moverTileAtlas.textureNamed($0) })
                    let moverAnimation = SKAction.repeatForever(SKAction.animate(with: moverAnimationFrames, timePerFrame: 0.1))
                    
                    tileNode.texture = moverAnimationFrames[0]
                    tileNode.zRotation = CGFloat(direction.assetRotation)
                    tileNode.run(moverAnimation)
                default:
                    tileNode.texture = SKTexture(imageNamed: tile.tileType.assetName)
                    break
                }
                tileNode.size = CGSize(width: tileSize, height: tileSize)
                tileNode.position = CGPoint(x: tileXOrigin, y: tileYOrigin)
                tileNode.zPosition = ObjectDepth.background.zPosition
                tileNode.name = "\(xPosition),\(yPosition)"
                tileSprites.append(tileNode)
                xPosition += 1
                tileXOrigin += tileSize
            }
            
            tileYOrigin -= tileSize
            tileXOrigin = 0
            
            xPosition = 0
            yPosition += 1
        }
        tileNodes = tileSprites
    }
}
