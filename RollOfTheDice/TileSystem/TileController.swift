//
//  TileController.swift
//  RollOfTheDice
//
//  Created by David Sadler on 7/16/22.
//

import Foundation

class TileController {
    // Not sure how im going to use this -
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
    
    static func createTileBoard(fromTypeBoard typeBoard: TileTypeBoard) -> TileBoard {
        var tileBoard: TileBoard = []
        for typeRow in typeBoard {
            var tileRow: [TileEntity] = []
            for type in typeRow {
                let newTile = TileEntity(type: type)
                tileRow.append(newTile)
            }
            tileBoard.append(tileRow)
        }
        return tileBoard
    }
}
