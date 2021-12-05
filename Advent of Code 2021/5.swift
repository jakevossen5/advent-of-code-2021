//
//  5.swift
//  Advent of Code 2021
//
//  Created by Jake Vossen on 12/5/21.
//

import Foundation

//typealias Point = (UInt, UInt)

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
        
        vents.append(vent)
    }
//    print(vents)
    
    var board: [Point: UInt] = [:]
    
    for (from, to) in vents {
        if from.x == to.x {
            let stride_dir =  from.y < to.y ? 1 : -1
            for vent_y in stride(from: from.y, through: to.y, by: stride_dir) {
                let result = board[Point(x: from.x, y: vent_y)]
                if result == nil {
                    board[Point(x: from.x, y: vent_y)] = 1
                } else {
                    board[Point(x: from.x, y: vent_y)] = result! + 1
                }
            }
        }
        else if from.y == to.y {
            let stride_dir =  from.x < to.x ? 1 : -1
            let range = stride(from: from.x, through: to.x, by: stride_dir)
            for vent_x in range {

                let result = board[Point(x: vent_x, y: from.y)]
                if result == nil {
                    board[Point(x: vent_x, y: to.y)] = 1
                } else {
                    board[Point(x: vent_x, y: from.y)] = result! + 1
                }
            }
        } else {
            if consider_diagonals {
                let dir = get_direction(from: from, to: to)
                
                var x_increment = 0
                var y_increment = 0
                
                switch dir {
                case .NorthEast:
                    x_increment = 1
                    y_increment = 1
                case .NorthWest:
                    x_increment = -1
                    y_increment = 1
                case .SouthEast:
                    x_increment = 1
                    y_increment = -1
                case .SouthWest:
                    x_increment = -1
                    y_increment = -1
                }
                
                var cur_x = from.x
                var cur_y = from.y
                
                while (cur_x != to.x && cur_y != to.y) {
                    let result = board[Point(x: cur_x, y: cur_y)]
                    if result == nil {
                        board[Point(x: cur_x, y: cur_y)] = 1
                    } else {
                        board[Point(x: cur_x, y: cur_y)] = result! + 1
                    }
                    cur_x = UInt(Int(cur_x) + x_increment)
                    cur_y = UInt(Int(cur_y) + y_increment)
                }
                
                // do it one more time?
                let result = board[Point(x: cur_x, y: cur_y)]
                if result == nil {
                    board[Point(x: cur_x, y: cur_y)] = 1
                } else {
                    board[Point(x: cur_x, y: cur_y)] = result! + 1
                }
                
            }
        }
    }
    
    let result = board.values.filter({$0 > 1}).count
    return UInt(exactly: result)!
}
enum Direction {
    case NorthEast
    case NorthWest
    case SouthEast
    case SouthWest
}

func get_direction(from: Point, to: Point) -> Direction {
    if from.x < to.x && from.y < to.y {
        return Direction.NorthEast
    } else if from.x < to.x && from.y > to.y {
        return Direction.SouthEast
    } else if from.x > to.x && from.y < to.y {
        return Direction.NorthWest
    } else if from.x > to.x && from.y > to.y {
        return Direction.SouthWest
    }
    fatalError("coulnd't find direction")
}



func problem_5_1() -> UInt {
    return problem_5(consider_diagonals: false)
}

func problem_5_2() -> UInt {
    return problem_5(consider_diagonals: true)
}
