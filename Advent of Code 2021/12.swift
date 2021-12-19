//
//  12.swift
//  Advent of Code 2021
//
//  Created by Jake Vossen on 12/12/21.
//

import Foundation

typealias CaveId = String

struct Cave {
    var id = ""
    var connectedTo: [CaveId] = []
}

func problem_12_1() {
    let filename = "inputs/input-12.tst.txt"
    let contents = try! String(contentsOfFile: filename)
    let lines = contents.split(separator:"\n")
    
    var caves: [CaveId: [CaveId]] = [:]
    
    for line in lines {
        let parts = line.split(separator: "-")
        let fromId = CaveId(parts[0])
        let toId = CaveId(parts[1])
        
        
        // add paths
        if var curNodes = caves[fromId] {
            curNodes.append(toId)
            caves[fromId] = curNodes
        } else {
            caves[fromId] = [toId]
        }
        if var curNodes = caves[toId] {
            curNodes.append(fromId)
            caves[toId] = curNodes
        } else {
            caves[toId] = [fromId]
        }

    }
    
    
    // dfs
    
    var allPaths: [[CaveId]] = []
    
    let backLog = caves["start"]!
    
    
    
    
    
    print(caves)
    
    
}
