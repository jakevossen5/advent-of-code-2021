//
//  6.swift
//  Advent of Code 2021
//
//  Created by Jake Vossen on 12/5/21.
//

import Foundation


func problem_6(count_to: Int) -> Int {
    
    // could do [day: count] but day can be index
    var fish_counts: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    let init_fish = "3,5,3,1,4,4,5,5,2,1,4,3,5,1,3,5,3,2,4,3,5,3,1,1,2,1,4,5,3,1,4,5,4,3,3,4,3,1,1,2,2,4,1,1,4,3,4,4,2,4,3,1,5,1,2,3,2,4,4,1,1,1,3,3,5,1,4,5,5,2,5,3,3,1,1,2,3,3,3,1,4,1,5,1,5,3,3,1,5,3,4,3,1,4,1,1,1,2,1,2,3,2,2,4,3,5,5,4,5,3,1,4,4,2,4,4,5,1,5,3,3,5,5,4,4,1,3,2,3,1,2,4,5,3,3,5,4,1,1,5,2,5,1,5,5,4,1,1,1,1,5,3,3,4,4,2,2,1,5,1,1,1,4,4,2,2,2,2,2,5,5,2,4,4,4,1,2,5,4,5,2,5,4,3,1,1,5,4,5,3,2,3,4,1,4,1,1,3,5,1,2,5,1,1,1,5,1,1,4,2,3,4,1,3,3,2,3,1,1,4,4,3,2,1,2,1,4,2,5,4,2,5,3,2,3,3,4,1,3,5,5,1,3,4,5,1,1,3,1,2,1,1,1,1,5,1,1,2,1,4,5,2,1,5,4,2,2,5,5,1,5,1,2,1,5,2,4,3,2,3,1,1,1,2,3,1,4,3,1,2,3,2,1,3,3,2,1,2,5,2".split(separator: ",").map({Int($0)!})
    
    for fish in init_fish {
        fish_counts[fish] += 1
    }
    
    for _ in 1...count_to {
        
        let old_0 = fish_counts[0]
        fish_counts[0] = fish_counts[1]
        fish_counts[1] = fish_counts[2]
        fish_counts[2] = fish_counts[3]
        fish_counts[3] = fish_counts[4]
        fish_counts[4] = fish_counts[5]
        fish_counts[5] = fish_counts[6]
        fish_counts[6] = fish_counts[7] + old_0
        fish_counts[7] = fish_counts[8]
        fish_counts[8] = old_0
        
    }
    
    return fish_counts.reduce(0, {x, y in x + y})
}


func problem_6_1() -> Int {
    return problem_6(count_to: 80)
}


func problem_6_2() -> Int {
    return problem_6(count_to: 256)
}
