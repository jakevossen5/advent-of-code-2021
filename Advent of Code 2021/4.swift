//
//  4.swift
//  Advent of Code 2021
//
//  Created by Jake Vossen on 12/4/21.
//

import Foundation

func problem_4_1() -> UInt {

    
    let filename = "inputs/input-4.txt"
    let contents = try! String(contentsOfFile: filename)
    let lines = contents.split(separator:"\n")
    
    let first_line = lines[0]
    
    var boards: [[[UInt]]] = []
    
    var offset = 1
    while offset < lines.count - 4 {
        var new_board: [[UInt]] = []
        for i in offset...offset+4 {
            let cur_line = lines[i]
            let cur_values = cur_line.split(separator: " ").map {UInt($0)!}
            guard !cur_values.isEmpty else {
                fatalError("Couldn't get any values")
            }
            print("adding \(cur_values) to current board")
            new_board.append(cur_values)
        }
        offset += 5
        boards.append(new_board)
    }
    
    // printing boards in a resonable format
    for board in boards {
        for board_line in board {
            print(board_line)
        }
        print()
    }
    
    
    let picks = first_line.split(separator: ",").map {UInt($0)!}
    print("picks: \(picks)")
    
    for i in 0..<picks.count {
        let current_picks = picks[0...i]
        
        for board in boards {
            let result = board_checker(board: board, picks: [UInt](current_picks))
            if let score = result {
                print("We have a winner!")
                print("score \(score)")
                let most_recent_pick = current_picks.last!
                return most_recent_pick * score
            } else {
                print("no winner yet")
            }
        }
        
    }

    
    return 0
}


func board_checker(board: [[UInt]], picks: [UInt]) -> UInt? {
    
    let hoz_0 = Set(board[0])
    let hoz_1 = Set(board[1])
    let hoz_2 = Set(board[2])
    let hoz_3 = Set(board[3])
    let hoz_4 = Set(board[4])
    
    var vert_0: Set<UInt> = Set()
    var vert_1: Set<UInt> = Set()
    var vert_2: Set<UInt> = Set()
    var vert_3: Set<UInt> = Set()
    var vert_4: Set<UInt> = Set()

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
    
    let everything_to_check = Set([hoz_0, hoz_1, hoz_2, hoz_3, hoz_4, vert_0, vert_1, vert_2, vert_3, vert_4])
    
    let picks_set = Set(picks)
    
    for e in everything_to_check {
        print("checking \(e) against \(picks_set)")
        if e.isSubset(of: picks_set) {
            // have to sum e now to get the score
            let score = board.joined().filter {!picks_set.contains($0)}.reduce(0, {x, y in x + y})
            return score
        }
    }
    return nil
}
