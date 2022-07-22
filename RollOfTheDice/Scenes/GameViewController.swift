//
//  GameViewController.swift
//  RollOfTheDice
//
//  Created by David Sadler on 7/16/22.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    // MARK: - Internal Methods
    
    private func setupGameScene() {
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            let scene = GameScene(size: view.bounds.size)
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
                
            // Present the scene
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    // MARK: - View LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGameScene()
    }
    
    // MARK: - Overrides

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
