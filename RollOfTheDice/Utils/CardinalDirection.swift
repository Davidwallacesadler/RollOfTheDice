//
//  MovementSystem.swift
//  RollOfTheDice
//
//  Created by David Sadler on 7/16/22.
//

import Foundation

enum CardinalDirection: String, CaseIterable, CustomStringConvertible {

    case up = "up",
         right = "right",
         down = "down",
         left = "left"
    
    var dx: Int {
        switch self {
        case .up:
            return 0
        case .right:
            return 1
        case .down:
            return 0
        case .left:
            return -1
        }
    }
    
    var dy: Int {
        switch self {
        case .up:
            return -1
        case .right:
            return 0
        case .down:
            return 1
        case .left:
            return 0
        }
    }
    
    var description: String {
        switch self {
        case .up:
            return "North"
        case .right:
            return "East"
        case .down:
            return "South"
        case .left:
            return "West"
        }
    }
    
    var assetRotation: Float {
        switch self {
        case .up:
            return 0
        case .right:
            return 3 * .pi / 2
        case .down:
            return .pi
        case .left:
            return .pi / 2
        }
    }
}
