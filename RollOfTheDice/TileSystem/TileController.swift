//
//  TileController.swift
//  RollOfTheDice
//
//  Created by David Sadler on 7/16/22.
//

import Foundation

class TileController {
    
    // MARK: - Initializer
    
    init(board: TileBoard) {
        self.board = board
    }
    
    // MARK: - Internal Properties
    
    private var board: TileBoard
//    private var playTile: TileEntity
    
    // MARK: - Exposed Properties
    
    
    
}

extension TileController {
    static func createRandomTileBoard(ofWidth width: Int, andHeight height: Int) -> TileBoard {
        // width == amount of tiles in each array
        // height == amount of tile arrays in the parent array
        var tileBoard: TileBoard = []
        while tileBoard.count < height {
            var tileRow: [TileEntity] = []
            for _ in 0..<width {
                let randomType = TileType.allCases.randomElement()!
                tileRow.append(TileEntity(walledSides: [], type: randomType))
            }
            tileBoard.append(tileRow)
        }
        return tileBoard
    }
}
