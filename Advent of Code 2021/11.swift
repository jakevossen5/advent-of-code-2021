//
//  11.swift
//  Advent of Code 2021
//
//  Created by Jake Vossen on 12/10/21.
//

import Foundation

fileprivate typealias Board = [[Int]]

// returns the number of board elements changed
fileprivate func runStep(board: inout Board) -> Int {
    
    
    let rowCount = board.count
    let colCount = board[0].count
    
    // increase everything by one
    for rowIx in 0..<rowCount {
        for colIx in 0..<colCount {
            board[rowIx][colIx] += 1
        }
    }
    
    
    var fixedPoint = false
    var alreadyFlashed: [(Int, Int)] = []

    while !fixedPoint {
        var currentChange = false

        for rowIx in 0..<rowCount {
            for colIx in 0..<colCount {
                let octCurLevel = board[rowIx][colIx]
                if octCurLevel > 9 && !alreadyFlashed.contains(where: {$0 == (rowIx, colIx)}) {
                    let increaseResult = increaseAdjacentNodes(board: &board, rowIx: rowIx, colIx: colIx)
                    if increaseResult {
                        currentChange = true
                    }
                    alreadyFlashed.append((rowIx, colIx))
                }
            }
            
        }
        fixedPoint = !currentChange
    }
    
    // set all the >9s to zero
    for rowIx in 0..<rowCount {
        for colIx in 0..<colCount {
            if (board[rowIx][colIx] > 9) {
                board[rowIx][colIx] = 0
            }
        }
    }
    return alreadyFlashed.count
}

func problem_11_1() -> Int {
    
    var board: Board = getInput()

    var flashCount = 0
    
    for _ in 1...100 {
        let flashedThisStep = runStep(board: &board)
        flashCount += flashedThisStep
    }
    
    return flashCount
}

func problem_11_2() -> Int {

    var board = getInput()
    
    let rowCount = board.count
    let colCount = board[0].count
    
    for step in 1... {
        let updated = runStep(board: &board)
        if updated == rowCount * colCount {
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
