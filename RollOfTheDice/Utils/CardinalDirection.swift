//
//  MovementSystem.swift
//  RollOfTheDice
//
//  Created by David Sadler on 7/16/22.
//

import Foundation

enum CardinalDirection: String, CaseIterable {

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
            return -1
        case .left:
            return 0
        }
    }
}
