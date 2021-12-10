//
//  3.swift
//  Advent of Code 2021
//
//  Created by Jake Vossen on 12/2/21.
//

import Foundation


func problem_3_1() -> Int {
    
    let bits = getProblem3Input()
    let data = bits.map {DataLine(bits: $0)}
    let bitsPerLine = bits[0].count
    var maxBitCounts: [Int] = []
    
    for i in 0...bitsPerLine - 1 {
        
        let mcb = getMostCommonBit(for: data, at: i)
        
        switch mcb {
            
        case .zero:
            maxBitCounts.append(Int(0))
        case .one:
            maxBitCounts.append(Int(1))
        case .tie:
            fatalError("Shouldn't have gotten a tie when doing 3_1")
        }
        
    }
    
    //    print("max bits: \(max_bit_counts)")
    let gammaBits = maxBitCounts
    let gamma = bitArrayToInt(gammaBits)
    let epsilon = ~gamma & 0xfff
    return gamma * epsilon
}

struct DataLine {
    var bits: [Int] = []
    
    func bit(at ix: Int) -> Int {
        return self.bits[ix]
    }
}

func problem_3_2() -> Int {
    
    
    func getNewDataArr(forDataArray arr: [DataLine], at ix: Int, keep: Int) -> [DataLine] {
        var new_data: [DataLine] = []
        for data in arr {
            if (data.bit(at: ix) == keep) {
                new_data.append(data)
            }
        }
        return new_data
    }
    
    let bits = getProblem3Input()
    var data: [DataLine] = []
    
    for bitvec in bits {
        data.append(DataLine(bits: bitvec))
    }
    
    let lenOfBitArr = bits[0].count
    
    // Ox = oxygen. Make a copy here because end up messing with when calculating ox, and need a fresh copy for c02
    var dataForOx = data
    var dataForCO2 = data
    var ox: Int?
    var co2: Int?
    
    
    for colIndex in 0...lenOfBitArr - 1 { // TODO probably shouldn't harcode 11 here but ¯\_(ツ)_/¯
        let mcb = getMostCommonBit(for: dataForOx, at: colIndex)
        //        print(data_for_ox)
        
        switch mcb {
            
        case .zero:
            dataForOx = getNewDataArr(forDataArray: dataForOx, at: colIndex, keep: 0)
        case .one:
            dataForOx = getNewDataArr(forDataArray: dataForOx, at: colIndex, keep: 1)
        case .tie:
            dataForOx = getNewDataArr(forDataArray: dataForOx, at: colIndex, keep: 1)
            
        }
        
        if dataForOx.count == 1 {
            ox = bitArrayToInt(dataForOx[0].bits)
            break
        }
    }
    
    for colIndex in 0...lenOfBitArr - 1 {
        let mcb = getMostCommonBit(for: dataForCO2, at: colIndex)
        //        print(data)
        
        switch mcb {
            
        case .zero:
            dataForCO2 = getNewDataArr(forDataArray: dataForCO2, at: colIndex, keep: 1)
        case .one:
            dataForCO2 = getNewDataArr(forDataArray: dataForCO2, at: colIndex, keep: 0)
        case .tie:
            dataForCO2 = getNewDataArr(forDataArray: dataForCO2, at: colIndex, keep: 0)
            
        }
        
        if dataForCO2.count == 1 {
            co2 = bitArrayToInt(dataForCO2[0].bits)
            break
        }
    }
    
    return co2! * ox!
    
    
}



fileprivate func getProblem3Input() -> [[Int]] {
    let filename = "inputs/input-3.txt"
    let contents = try! String(contentsOfFile: filename)
    let lines = contents.split(separator:"\n")
    
    var bits: [[Int]] = []
    
    
    
    for line in lines {
        var cur: [Int] = []
        for char in line {
            let b = char == "1" ? Int(1) : Int(0)
            cur.append(b)
        }
        bits.append(cur)
    }
    
    return bits
}

fileprivate func bitArrayToInt(_ arr: [Int]) -> Int {
    var sum: Int = 0
    
    for (i, e) in arr.reversed().enumerated() {
        sum |= Int(e) << i
    }
    
    return sum
}


enum CountResult {
    case zero, one, tie
}

func getMostCommonBit(for arr: [DataLine], at ix: Int) -> CountResult {
    var zeroCount = 0
    var oneCount = 0
    for bitvec in arr {
        if bitvec.bit(at: ix) == 0 {
            zeroCount += 1
        } else {
            oneCount += 1
        }
    }
    
    if oneCount > zeroCount {
        return CountResult.one
    } else if zeroCount > oneCount {
        return CountResult.zero
    } else {
        return CountResult.tie
    }
}
