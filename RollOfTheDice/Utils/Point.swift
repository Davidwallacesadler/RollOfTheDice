//
//  Point.swift
//  RollOfTheDice
//
//  Created by David Sadler on 7/16/22.
//

import Foundation

struct Point: Hashable {
    
    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
    
    var x: Int
    var y: Int
    
    static let origin: Point = Point(0,0)
}
