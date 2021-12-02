//
//  main.swift
//  Advent of Code 2021
//
//  Created by Jake Vossen on 11/30/21.
//

import Foundation

print("Hello, World!")


func problem_1_1() -> UInt {
    var result: UInt = 0
    let filename = "input-1.txt"
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
    let filename = "input-1.txt"
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

func problem_2_1() -> Int {
    var hoz: Int = 0
    var vert: Int = 0
    
    let filename = "input-2.txt"
    let contents = try! String(contentsOfFile: filename)
    let lines = contents.split(separator:"\n")
    
    for line in lines {
        let split = line.split(separator: " ")
        let (direction, amount) = (split[0], Int(split[1])!)
        switch direction {
        case "forward": hoz += amount
        case "down": vert -= amount
        case "up": vert += amount
        default:
            fatalError("unrecognized direction")
        }
    }
    return hoz * (-vert)
}

func problem_2_2() -> Int {
    var hoz: Int = 0
    var depth: Int = 0
    var aim: Int = 0
    
    let filename = "input-2.txt"
    let contents = try! String(contentsOfFile: filename)
    let lines = contents.split(separator:"\n")
    
    for line in lines {
        let split = line.split(separator: " ")
        let (direction, amount) = (split[0], Int(split[1])!)
        switch direction {
        case "down":
            aim += amount
        case "up":
            aim -= amount
        case "forward":
            hoz += amount
            depth += aim * amount
        default:
            fatalError("unrecognized direction")
        }
    }
    return hoz * depth
}


print("problem 1_1: \(problem_1_1())")
print("problem 1_2: \(problem_1_2())")
print("problem 2_1: \(problem_2_1())")
print("problem 2_2: \(problem_2_2())")
