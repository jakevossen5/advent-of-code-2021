//
//  4.swift
//  Advent of Code 2021
//
//  Created by Jake Vossen on 12/4/21.
//

import Foundation

fileprivate typealias BingoBoard = [[Int]]

func problem_4_1() -> Int {
    
    let (boards, picks) = get_input_4()
    
    for i in 0..<picks.count {
        let currentPicks = picks[0...i]
        
        for board in boards {
            let result = boardScorer(board: board, picks: [Int](currentPicks))
            if let score = result {
                let mostRecentPick = currentPicks.last!
                return mostRecentPick * score
            }
        }
    }
    fatalError("Failed to find winning board for 4-1")
}

func problem_4_2() -> Int {

    var (boards, picks) = get_input_4()
    
    for i in 0..<picks.count {
        let currentPicks = picks[0...i]
        
        var remainingBoards: [BingoBoard] = []

        for board in boards {
            let result = boardScorer(board: board, picks: [Int](currentPicks))
            if let score = result {
                if boards.count == 1 {
                    return score * currentPicks.last!
                }
            } else {
                remainingBoards.append(board)
            }
        }
        boards = remainingBoards
        
    }
    
    fatalError("never got down to just one winning board")
}



fileprivate func boardScorer(board: BingoBoard, picks: [Int]) -> Int? {
    
    let hoz_0 = Set(board[0])
    let hoz_1 = Set(board[1])
    let hoz_2 = Set(board[2])
    let hoz_3 = Set(board[3])
    let hoz_4 = Set(board[4])
    
    var vert_0: Set<Int> = Set()
    var vert_1: Set<Int> = Set()
    var vert_2: Set<Int> = Set()
    var vert_3: Set<Int> = Set()
    var vert_4: Set<Int> = Set()
    
    for line in board {
        for (i, e) in line.enumerated() {
            switch i {
            case 0:
                vert_0.insert(e)
            case 1:
                vert_1.insert(e)
            case 2:
                vert_2.insert(e)
            case 3:
                vert_3.insert(e)
            case 4:
                vert_4.insert(e)
            default:
                fatalError("inexpected i when going through ")
            }
        }
    }
    
    let everythingToCheck = Set([hoz_0, hoz_1, hoz_2, hoz_3, hoz_4, vert_0, vert_1, vert_2, vert_3, vert_4])
    
    let picksSet = Set(picks)
    
    for e in everythingToCheck {
        if e.isSubset(of: picksSet) {
            let score = board.joined().filter {!picksSet.contains($0)}.reduce(0, {x, y in x + y})
            return score
        }
    }
    return nil
}



fileprivate func get_input_4() -> ([BingoBoard], [Int]) {
    let filename = "inputs/input-4.txt"
    let contents = try! String(contentsOfFile: filename)
    let lines = contents.split(separator:"\n")
    
    let firstLine = lines[0]
    
    var boards: [BingoBoard] = []
    
    var offset = 1
    while offset < lines.count - 4 {
        var newBoard: BingoBoard = []
        for i in offset...offset+4 {
            let curLine = lines[i]
            let curValues = curLine.split(separator: " ").map {Int($0)!}
            guard !curValues.isEmpty else {
                fatalError("Couldn't get any values")
            }
            //            print("adding \(cur_values) to current board")
            newBoard.append(curValues)
        }
        offset += 5
        boards.append(newBoard)
    }
    
    // printing boards in a resonable format
    //    for board in boards {
    //        for board_line in board {
    //            print(board_line)
    //        }
    //        print()
    //    }
    
    
    let picks = firstLine.split(separator: ",").map {Int($0)!}
    
    return (boards, picks)
}
