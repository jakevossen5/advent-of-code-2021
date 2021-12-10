//
//  1.swift
//  Advent of Code 2021
//
//  Created by Jake Vossen on 12/2/21.
//

import Foundation

func problem_1_1() -> Int {
    var result: Int = 0
    let filename = "inputs/input-1.txt"
    let contents = try! String(contentsOfFile: filename)
    let lines = contents.split(separator:"\n").map {Int($0)!}
    for (i, e) in lines.enumerated().dropFirst(1) {
        if e > lines[i - 1] {
            result += 1;
        }
    }
    return result
    
}

func problem_1_2() -> Int {
    var result: Int = 0
    let filename = "inputs/input-1.txt"
    let contents = try! String(contentsOfFile: filename)
    let nums = contents.split(separator:"\n").map {Int($0)!}
    
    var chunks: [[Int]] = []
    
    for i in 0...(nums.count - 3) {
        let newArr = [nums[i], nums[i+1], nums[i+2]]
        chunks.append(newArr)
    }
    
    let sums = chunks.map {$0[0] + $0[1] + $0[2]}
    
    for (i, e) in sums.enumerated().dropFirst(1) {
        if e > sums[i - 1] {
            result += 1;
        }
    }
    return result
}
