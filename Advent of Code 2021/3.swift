//
//  3.swift
//  Advent of Code 2021
//
//  Created by Jake Vossen on 12/2/21.
//

import Foundation


func problem_3_1() -> UInt{
    
    let bits = problem_3_init_helper()
    let data = bits.map {DataLine(bits: $0)}
    let bits_per_line = bits[0].count
    var max_bit_counts: [UInt8] = []
    
    for i in 0...bits_per_line - 1 {
        
        let mcb = get_most_common_bit(for: data, at: i)
        
        switch mcb {
            
        case .zero:
            max_bit_counts.append(UInt8(0))
        case .one:
            max_bit_counts.append(UInt8(1))
        case .tie:
            fatalError("Shouldn't have gotten a tie when doing 3_1")
        }
        
    }
    
    //    print("max bits: \(max_bit_counts)")
    let gamma_bits = max_bit_counts
    let gamma = bit_arr_to_uint(gamma_bits)
    let epsilon = ~gamma & 0xfff
    return gamma * epsilon
}

struct DataLine {
    var bits: [UInt8] = []
    
    func bit(at ix: Int) -> UInt8 {
        return self.bits[ix]
    }
}

func problem_3_2() -> UInt {

    
    func get_new_data_arr(for_arr arr: [DataLine], at ix: Int, keep: UInt) -> [DataLine] {
        var new_data: [DataLine] = []
        for data in arr {
            if (data.bit(at: ix) == keep) {
                new_data.append(data)
            }
        }
        return new_data
    }
    
    let bits = problem_3_init_helper()
    var data: [DataLine] = []
    
    for bitvec in bits {
        data.append(DataLine(bits: bitvec))
    }
    
    let len_of_bit_arr = bits[0].count
    
    var data_for_ox = data
    var ox: UInt?
    var co2: UInt?
    
    
    for col_ix in 0...len_of_bit_arr - 1 { // TODO probably shouldn't harcode 11 here but ¯\_(ツ)_/¯
        let mcb = get_most_common_bit(for: data_for_ox, at: col_ix)
        //        print(data_for_ox)
        
        switch mcb {
            
        case .zero:
            data_for_ox = get_new_data_arr(for_arr: data_for_ox, at: col_ix, keep: 0)
        case .one:
            data_for_ox = get_new_data_arr(for_arr: data_for_ox, at: col_ix, keep: 1)
        case .tie:
            data_for_ox = get_new_data_arr(for_arr: data_for_ox, at: col_ix, keep: 1)
            
        }
        
        if data_for_ox.count == 1 {
            ox = bit_arr_to_uint(data_for_ox[0].bits)
            break
        }
    }
    
    for col_ix in 0...len_of_bit_arr - 1 {
        let mcb = get_most_common_bit(for: data, at: col_ix)
        //        print(data)
        
        switch mcb {
            
        case .zero:
            data = get_new_data_arr(for_arr: data, at: col_ix, keep: 1)
        case .one:
            data = get_new_data_arr(for_arr: data, at: col_ix, keep: 0)
        case .tie:
            data = get_new_data_arr(for_arr: data, at: col_ix, keep: 0)
            
        }
        
        if data.count == 1 {
            co2 = bit_arr_to_uint(data[0].bits)
            break
        }
    }
    
    return co2! * ox!
    
    
}



func problem_3_init_helper() -> [[UInt8]]{
    let filename = "inputs/input-3.txt"
    let contents = try! String(contentsOfFile: filename)
    let lines = contents.split(separator:"\n")
    
    var bits: [[UInt8]] = []
    
    
    
    for line in lines {
        var cur: [UInt8] = []
        for char in line {
            let b = char == "1" ? UInt8(1) : UInt8(0)
            cur.append(b)
        }
        bits.append(cur)
    }
    
    return bits
}

func bit_arr_to_uint(_ arr: [UInt8]) -> UInt {
    var sum: UInt = 0
    
    for (i, e) in arr.reversed().enumerated() {
        sum |= UInt(e) << i
    }
    
    return sum
}


enum CountResult {
    case zero, one, tie
}

func get_most_common_bit(for arr: [DataLine], at ix: Int) -> CountResult {
    var zero_count = 0
    var one_count = 0
    for bitvec in arr {
        if bitvec.bit(at: ix) == 0 {
            zero_count += 1
        } else {
            one_count += 1
        }
    }
    
    if one_count > zero_count {
        return CountResult.one
    } else if zero_count > one_count {
        return CountResult.zero
    } else {
        return CountResult.tie
    }
}
