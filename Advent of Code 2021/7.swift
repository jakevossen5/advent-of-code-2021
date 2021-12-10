//
//  7.swift
//  Advent of Code 2021
//
//  Created by Jake Vossen on 12/6/21.
//

import Foundation


func problem_7_1() -> Int {
    problem_7(costMetric: {$0})
}

func problem_7_2() -> Int {
    problem_7(costMetric: {d in (d * (d + 1)) / 2})
}

fileprivate func problem_7(costMetric: (Int) -> Int) -> Int {
    let filename = "inputs/input-7.txt"
    let contents = try! String(contentsOfFile: filename)
    let lines = contents.split(separator:"\n")
    let crabs = lines[0].split(separator: ",").map({Int($0)!})
    
    
    let max = crabs.max()!
    
    var result = Int.max
    
    for candidate in 0...max {
        var candidateResult = 0
        for crab in crabs {
            let distance = abs(crab - candidate)
            candidateResult += costMetric(distance)
        }
        if candidateResult < result {
            result = candidateResult
        }
    }
    return result
}
