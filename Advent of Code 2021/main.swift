//
//  main.swift
//  Advent of Code 2021
//
//  Created by Jake Vossen on 11/30/21.
//

print("problem 1_1: \(problem_1_1())")
print("problem 1_2: \(problem_1_2())")
print("problem 2_1: \(problem_2_1())")
print("problem 2_2: \(problem_2_2())")
print("problem 3_1: \(problem_3_1())")
print("problem 3_2: \(problem_3_2())")
print("problem 4_1: \(problem_4_1())")
print("problem 4_2: \(problem_4_2())")
print("problem 5_1: \(problem_5_1())")
print("problem 5_2: \(problem_5_2())")


test()

func test() {
    assert(problem_1_1() == 1121)
    assert(problem_1_2() == 1065)
    assert(problem_2_1() == 1484118)
    assert(problem_2_2() == 1463827010)
    assert(problem_3_1() == 3923414)
    assert(problem_3_2() == 5852595)
    assert(problem_4_1() == 21607)
    assert(problem_4_2() == 19012)
    assert(problem_5_1() == 8350)
    assert(problem_5_2() == 19374)
}
