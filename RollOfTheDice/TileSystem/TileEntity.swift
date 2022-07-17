//
//  TileEntity.swift
//  RollOfTheDice
//
//  Created by David Sadler on 7/16/22.
//

import Foundation

class TileEntity {
    
    // MARK: - Initializers
    
    init() {
        self.walledSides = []
        self.tileType = TileType.defaultTile
    }
    
    init(walledSides: [TileSide] = [], type: TileType) {
        self.walledSides = walledSides
        self.tileType = type
    }
    
    // MARK: - Properties
    
    public var walledSides: [TileSide]
    public var tileType: TileType
}
