
//
//  8.swift.swift
//  Advent of Code 2021
//
//  Created by Jake Vossen on 12/7/21.
//0:      1:      2:      3:      4:
//aaaa    ....    aaaa    aaaa    ....
//b    c  .    c  .    c  .    c  b    c
//b    c  .    c  .    c  .    c  b    c
//....    ....    dddd    dddd    dddd
//e    f  .    f  e    .  .    f  .    f
//e    f  .    f  e    .  .    f  .    f
//gggg    ....    gggg    gggg    ....
//
// 5:      6:      7:      8:      9:
//aaaa    aaaa    aaaa    aaaa    aaaa
//b    .  b    .  .    c  b    c  b    c
//b    .  b    .  .    c  b    c  b    c
//dddd    dddd    ....    dddd    dddd
//.    f  e    f  .    f  e    f  .    f
//.    f  e    f  .    f  e    f  .    f
//gggg    gggg    ....    gggg    gggg



import Foundation

func problem_8_1() -> Int {
    var result = 0
    let filename = "inputs/input-8.txt"
    let contents = try! String(contentsOfFile: filename)
    let lines = contents.split(separator:"\n")
    var output_values: [String] = []
    for line in lines {
        let outputs = line.split(separator: "|")[1]
        let codes = outputs.split(separator: " ").map({String($0)})
        output_values.append(contentsOf: codes)
    }
    
    print(output_values)
    
    result = output_values.filter({ $0.count == 4 || $0.count == 2 || $0.count == 3 || $0.count == 7}).count
    
    
    return result
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
        
        for output_code in signal_patterns {
            let unique_chars = Set(output_code)
            if output_code.count == 2 { // 1
                possible_top_right.formIntersection(unique_chars)
                possible_bottom_right.formIntersection(unique_chars)
                possible_top_top = possible_top_top.filter({!unique_chars.contains($0)})
                possible_bottom_bottom = possible_bottom_bottom.filter({!unique_chars.contains($0)})
                possible_bottom_left = possible_bottom_left.filter({!unique_chars.contains($0)})
                possible_top_left = possible_top_left.filter({!unique_chars.contains($0)})
                possible_middle = possible_middle.filter({!unique_chars.contains($0)})
            } else if output_code.count == 3 { // 7
                possible_top_top.formIntersection(unique_chars)
                possible_top_right.formIntersection(unique_chars)
                possible_bottom_right.formIntersection(unique_chars)
                possible_bottom_bottom = possible_bottom_bottom.filter({!unique_chars.contains($0)})
                possible_bottom_left = possible_bottom_left.filter({!unique_chars.contains($0)})
                possible_middle = possible_middle.filter({!unique_chars.contains($0)})
                possible_top_left = possible_top_left.filter({!unique_chars.contains($0)})
            } else if output_code.count == 4 { // 4
                possible_top_right.formIntersection(unique_chars)
                possible_bottom_right.formIntersection(unique_chars)
                possible_middle.formIntersection(unique_chars)
                possible_top_left.formIntersection(unique_chars)
                possible_top_top = possible_top_top.filter({!unique_chars.contains($0)})
                possible_bottom_bottom = possible_bottom_bottom.filter({!unique_chars.contains($0)})
                possible_bottom_left = possible_bottom_left.filter({!unique_chars.contains($0)})
            } else if output_code.count == 5 { // either a 2, 3 or a 5
                // Guess we start by filtering out things that has to be?
                possible_top_top = possible_top_top.filter({unique_chars.contains($0)})
                possible_bottom_bottom = possible_bottom_bottom.filter({unique_chars.contains($0)})
                possible_middle = possible_middle.filter({unique_chars.contains($0)})
            } else if output_code.count == 6 { // either a 0, 6, or a 9
                possible_top_top = possible_top_top.filter({unique_chars.contains($0)})
                possible_bottom_bottom = possible_bottom_bottom.filter({unique_chars.contains($0)})
                possible_top_left = possible_top_left.filter({unique_chars.contains($0)})
                possible_bottom_right = possible_bottom_right.filter({unique_chars.contains($0)})
                
            }
            else if output_code.count == 7 {
                // nothing to do here?
            }
            print("iterate")
            
            var set_list = [possible_top_top, possible_top_right, possible_bottom_right, possible_bottom_bottom, possible_bottom_left, possible_top_left, possible_middle]
            
            for s in set_list {
                if s.count == 1 {
                    let char_to_remove = s.first!
                    for (i, s2) in set_list.enumerated() {
                        if s2.count != 1 {
                            set_list[i].remove(char_to_remove)
                        }
                    }
                }
            }
            possible_top_top = set_list[0]
            possible_top_right = set_list[1]
            possible_bottom_right = set_list[2]
            possible_bottom_bottom = set_list[3]
            possible_bottom_left = set_list[4]
            possible_top_left = set_list[5]
            possible_middle = set_list[6]
            print("iterate")
            
        }
        
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
        
        var result = ""
        
        for (n, output_code) in output_codes.map({Set($0)}).enumerated() {
            for (num, lights) in digits {
                if output_code == lights {
                    result += String(num)
                }
            }
        }
        
        // cefdb: middle, bottom, bottom_right, top, top_right
        

        
        results.append(Int(result)!)
        
        print("done with check")
        
    }
    
    
    
    print(results)
    
    return results.reduce(0, {x, y in x + y})
}
