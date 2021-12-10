//
//  10.swift
//  Advent of Code 2021
//
//  Created by Jake Vossen on 12/9/21.
//

import Foundation


// Returns the char count of each bracket (for part 1), then the remainder of the stack if we reach the end (for part 2)
fileprivate func problem_10_helper() -> ([Character: Int], [[Character]]) {
    
    let filename = "inputs/input-10.txt"
    let contents = try! String(contentsOfFile: filename)
    let lines = contents.split(separator:"\n").map({Array($0)})
    
    var char_counts: [Character: Int] = [")": 0, "]": 0, "}": 0, ">": 0]
    
    
    var remaining_items: [[Character]] = []

    
lineLoop: for line in lines {
    var stack: [Character] = []
    for char in line {
        if stack.isEmpty {
            stack.append(char)
        } else {
            let most_recent = stack.last!
            switch (most_recent, char) {
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
                char_counts[char]! += 1
                continue lineLoop
            }
            
        }
    }
    remaining_items.append(stack)
}
    
    return (char_counts, remaining_items)
    
}


func problem_10_1() -> Int {
    var result = 0
    let score_data: [(Character, Int)] = [(")", 3), ("]", 57), ("}", 1197), (">", 25137)]
    
    let (char_counts, _) = problem_10_helper()
    
    for (char, mult) in score_data {
        result += char_counts[char]! * mult
    }
    return result
    
}


func problem_10_2() -> Int {
    
    let score_char: [Character: Int] = ["(": 1, "[": 2, "{": 3, "<": 4]
    let (_, remaining_items) = problem_10_helper()
    
    var scores: [Int] = []
    for remaining_item in remaining_items {
        var cur_score = 0

        for item in remaining_item.reversed() {
            let new_score = score_char[item]!
            cur_score *= 5
            cur_score += new_score
        }
        scores.append(cur_score)
    }
    
    scores = scores.sorted()
    
    return scores[scores.count / 2]
}
