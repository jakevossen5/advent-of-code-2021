//
//  2.swift
//  Advent of Code 2021
//
//  Created by Jake Vossen on 12/2/21.
//

import Foundation

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
