//
//  10.swift
//  Advent of Code 2021
//
//  Created by Jake Vossen on 12/9/21.
//

import Foundation


// Returns the char count of each bracket (for part 1), then the remainder of the stack if we reach the end (for part 2)
fileprivate func problem10Helper() -> ([Character: Int], [[Character]]) {
    
    let filename = "inputs/input-10.txt"
    let contents = try! String(contentsOfFile: filename)
    let lines = contents.split(separator:"\n").map({Array($0)})
    
    var charCounts: [Character: Int] = [")": 0, "]": 0, "}": 0, ">": 0]
    
    
    var remainingItems: [[Character]] = []

    
lineLoop: for line in lines {
    var stack: [Character] = []
    for char in line {
        if stack.isEmpty {
            stack.append(char)
        } else {
            let mostRecentChar = stack.last!
            switch (mostRecentChar, char) {
            case ("(", ")"):
                stack.removeLast()
            case ("[", "]"):
                stack.removeLast()
            case ("{", "}"):
                stack.removeLast()
            case ("<", ">"):
                stack.removeLast()
            case (_, "("), (_, "["), (_, "<"), (_, "{"):
                stack.append(char)
            default:
                charCounts[char]! += 1
                continue lineLoop
            }
            
        }
    }
    remainingItems.append(stack)
}
    
    return (charCounts, remainingItems)
    
}


func problem_10_1() -> Int {
    var result = 0
    let scoreData: [(Character, Int)] = [(")", 3), ("]", 57), ("}", 1197), (">", 25137)]
    
    let (charCounts, _) = problem10Helper()
    
    for (char, mult) in scoreData {
        result += charCounts[char]! * mult
    }
    return result
    
}


func problem_10_2() -> Int {
    
    let scoreCharMap: [Character: Int] = ["(": 1, "[": 2, "{": 3, "<": 4]
    let (_, remainingItems) = problem10Helper()
    
    var scores: [Int] = []
    for remainingItem in remainingItems {
        var curScore = 0

        for item in remainingItem.reversed() {
            let newScore = scoreCharMap[item]!
            curScore *= 5
            curScore += newScore
        }
        scores.append(curScore)
    }
    
    scores = scores.sorted()
    
    return scores[scores.count / 2]
}
