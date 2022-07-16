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
    
    // MARK: - Nodes
    
    private var playerNode: SKShapeNode!
    private var cameraNode = SKCameraNode()
    
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
    }
    
    func addNodesToScene() {
        addChild(cameraNode)
        addChild(playerNode)
    }
    
    func setupPlayerNode() {
        let playerShape = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 50, height: 50))
        playerShape.fillColor = .systemRed
        let numberLabel = SKLabelNode(text: "\(diceController.diceValue)")
        numberLabel.fontColor = .white
        playerShape.addChild(numberLabel)
        
        self.playerNode = playerShape
    }
    
    func setupCameraNode() {
        camera = cameraNode
        cameraNode.position = CGPoint.zero
    }
}
