
//
//  8.swift.swift
//  Advent of Code 2021
//
//  Created by Jake Vossen on 12/7/21.

import Foundation

func problem_8_1() -> Int {
    let filename = "inputs/input-8.txt"
    let contents = try! String(contentsOfFile: filename)
    let lines = contents.split(separator:"\n")
    var output_values: [String] = []
    for line in lines {
        let outputs = line.split(separator: "|")[1]
        let codes = outputs.split(separator: " ").map({String($0)})
        output_values.append(contentsOf: codes)
    }
    let result = output_values.filter({ $0.count == 4 || $0.count == 2 || $0.count == 3 || $0.count == 7}).count
    
    return result
}

fileprivate func remove_already_determined_chars_from_other_sets(_ set_list: inout [Set<Character>]) {
    for s in set_list {
        if s.count == 1 {
            let char_to_remove = s.first!
            
            // go through the other sets that have more than one element, and contain the char we are trying to remove
            for index_to_update in set_list.enumerated().filter({$1.count > 1 && $1.contains(char_to_remove)}).map({$0.0}) {
                set_list[index_to_update].remove(char_to_remove)
            }
        }
    }
}

func problem_8_2() -> Int {
    let filename = "inputs/input-8.txt"
    let contents = try! String(contentsOfFile: filename)
    let lines = contents.split(separator:"\n")
    var input_data: [([String], [String])] = []
    for line in lines {
        let outputs = line.split(separator: "|")[1]
        let signal_patterns = line.split(separator: "|")[0].split(separator: " ").map({String($0)})
        let codes = outputs.split(separator: " ").map({String($0)})
        input_data.append((signal_patterns, codes))
    }
    
    var results: [Int] = []
    
    
    
    
    for (signal_patterns, output_codes) in input_data {
        var possible_top_top: Set<Character> = Set(["a", "b" , "c", "d", "e", "f", "g"]) // very top
        var possible_top_right: Set<Character> = Set(["a", "b" , "c", "d", "e", "f", "g"]) // clockwise to the rigth
        var possible_bottom_right: Set<Character> = Set(["a", "b" , "c", "d", "e", "f", "g"])
        var possible_bottom_bottom: Set<Character> = Set(["a", "b" , "c", "d", "e", "f", "g"])
        var possible_bottom_left: Set<Character> = Set(["a", "b" , "c", "d", "e", "f", "g"])
        var possible_top_left: Set<Character> = Set(["a", "b" , "c", "d", "e", "f", "g"])
        var possible_middle: Set<Character> = Set(["a", "b" , "c", "d", "e", "f", "g"])
        
        for pattern in signal_patterns {
            let unique_chars = Set(pattern)
            if pattern.count == 2 { // 1
                possible_top_right.formIntersection(unique_chars)
                possible_bottom_right.formIntersection(unique_chars)
                
                possible_top_top = possible_top_top.filter({!unique_chars.contains($0)})
                possible_bottom_bottom = possible_bottom_bottom.filter({!unique_chars.contains($0)})
                possible_bottom_left = possible_bottom_left.filter({!unique_chars.contains($0)})
                possible_top_left = possible_top_left.filter({!unique_chars.contains($0)})
                possible_middle = possible_middle.filter({!unique_chars.contains($0)})
            } else if pattern.count == 3 { // 7
                possible_top_top.formIntersection(unique_chars)
                possible_top_right.formIntersection(unique_chars)
                possible_bottom_right.formIntersection(unique_chars)
                
                possible_bottom_bottom = possible_bottom_bottom.filter({!unique_chars.contains($0)})
                possible_bottom_left = possible_bottom_left.filter({!unique_chars.contains($0)})
                possible_middle = possible_middle.filter({!unique_chars.contains($0)})
                possible_top_left = possible_top_left.filter({!unique_chars.contains($0)})
            } else if pattern.count == 4 { // 4
                possible_top_right.formIntersection(unique_chars)
                possible_bottom_right.formIntersection(unique_chars)
                possible_middle.formIntersection(unique_chars)
                possible_top_left.formIntersection(unique_chars)
                
                possible_top_top = possible_top_top.filter({!unique_chars.contains($0)})
                possible_bottom_bottom = possible_bottom_bottom.filter({!unique_chars.contains($0)})
                possible_bottom_left = possible_bottom_left.filter({!unique_chars.contains($0)})
            } else if pattern.count == 5 { // either a 2, 3 or a 5
                // we don't know what it for certain is, but the top, middle, bottom are all lit up for this.
                possible_top_top = possible_top_top.filter({unique_chars.contains($0)})
                possible_bottom_bottom = possible_bottom_bottom.filter({unique_chars.contains($0)})
                possible_middle = possible_middle.filter({unique_chars.contains($0)})
            } else if pattern.count == 6 { // either a 0, 6, or a 9
                possible_top_top = possible_top_top.filter({unique_chars.contains($0)})
                possible_bottom_bottom = possible_bottom_bottom.filter({unique_chars.contains($0)})
                possible_top_left = possible_top_left.filter({unique_chars.contains($0)})
                possible_bottom_right = possible_bottom_right.filter({unique_chars.contains($0)})
                
            }
            
            
            
            // If we only have one char left, then we can remove it from the other lists
            
            // probably a better way to do this, but we will through everything into a list, modify the list elements, then read them out of the list at the end
            var set_list = [possible_top_top, possible_top_right, possible_bottom_right, possible_bottom_bottom, possible_bottom_left, possible_top_left, possible_middle]
            
            remove_already_determined_chars_from_other_sets(&set_list)
            
            possible_top_top = set_list[0]
            possible_top_right = set_list[1]
            possible_bottom_right = set_list[2]
            possible_bottom_bottom = set_list[3]
            possible_bottom_left = set_list[4]
            possible_top_left = set_list[5]
            possible_middle = set_list[6]
        }
        
        // We have figured out what each segment's charachter is! Now time to decode
        
        // sanity check that all of these only have one element
        let set_list = [possible_top_top, possible_top_right, possible_bottom_right, possible_bottom_bottom, possible_bottom_left, possible_top_left, possible_middle]
        assert(set_list.map({$0.count}).allSatisfy({$0 == 1}))
        
        let top_top = possible_top_top.first!
        let top_right = possible_top_right.first!
        let bottom_right = possible_bottom_right.first!
        let bottom_bottom = possible_bottom_bottom.first!
        let bottom_left = possible_bottom_left.first!
        let top_left = possible_top_left.first!
        let middle = possible_middle.first!
        
        let zero = (0, Set([top_right, bottom_right, bottom_bottom, bottom_left, top_left, top_top]))
        let one = (1, Set([top_right, bottom_right]))
        let two = (2, Set([top_top, top_right, middle, bottom_left, bottom_bottom]))
        let three = (3, Set([top_top, top_right, middle, bottom_right, bottom_bottom]))
        let four = (4, Set([top_left, middle, top_right, bottom_right]))
        let five = (5, Set([top_top, top_left, middle, bottom_right, bottom_bottom]))
        let six = (6, Set([top_top, top_left, middle, bottom_right, bottom_bottom, bottom_left]))
        let seven = (7, Set([top_top, top_right, bottom_right]))
        let eight = (8, Set([top_top, top_right, top_left, middle, bottom_left, bottom_right, bottom_bottom]))
        let nine = (9, Set([top_top, top_right, top_left, middle, bottom_right, bottom_bottom]))
        
        let digits = [zero, one, two, three, four, five, six, seven, eight, nine]
        
        var result = 0
        
        for output_code in output_codes.map({Set($0)}) {
            for (num, lights_for_num) in digits {
                if output_code == lights_for_num {
                    result += num
                    result *= 10
                }
            }
        }
        result /= 10
        results.append(result)
        
    }
    
    return results.reduce(0, {x, y in x + y})
}
