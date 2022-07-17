//
//  TileType.swift
//  RollOfTheDice
//
//  Created by David Sadler on 7/16/22.
//

import Foundation

enum TileType: String, CaseIterable {
    case standard = "standard",
         incrementer = "incrementer",
         decrementer = "decrementer",
         reRoller = "reRoll",
         barrier = "barrier",
         levelFinish = "finish"
    
    var assetName: String {
        return "tile_\(self.rawValue)"
    }
    
    static let defaultTile: TileType = .standard
}

enum BarrierType {
    case valueEqual, valueLessThan, valueMoreThan, valueMod
}
