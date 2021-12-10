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
    
    let board = getBoard()
    var scoreSum = 0
    let lowIndexs = getLowPoints(board: board)
    
    for point in lowIndexs {
        let row = point.row
        let col = point.col
        
        scoreSum += 1 + board[row][col]
    }
    
    return scoreSum
    
}

fileprivate func getLowPoints(board: Board) -> [Point] {
    let cols = board[0].count
    let rows = board.count
    
    var lowIndexs: [Point] = []
    
    for row in 0..<rows {
        for col in 0..<cols {
            
            let at = board[row][col]
            let above = row - 1 < 0 ? Int.max : board[row - 1][col]
            let below = row + 1 >= rows ? Int.max : board[row + 1][col]
            let left = col - 1 < 0 ? Int.max : board[row][col - 1]
            let right = col + 1 >= cols ? Int.max : board[row][col + 1]
            
            if (at < above && at < below && at < left && at < right) {
                lowIndexs.append(Point(row: row, col: col))
            }
            
        }
    }
    
    return lowIndexs
}

fileprivate func getBoard() -> Board {
    let filename = "inputs/input-9.txt"
    let contents = try! String(contentsOfFile: filename)
    let lines = contents.split(separator:"\n")
    
    var board: Board = []
    for line in lines {
        var boardLine: [Int] = []
        for c in line {
            boardLine.append(Int(String(c))!)
        }
        board.append(boardLine)
    }
    
    return board
}


func problem_9_2() -> Int {
    
    let board = getBoard()
    
    let cols = board[0].count
    let rows = board.count
    
    let lowIndexs: [Point] = getLowPoints(board: board)
    
    var allBasins: [Set<Point>] = []
    
    
    for point in lowIndexs {
        
        var partOfBasin: Set<Point> = Set([point])
        var toCheck: Set<Point> = Set([point])
        
        while !toCheck.isEmpty {
            let curPoint = toCheck.popFirst()!
            partOfBasin.insert(curPoint)
            
            let row = curPoint.row
            let col = curPoint.col
            
            if row - 1 >= 0 && board[row - 1][col] < 9 {
                let maybePoint = Point(row: row - 1, col: col)
                if !partOfBasin.contains(maybePoint) {
                    toCheck.insert(maybePoint)
                    partOfBasin.insert(maybePoint)
                }
            }
            if row + 1 < rows && board[row + 1][col] < 9 {
                let maybePoint = Point(row: row + 1, col: col)
                if !partOfBasin.contains(maybePoint) {
                    toCheck.insert(maybePoint)
                }
            }
            if col - 1 >= 0 && board[row][col - 1] < 9 {
                let maybePoint = Point(row: row, col: col - 1)
                if !partOfBasin.contains(maybePoint) {
                    toCheck.insert(maybePoint)
                }
            }
            if col + 1 < cols && board[row][col + 1] < 9 {
                let maybePoint = Point(row: row, col: col + 1)
                if !partOfBasin.contains(maybePoint) {
                    toCheck.insert(maybePoint)
                }
            }
        }
        
        allBasins.append(partOfBasin)
        
    }
    
    let result = allBasins.map({$0.count}).sorted().reversed().prefix(3).reduce(1, {x, y in x * y})
    
    return result
}
