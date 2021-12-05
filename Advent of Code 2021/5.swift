//
//  5.swift
//  Advent of Code 2021
//
//  Created by Jake Vossen on 12/5/21.
//

import Foundation


struct Point {
    var x: UInt = 0
    var y: UInt = 0
}

extension Point: Hashable {
    static func == (lhs: Point, rhs: Point) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}



func problem_5(consider_diagonals: Bool) -> UInt {
    let filename = "inputs/input-5.txt"
    let contents = try! String(contentsOfFile: filename)
    let lines = contents.split(separator:"\n")
    
    var vents: [(Point, Point)] = []
    
    for line in lines {
        let nums_in_line = line.filter { $0.isNumber || $0 == "," || $0 == "-"}
            .replacingOccurrences(of: "-", with: ",")
            .split(separator: ",")
            .map({UInt($0)!})
        
        let from: Point = Point(x: nums_in_line[0], y: nums_in_line[1])
        let to: Point = Point(x: nums_in_line[2], y: nums_in_line[3])
        let vent = (from, to)
        
        if (!consider_diagonals) {
            if (from.x == to.x || from.y == to.y) {
                vents.append(vent)
            }
        } else {
            vents.append(vent)
        }
        
    }
    
    var board: [Point: UInt] = [:]
    
    for (from, to) in vents {
        
        
        var cur_x = from.x
        var cur_y = from.y
        
        while (true) {
            let result = board[Point(x: cur_x, y: cur_y)]
            if result == nil {
                board[Point(x: cur_x, y: cur_y)] = 1
            } else {
                board[Point(x: cur_x, y: cur_y)] = result! + 1
            }
            
            if (cur_x == to.x && cur_y == to.y) {
                break
            }
            
            if (from.x < to.x) {
                cur_x += 1
            } else if (from.x > to.x) {
                cur_x -= 1
            }
            if (from.y < to.y) {
                cur_y += 1
            } else if (from.y > to.y) {
                cur_y -= 1
            }
            
        }
        
    }
    
    
    let result = board.values.filter({$0 > 1}).count
    return UInt(result)
}



func problem_5_1() -> UInt {
    return problem_5(consider_diagonals: false)
}

func problem_5_2() -> UInt {
    return problem_5(consider_diagonals: true)
}
