//
//  ZPosition.swift
//  RollOfTheDice
//
//  Created by David Sadler on 7/16/22.
//

import UIKit

enum ObjectDepth: Int {
    case background = 1,
         foreground,
         hud
    
    var zPosition: CGFloat {
        return CGFloat(Double(self.rawValue))
    }
}
