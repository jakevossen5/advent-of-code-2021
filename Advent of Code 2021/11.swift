//
//  11.swift
//  Advent of Code 2021
//
//  Created by Jake Vossen on 12/10/21.
//

import Foundation

fileprivate typealias Board = [[Int]]

// returns list of indexes that flashed
fileprivate func runStep(board: inout Board) -> [(Int, Int)] {
    
    
    let row_count = board.count
    let col_count = board[0].count
    
    // increase everything by one
    for rowIx in 0..<row_count {
        for colIx in 0..<col_count {
            board[rowIx][colIx] += 1
        }
    }
    
    
    var change = true
    var alreadyFlashed: [(Int, Int)] = []

    while change {
        var current_change = false

        for rowIx in 0..<row_count {
            for colIx in 0..<col_count {
                let octCurLevel = board[rowIx][colIx]
                if octCurLevel > 9 && !alreadyFlashed.contains(where: {$0 == (rowIx, colIx)}) {
                    let increaseResult = increaseAdjacentNodes(board: &board, rowIx: rowIx, colIx: colIx)
                    if increaseResult {
                        current_change = true
                    }
                    alreadyFlashed.append((rowIx, colIx))
                }
            }
            
        }
        change = current_change
    }
    
    // set all the >9s to zero
    for rowIx in 0..<row_count {
        for colIx in 0..<col_count {
            if (board[rowIx][colIx] > 9) {
                board[rowIx][colIx] = 0
            }
        }
    }
    return alreadyFlashed
}

func problem_11_1() -> Int {
    
    var board: Board = getInput()

    var flashCount = 0
    
    for _ in 1...100 {
        let flashedThisStep = runStep(board: &board)
        flashCount += flashedThisStep.count
    }
    
    return flashCount
}

func problem_11_2() -> Int {

    var board = getInput()
    
    let row_count = board.count
    let col_count = board[0].count
    
    for step in 1... {
        let updated = runStep(board: &board)
        if updated.count == row_count * col_count {
            return step
        }
    }
    fatalError("never finished")

}


// helpers

fileprivate func increaseAdjacentNodes(board: inout Board, rowIx: Int, colIx: Int) -> Bool {
    let possibilities: [(Int, Int)] = [(rowIx - 1, colIx - 1), (rowIx - 1, colIx), (rowIx - 1, colIx + 1), (rowIx, colIx - 1), (rowIx, colIx + 1), (rowIx + 1, colIx - 1), (rowIx + 1, colIx), (rowIx + 1, colIx + 1)]
    
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
        var newLine: [Int] = []
        for char in line {
            newLine.append(Int(String(char))!)
        }
        board.append(newLine)
    }
    
    return board
}
