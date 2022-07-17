//
//  TileType.swift
//  RollOfTheDice
//
//  Created by David Sadler on 7/16/22.
//

import Foundation

enum TileType: CustomStringConvertible, Equatable {
    case standard,
         incrementer,
         decrementer,
         reRoller,
         barrier,
         levelFinish,
         gate(isLocked: Bool, targetValue: Int)
    
    var description: String {
        switch self {
        case .standard:
            return "standard"
        case .incrementer:
            return "incrementer"
        case .decrementer:
            return "decrementer"
        case .reRoller:
            return "reRoll"
        case .barrier:
            return "barrier"
        case .levelFinish:
            return "finish"
        case .gate(isLocked: let isLocked, targetValue: _):
            let baseDescription = "gate"
            let postFix = isLocked ? "-locked" : "-unlocked"
            return baseDescription + postFix
        }
    }
    
    var assetName: String {
        return "tile_\(self.description)"
    }
    
    var isAGate: Bool {
        switch self {
        case .gate:
            return true
        default:
            return false
        }
    }
    
    static let defaultTile: TileType = .standard
    static let allCases: [TileType] = [.standard, .incrementer, .decrementer, .reRoller, .barrier, .levelFinish, .gate(isLocked: true, targetValue: 5)]
}


//struct GateCondition {
//    let type: GateConditionType
//    let targetNumber: Int
//    let targetDiceType: DiceType
//}


//enum GateConditionType {
//    case valueEqual(to: Int),
//         valueLess(than: Int),
//         valueMore(than: Int),
//         value(mod: Int)
//}
