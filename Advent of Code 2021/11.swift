//
//  11.swift
//  Advent of Code 2021
//
//  Created by Jake Vossen on 12/10/21.
//

import Foundation

fileprivate typealias Board = [[Int]]

//fileprivate func runStep(board: inout Board)

func problem_11_1() -> Int {
    
    var board: Board = getInput()
    
    print(board)
    
    let row_count = board.count
    let col_count = board[0].count
    
    var flashCount = 0
    
    for _ in 1...100 {
        // increase every one by one
        for row_ix in 0..<row_count {
            for col_ix in 0..<col_count {
                board[row_ix][col_ix] += 1
            }
        }
        
        
        var change = true
        
        print(board)
        var alreadyFlashed: [(Int, Int)] = []

        while change {
            var current_change = false

            for row_ix in 0..<row_count {
                for col_ix in 0..<col_count {
                    let oct_level = board[row_ix][col_ix]
                    if oct_level > 9 && alreadyFlashed.filter({$0 == (row_ix, col_ix)}).count == 0 {
                        flashCount += 1
                        let increaseResult = increaseAdjacentNodes(board: &board, row_ix: row_ix, colIx: col_ix)
                        if increaseResult {
                            current_change = true
                        }
                        alreadyFlashed.append((row_ix, col_ix))
                    }
                }
                
            }
            change = current_change
        }
        
        // set all the >9s to zero
        for row_ix in 0..<row_count {
            for col_ix in 0..<col_count {
                if (board[row_ix][col_ix] > 9) {
                    board[row_ix][col_ix] = 0
                }
            }
        }
    }
    
    
    
    
    return flashCount
}

fileprivate func increaseAdjacentNodes(board: inout Board, row_ix: Int, colIx: Int) -> Bool {
    let possibilities: [(Int, Int)] = [(row_ix - 1, colIx - 1), (row_ix - 1, colIx), (row_ix - 1, colIx + 1), (row_ix, colIx - 1), (row_ix, colIx + 1), (row_ix + 1, colIx - 1), (row_ix + 1, colIx), (row_ix + 1, colIx + 1)]
    
    var changedAnything = false
    
    let row_count = board.count
    let col_count = board[0].count
    
    for (maybeRow, maybeCol) in possibilities {
        if (maybeRow >= 0 && maybeRow < row_count) && (maybeCol >= 0 && maybeCol < col_count) {
            board[maybeRow][maybeCol] += 1
            changedAnything = true
        }
    }
    
    return changedAnything
    
}

fileprivate func getInput() -> Board {
    let filename = "inputs/input-11.txt"
    let contents = try! String(contentsOfFile: filename)
    let lines = contents.split(separator:"\n")
    
    var board: Board = []
    
    
    for line in lines {
        var temp_b: [Int] = []
        for char in line {
            temp_b.append(Int(String(char))!)
        }
        board.append(temp_b)
    }
    
    return board
}

func problem_11_2() -> Int {

    var board = getInput()
    
    print(board)
    
    let row_count = board.count
    let col_count = board[0].count
    
    var flashCount = 0
    
    for step in 1... {
        // increase every one by one
        for row_ix in 0..<row_count {
            for col_ix in 0..<col_count {
                board[row_ix][col_ix] += 1
            }
        }
        
        
        var change = true
        
//        print("starting while change")
        print(board)
        var alreadyFlashed: [(Int, Int)] = []

        while change {
//            print("outer while change")
            
            var current_change = false

            for row_ix in 0..<row_count {
                for col_ix in 0..<col_count {
                    let oct_level = board[row_ix][col_ix]
                    if oct_level > 9 && alreadyFlashed.filter({$0 == (row_ix, col_ix)}).count == 0 {
                        flashCount += 1
                        let increaseResult = increaseAdjacentNodes(board: &board, row_ix: row_ix, colIx: col_ix)
                        if increaseResult {
                            current_change = true
                        }
                        alreadyFlashed.append((row_ix, col_ix))
//                        print("in with \(row_ix), \(col_ix)")
                    }
                }
                
            }
            change = current_change
        }
        
        if alreadyFlashed.count == row_count * col_count {
            return step
        }
        
        // increase every one by one
        for row_ix in 0..<row_count {
            for col_ix in 0..<col_count {
                if (board[row_ix][col_ix] > 9) {
                    board[row_ix][col_ix] = 0
                }
            }
        }
    }
    
    return flashCount
}

