//
//  9.swift
//  Advent of Code 2021
//
//  Created by Jake Vossen on 12/8/21.
//

import Foundation

fileprivate typealias Board = [[Int]]

// We have used points in other places, but we are going to recreate this using row and col instead of x and y
fileprivate struct Point {
    var row: Int = 0
    var col: Int = 0
}

extension Point: Hashable {
    static func == (lhs: Point, rhs: Point) -> Bool {
        return lhs.row == rhs.row && lhs.col == rhs.col
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(row)
        hasher.combine(col)
    }
}

func problem_9_1() -> Int {
    
    let board = get_board()
    var score_sum = 0
    let low_ixs = get_low_points(board: board)
    
    for point in low_ixs {
        let row = point.row
        let col = point.col
        
        score_sum += 1 + board[row][col]
    }
    
    return score_sum
    
}

fileprivate func get_low_points(board: Board) -> [Point] {
    let cols = board[0].count
    let rows = board.count
    
    var low_ixs: [Point] = []
    
    for row in 0..<rows {
        for col in 0..<cols {
            
            let at = board[row][col]
            let above = row - 1 < 0 ? Int.max : board[row - 1][col]
            let below = row + 1 >= rows ? Int.max : board[row + 1][col]
            let left = col - 1 < 0 ? Int.max : board[row][col - 1]
            let right = col + 1 >= cols ? Int.max : board[row][col + 1]
            
            if (at < above && at < below && at < left && at < right) {
                low_ixs.append(Point(row: row, col: col))
            }
            
        }
    }
    
    return low_ixs
}

fileprivate func get_board() -> Board {
    let filename = "inputs/input-9.txt"
    let contents = try! String(contentsOfFile: filename)
    let lines = contents.split(separator:"\n")
    
    var board: Board = []
    for line in lines {
        var board_line: [Int] = []
        for c in line {
            board_line.append(Int(String(c))!)
        }
        board.append(board_line)
    }
    
    return board
}


func problem_9_2() -> Int {
    
    let board = get_board()
    
    let cols = board[0].count
    let rows = board.count
    
    let low_ixs: [Point] = get_low_points(board: board)
    
    var all_basins: [Set<Point>] = []
    
    
    for point in low_ixs {
        
        var part_of_basin: Set<Point> = Set([point])
        var to_check: Set<Point> = Set([point])
        
        while !to_check.isEmpty {
            let cur_point = to_check.popFirst()!
            part_of_basin.insert(cur_point)
            
            let row = cur_point.row
            let col = cur_point.col
            
            if row - 1 >= 0 && board[row - 1][col] < 9 {
                let maybe_point = Point(row: row - 1, col: col)
                if !part_of_basin.contains(maybe_point) {
                    to_check.insert(maybe_point)
                    part_of_basin.insert(maybe_point)
                }
            }
            if row + 1 < rows && board[row + 1][col] < 9 {
                let maybe_point = Point(row: row + 1, col: col)
                if !part_of_basin.contains(maybe_point) {
                    to_check.insert(maybe_point)
                }
            }
            if col - 1 >= 0 && board[row][col - 1] < 9 {
                let maybe_point = Point(row: row, col: col - 1)
                if !part_of_basin.contains(maybe_point) {
                    to_check.insert(maybe_point)
                }
            }
            if col + 1 < cols && board[row][col + 1] < 9 {
                let maybe_point = Point(row: row, col: col + 1)
                if !part_of_basin.contains(maybe_point) {
                    to_check.insert(maybe_point)
                }
            }
        }
        
        all_basins.append(part_of_basin)
        
    }
    
    let result = all_basins.map({$0.count}).sorted().reversed().prefix(3).reduce(1, {x, y in x * y})
    
    return result
}
