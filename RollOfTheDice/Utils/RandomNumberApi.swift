//
//  RandomNumberApi.swift
//  RollOfTheDice
//
//  Created by David Sadler on 7/16/22.
//

import Foundation

// MARK: - Interface Definition

protocol RandomNumberApi {
    func getRandomNumber(inRange range: Range<Int>) -> Int
    func getRandomNumber(inClosedRange range: ClosedRange<Int>) -> Int
    func getRandomNumber(inArray integers: [Int]) -> Int
}

// MARK: - Default Implementation

extension RandomNumberApi {
    func getRandomNumber(inRange range: Range<Int>) -> Int {
        guard let randomElement = range.randomElement() else {
            print("RNG API ERROR - bad range - returning 1")
            return 1
        }
        return randomElement
    }
    
    func getRandomNumber(inClosedRange range: ClosedRange<Int>) -> Int {
        guard let randomElement = range.randomElement() else {
            print("RNG API ERROR - bad range - returning 1")
            return 1
        }
        return randomElement
    }
    
    func getRandomNumber(inArray integers: [Int]) -> Int {
        guard let randomElement = integers.randomElement() else {
            print("RNG API ERROR - bad range - returning 1")
            return 1
        }
        return randomElement
    }
}
