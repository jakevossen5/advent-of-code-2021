use std::collections::{BinaryHeap, HashMap, HashSet};

use crate::utils::get_input_lines;

type Board = Vec<Vec<usize>>;

fn day_15_input() -> Board {
    // let mut heap = BinaryHeap::new();

    let lines = get_input_lines("inputs/day-15.txt");

    let mut board: Board = Vec::new();

    for line in lines {
        let mut this_line = Vec::new();
        for char in line.chars() {
            this_line.push(char.to_string().parse::<usize>().unwrap());
        }
        board.push(this_line);
    }
    board
}

pub fn day_15_1() -> usize {
    let board = day_15_input();

    solve_board(&board)
}

pub fn day_15_2() -> usize {
    let board = day_15_input();

    let mut new_board = board.clone();

    for (ix, row) in board.iter().enumerate() {
        for shift in 1..5 {
            let mut new = row.clone();

            for e in new.iter_mut() {
                let shifted = *e + shift;
                if shifted > 9 {
                    *e = shifted - 9;
                } else {
                    *e = shifted;
                }
            }

            new_board[ix].extend(new);
        }
    }

    let saved_board = new_board.clone();

    for shift in 1..5 {
        let mut dupe = saved_board.clone();
        for row in dupe.iter_mut() {
            for e in row.iter_mut() {
                let shifted = *e + shift;
                if shifted > 9 {
                    *e = shifted - 9;
                } else {
                    *e = shifted;
                }
            }
        }
        new_board.extend(dupe);
    }

    solve_board(&new_board)
}

// This is a poor implementation of Dijkstra's algorithm. Big problem is not using a priority queue to get the next smallest distance
// For par 2, it takes about 40 minutes to solve
fn solve_board(board: &Board) -> usize {
    let mut unvisited = HashSet::new();
    let mut distance_values = HashMap::new();

    let rows = board.len() as isize;
    let cols = board[1].len() as isize;

    for row in 0..rows {
        for col in 0..cols {
            unvisited.insert((row, col));
            if row == 0 && col == 0 {
                distance_values.insert((row, col), 0);
            } else {
                distance_values.insert((row, col), isize::MAX);
            }
        }
    }

    let mut current_node = (0_isize, 0_isize);
    let target = (rows - 1, cols - 1);

    let mut loop_num = 0;

    while current_node != target {
        loop_num += 1;
        if loop_num % 100 == 0 {
            println!(
                "testing {:?} (target: {:?}, have tested {} so far)",
                current_node, target, loop_num
            );
        }
        let (cur_row, cur_col) = current_node;
        let cur_node_distance = *distance_values.get(&current_node).unwrap();
        debug_assert!(cur_node_distance != isize::MAX);

        // consider neighbors
        let above = (cur_row - 1, cur_col);
        let below = (cur_row + 1, cur_col);
        let left = (cur_row, cur_col - 1);
        let right = (cur_row, cur_col + 1);

        let to_check = [above, below, left, right];

        for point_to_check in to_check
            .iter()
            .filter(|(r, c)| *r >= 0 && *c >= 0 && *r < rows && *c < cols)
        {
            let existing_distance = *distance_values.get(&point_to_check).unwrap();
            let path_cost = board[point_to_check.0 as usize][point_to_check.1 as usize];

            if path_cost + (cur_node_distance as usize) < existing_distance as usize {
                distance_values.insert(*point_to_check, path_cost as isize + (cur_node_distance));
            }
        }
        unvisited.remove(&current_node);

        // let next_node = *distance_values.iter().filter(|(p, _)| unvisited.contains(p)).min_by(|(p1, d1), (p2 ,d2)| d1.cmp(d2)).unwrap().0;
        let next_node = *unvisited
            .iter()
            .min_by(|d1, d2| {
                distance_values
                    .get(d1)
                    .unwrap()
                    .cmp(distance_values.get(d2).unwrap())
            })
            .unwrap();
        current_node = next_node;
    }
    *distance_values.get(&target).unwrap() as usize
}
