//
//  SKScene.swift
//  RollOfTheDice
//
//  Created by David Sadler on 7/17/22.
//

import Foundation
import SpriteKit

extension SKScene {
    
    /// Finds the first sprite with matching name in the scene.
    public func findSprite(withName name: String) -> SKSpriteNode? {
        return children.first(where: { $0.name == name }) as? SKSpriteNode
    }
}
