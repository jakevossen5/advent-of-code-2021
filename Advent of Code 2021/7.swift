//
//  7.swift
//  Advent of Code 2021
//
//  Created by Jake Vossen on 12/6/21.
//

import Foundation


func problem_7_1() -> Int {
    problem_7(cost_metric: {$0})
}

func problem_7_2() -> Int {
    problem_7(cost_metric: {d in (d * (d + 1)) / 2})
}

func problem_7(cost_metric: (Int) -> Int) -> Int {
    let filename = "inputs/input-7.txt"
    let contents = try! String(contentsOfFile: filename)
    let lines = contents.split(separator:"\n")
    let crabs = lines[0].split(separator: ",").map({Int($0)!})
    
    
    let max = crabs.max()!
    
    var result = Int.max
    
    for candidate in 0...max {
        var candidate_result = 0
        for crab in crabs {
            let distance = abs(crab - candidate)
            candidate_result += cost_metric(distance)
        }
        if candidate_result < result {
            result = candidate_result
        }
    }
    return result
}
