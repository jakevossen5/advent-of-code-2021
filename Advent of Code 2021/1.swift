//
//  1.swift
//  Advent of Code 2021
//
//  Created by Jake Vossen on 12/2/21.
//

import Foundation

func problem_1_1() -> UInt {
    var result: UInt = 0
    let filename = "inputs/input-1.txt"
    let contents = try! String(contentsOfFile: filename)
    let lines = contents.split(separator:"\n").map {UInt($0)!}
    for (i, e) in lines.enumerated().dropFirst(1) {
        if e > lines[i - 1] {
            result += 1;
        }
    }
    return result
    
}

func problem_1_2() -> UInt {
    var result: UInt = 0
    let filename = "inputs/input-1.txt"
    let contents = try! String(contentsOfFile: filename)
    let nums = contents.split(separator:"\n").map {UInt($0)!}
    
    var chunks: [[UInt]] = []
    
    for i in 0...(nums.count - 3) {
        let new_arr = [nums[i], nums[i+1], nums[i+2]]
        chunks.append(new_arr)
    }
    
    let sums = chunks.map {$0[0] + $0[1] + $0[2]}
    
    for (i, e) in sums.enumerated().dropFirst(1) {
        if e > sums[i - 1] {
            result += 1;
        }
    }
    return result
}
