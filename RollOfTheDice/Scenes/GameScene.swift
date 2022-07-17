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
    
    private var diceController = DiceController(player: DiceEntity())
    private var gameBoard: TileBoard = TileController.createRandomTileBoard(ofWidth: 5, andHeight: 5)
    
    // MARK: - Nodes
    
    private var playerNode: SKSpriteNode!
    private var cameraNode = SKCameraNode()
    private var tileNodes: [SKSpriteNode] = []
    
    // MARK: - View LifeCycle
    
    override func didMove(to view: SKView) {
        // Called when the Scene is presented
        setupNodes()
        addNodesToScene()
    }
    
    // MARK: - Loop
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

// MARK: - Setup Methods

extension GameScene {
    
    func setupNodes() {
        setupCameraNode()
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
        let player = SKSpriteNode(imageNamed: diceController.diceAssetName)
        player.size = CGSize(width: 75, height: 75)
        player.zPosition = ObjectDepth.foreground.zPosition
        
        self.playerNode = player
    }
    
    func setupCameraNode() {
        camera = cameraNode
        cameraNode.position = CGPoint.zero
    }
    
    func setupTileNodes() {
        let tileSize: CGFloat = 100.0
        var tileXOrigin: CGFloat = -225
        var tileYOrigin: CGFloat = 0
        
        for tileRow in gameBoard {
            for tile in tileRow {
                let tileNode = SKSpriteNode(imageNamed: tile.tileType.assetName)
                tileNode.size = CGSize(width: tileSize, height: tileSize)
                tileNode.position = CGPoint(x: tileXOrigin, y: tileYOrigin)
                tileNode.zPosition = ObjectDepth.background.zPosition
                tileNodes.append(tileNode)
                
                tileXOrigin += (tileSize + 1)
            }
            tileYOrigin -= (tileSize + 1)
            tileXOrigin = -225
        }
    }
}
