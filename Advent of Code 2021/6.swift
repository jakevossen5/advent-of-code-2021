//
//  6.swift
//  Advent of Code 2021
//
//  Created by Jake Vossen on 12/5/21.
//

import Foundation


fileprivate func problem_6(countTo: Int) -> Int {
    
    // could do [day: count] but day can be index
    var fishCounts: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    let initialFish = "3,5,3,1,4,4,5,5,2,1,4,3,5,1,3,5,3,2,4,3,5,3,1,1,2,1,4,5,3,1,4,5,4,3,3,4,3,1,1,2,2,4,1,1,4,3,4,4,2,4,3,1,5,1,2,3,2,4,4,1,1,1,3,3,5,1,4,5,5,2,5,3,3,1,1,2,3,3,3,1,4,1,5,1,5,3,3,1,5,3,4,3,1,4,1,1,1,2,1,2,3,2,2,4,3,5,5,4,5,3,1,4,4,2,4,4,5,1,5,3,3,5,5,4,4,1,3,2,3,1,2,4,5,3,3,5,4,1,1,5,2,5,1,5,5,4,1,1,1,1,5,3,3,4,4,2,2,1,5,1,1,1,4,4,2,2,2,2,2,5,5,2,4,4,4,1,2,5,4,5,2,5,4,3,1,1,5,4,5,3,2,3,4,1,4,1,1,3,5,1,2,5,1,1,1,5,1,1,4,2,3,4,1,3,3,2,3,1,1,4,4,3,2,1,2,1,4,2,5,4,2,5,3,2,3,3,4,1,3,5,5,1,3,4,5,1,1,3,1,2,1,1,1,1,5,1,1,2,1,4,5,2,1,5,4,2,2,5,5,1,5,1,2,1,5,2,4,3,2,3,1,1,1,2,3,1,4,3,1,2,3,2,1,3,3,2,1,2,5,2".split(separator: ",").map({Int($0)!})
    
    for fish in initialFish {
        fishCounts[fish] += 1
    }
    
    for _ in 1...countTo {
        
        let old0 = fishCounts[0]
        fishCounts[0] = fishCounts[1]
        fishCounts[1] = fishCounts[2]
        fishCounts[2] = fishCounts[3]
        fishCounts[3] = fishCounts[4]
        fishCounts[4] = fishCounts[5]
        fishCounts[5] = fishCounts[6]
        fishCounts[6] = fishCounts[7] + old0
        fishCounts[7] = fishCounts[8]
        fishCounts[8] = old0
        
    }
    
    return fishCounts.reduce(0, {x, y in x + y})
}


func problem_6_1() -> Int {
    return problem_6(countTo: 80)
}


func problem_6_2() -> Int {
    return problem_6(countTo: 256)
}
