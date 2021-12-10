//
//  5.swift
//  Advent of Code 2021
//
//  Created by Jake Vossen on 12/5/21.
//

import Foundation


fileprivate struct Point {
    var x: Int = 0
    var y: Int = 0
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



fileprivate func problem_5(considerDiagonals: Bool) -> Int {
    let filename = "inputs/input-5.txt"
    let contents = try! String(contentsOfFile: filename)
    let lines = contents.split(separator:"\n")
    
    var vents: [(Point, Point)] = []
    
    for line in lines {
        let numsInLine = line.filter { $0.isNumber || $0 == "," || $0 == "-"}
            .replacingOccurrences(of: "-", with: ",")
            .split(separator: ",")
            .map({Int($0)!})
        
        let from: Point = Point(x: numsInLine[0], y: numsInLine[1])
        let to: Point = Point(x: numsInLine[2], y: numsInLine[3])
        let vent = (from, to)
        
        if (!considerDiagonals) {
            if (from.x == to.x || from.y == to.y) {
                vents.append(vent)
            }
        } else {
            vents.append(vent)
        }
        
    }
    
    var board: [Point: Int] = [:]
    
    for (from, to) in vents {

        var curX = from.x
        var curY = from.y
        
        while (true) {
            let result = board[Point(x: curX, y: curY)]
            if result == nil {
                board[Point(x: curX, y: curY)] = 1
            } else {
                board[Point(x: curX, y: curY)] = result! + 1
            }
            
            if (curX == to.x && curY == to.y) {
                break
            }
            
            if (from.x < to.x) {
                curX += 1
            } else if (from.x > to.x) {
                curX -= 1
            }
            if (from.y < to.y) {
                curY += 1
            } else if (from.y > to.y) {
                curY -= 1
            }
            
        }
        
    }
    
    
    let result = board.values.filter({$0 > 1}).count
    return result
}



func problem_5_1() -> Int {
    return problem_5(considerDiagonals: false)
}

func problem_5_2() -> Int {
    return problem_5(considerDiagonals: true)
}
