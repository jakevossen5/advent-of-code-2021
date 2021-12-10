
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
    var outputValues: [String] = []
    for line in lines {
        let outputs = line.split(separator: "|")[1]
        let codes = outputs.split(separator: " ").map({String($0)})
        outputValues.append(contentsOf: codes)
    }
    let result = outputValues.filter({ $0.count == 4 || $0.count == 2 || $0.count == 3 || $0.count == 7}).count
    
    return result
}

fileprivate func removeAlreadyDeterminedCharsFromOtherSets(_ setList: inout [Set<Character>]) {
    for s in setList {
        if s.count == 1 {
            let charToRemove = s.first!
            
            // go through the other sets that have more than one element, and contain the char we are trying to remove
            for indexToUpdate in setList.enumerated().filter({$1.count > 1 && $1.contains(charToRemove)}).map({$0.0}) {
                setList[indexToUpdate].remove(charToRemove)
            }
        }
    }
}

func problem_8_2() -> Int {
    let filename = "inputs/input-8.txt"
    let contents = try! String(contentsOfFile: filename)
    let lines = contents.split(separator:"\n")
    var inputData: [([String], [String])] = []
    for line in lines {
        let outputs = line.split(separator: "|")[1]
        let signalPatterns = line.split(separator: "|")[0].split(separator: " ").map({String($0)})
        let codes = outputs.split(separator: " ").map({String($0)})
        inputData.append((signalPatterns, codes))
    }
    
    var results: [Int] = []
    
    
    
    
    for (signalPatterns, outputCodes) in inputData {
        var possibleTopTop: Set<Character> = Set(["a", "b" , "c", "d", "e", "f", "g"]) // very top
        var possibleTopRight: Set<Character> = Set(["a", "b" , "c", "d", "e", "f", "g"]) // clockwise to the rigth
        var possibleBottomRight: Set<Character> = Set(["a", "b" , "c", "d", "e", "f", "g"])
        var possibleBottomBottom: Set<Character> = Set(["a", "b" , "c", "d", "e", "f", "g"])
        var possibleBottomLeft: Set<Character> = Set(["a", "b" , "c", "d", "e", "f", "g"])
        var possibleTopLeft: Set<Character> = Set(["a", "b" , "c", "d", "e", "f", "g"])
        var possibleMiddle: Set<Character> = Set(["a", "b" , "c", "d", "e", "f", "g"])
        
        for pattern in signalPatterns {
            let uniqueChars = Set(pattern)
            if pattern.count == 2 { // 1
                possibleTopRight.formIntersection(uniqueChars)
                possibleBottomRight.formIntersection(uniqueChars)
                
                possibleTopTop = possibleTopTop.filter({!uniqueChars.contains($0)})
                possibleBottomBottom = possibleBottomBottom.filter({!uniqueChars.contains($0)})
                possibleBottomLeft = possibleBottomLeft.filter({!uniqueChars.contains($0)})
                possibleTopLeft = possibleTopLeft.filter({!uniqueChars.contains($0)})
                possibleMiddle = possibleMiddle.filter({!uniqueChars.contains($0)})
            } else if pattern.count == 3 { // 7
                possibleTopTop.formIntersection(uniqueChars)
                possibleTopRight.formIntersection(uniqueChars)
                possibleBottomRight.formIntersection(uniqueChars)
                
                possibleBottomBottom = possibleBottomBottom.filter({!uniqueChars.contains($0)})
                possibleBottomLeft = possibleBottomLeft.filter({!uniqueChars.contains($0)})
                possibleMiddle = possibleMiddle.filter({!uniqueChars.contains($0)})
                possibleTopLeft = possibleTopLeft.filter({!uniqueChars.contains($0)})
            } else if pattern.count == 4 { // 4
                possibleTopRight.formIntersection(uniqueChars)
                possibleBottomRight.formIntersection(uniqueChars)
                possibleMiddle.formIntersection(uniqueChars)
                possibleTopLeft.formIntersection(uniqueChars)
                
                possibleTopTop = possibleTopTop.filter({!uniqueChars.contains($0)})
                possibleBottomBottom = possibleBottomBottom.filter({!uniqueChars.contains($0)})
                possibleBottomLeft = possibleBottomLeft.filter({!uniqueChars.contains($0)})
            } else if pattern.count == 5 { // either a 2, 3 or a 5
                // we don't know what it for certain is, but the top, middle, bottom are all lit up for this.
                possibleTopTop = possibleTopTop.filter({uniqueChars.contains($0)})
                possibleBottomBottom = possibleBottomBottom.filter({uniqueChars.contains($0)})
                possibleMiddle = possibleMiddle.filter({uniqueChars.contains($0)})
            } else if pattern.count == 6 { // either a 0, 6, or a 9
                possibleTopTop = possibleTopTop.filter({uniqueChars.contains($0)})
                possibleBottomBottom = possibleBottomBottom.filter({uniqueChars.contains($0)})
                possibleTopLeft = possibleTopLeft.filter({uniqueChars.contains($0)})
                possibleBottomRight = possibleBottomRight.filter({uniqueChars.contains($0)})
                
            }
            
            
            
            // If we only have one char left, then we can remove it from the other lists
            
            // probably a better way to do this, but we will through everything into a list, modify the list elements, then read them out of the list at the end
            var setList = [possibleTopTop, possibleTopRight, possibleBottomRight, possibleBottomBottom, possibleBottomLeft, possibleTopLeft, possibleMiddle]
            
            removeAlreadyDeterminedCharsFromOtherSets(&setList)
            
            possibleTopTop = setList[0]
            possibleTopRight = setList[1]
            possibleBottomRight = setList[2]
            possibleBottomBottom = setList[3]
            possibleBottomLeft = setList[4]
            possibleTopLeft = setList[5]
            possibleMiddle = setList[6]
        }
        
        // We have figured out what each segment's charachter is! Now time to decode
        
        // sanity check that all of these only have one element
        let setList = [possibleTopTop, possibleTopRight, possibleBottomRight, possibleBottomBottom, possibleBottomLeft, possibleTopLeft, possibleMiddle]
        assert(setList.map({$0.count}).allSatisfy({$0 == 1}))
        
        let topTop = possibleTopTop.first!
        let topRight = possibleTopRight.first!
        let bottomRight = possibleBottomRight.first!
        let bottomBottom = possibleBottomBottom.first!
        let bottomLeft = possibleBottomLeft.first!
        let topLeft = possibleTopLeft.first!
        let middle = possibleMiddle.first!
        
        let zero = (0, Set([topRight, bottomRight, bottomBottom, bottomLeft, topLeft, topTop]))
        let one = (1, Set([topRight, bottomRight]))
        let two = (2, Set([topTop, topRight, middle, bottomLeft, bottomBottom]))
        let three = (3, Set([topTop, topRight, middle, bottomRight, bottomBottom]))
        let four = (4, Set([topLeft, middle, topRight, bottomRight]))
        let five = (5, Set([topTop, topLeft, middle, bottomRight, bottomBottom]))
        let six = (6, Set([topTop, topLeft, middle, bottomRight, bottomBottom, bottomLeft]))
        let seven = (7, Set([topTop, topRight, bottomRight]))
        let eight = (8, Set([topTop, topRight, topLeft, middle, bottomLeft, bottomRight, bottomBottom]))
        let nine = (9, Set([topTop, topRight, topLeft, middle, bottomRight, bottomBottom]))
        
        let digits = [zero, one, two, three, four, five, six, seven, eight, nine]
        
        var result = 0
        
        for outputCode in outputCodes.map({Set($0)}) {
            for (num, lightsForNum) in digits {
                if outputCode == lightsForNum {
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
