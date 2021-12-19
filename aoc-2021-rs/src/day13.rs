use std::{collections::HashSet, ops::RangeBounds};

use crate::utils::get_input_lines;

enum Axis {
    x,
    y,
}

pub fn day_13_1() -> usize {
    let (points, folds) = day_13_input();

    let (axis, offset) = &folds[0];

    let mut new_points: HashSet<(isize, isize)> = HashSet::new();

    match axis {
        Axis::x => {
            // fold LEFT

            for (x, y) in points {
                if x > *offset {
                    let distance_to_offset = x - offset;
                    let new_x = offset - distance_to_offset;
                    if new_x >= 0 {
                        new_points.insert((new_x, y));
                    }
                } else {
                    new_points.insert((x, y));
                }
            }
        }
        Axis::y => {
            for (x, y) in points {
                if y > *offset {
                    let distance_to_offset = y - offset;
                    let new_y = offset - distance_to_offset;
                    if new_y >= 0 {
                        new_points.insert((x, new_y));
                    }
                } else {
                    new_points.insert((x, y));
                }
            }
        }
    }

    println!("new points: {:?}", new_points);

    new_points.len()
}


pub fn day_13_2() -> HashSet<(isize, isize)> {

    let (mut points, folds) = day_13_input();

    for (axis, offset) in folds {
        let mut new_points: HashSet<(isize, isize)> = HashSet::new();

        match axis {
            Axis::x => {
                // fold LEFT
                for (x, y) in &points {
                    if *x >= offset {
                        let distance_to_offset = x - offset;
                        let new_x = offset - distance_to_offset;
                        if new_x >= 0 {
                            new_points.insert((new_x, *y));
                        }
                    } else {
                        new_points.insert((*x, *y));
                    }
                }
            }
            Axis::y => {
                for (x, y) in &points {
                    if *y >= offset {
                        let distance_to_offset = y - offset;
                        let new_y = offset - distance_to_offset;
                        if new_y >= 0 {
                            new_points.insert((*x, new_y));
                        }
                    } else {
                        new_points.insert((*x, *y));
                    }
                }
            }
        }

        points = new_points
    }


    let max_x = *points.iter().map(|(x, _)| x).max().unwrap();
    let max_y = *points.iter().map(|(_, y)| y).max().unwrap();

    for y in 0..max_y + 1 {
        for x in 0..max_x + 1 {
            if points.contains(&(x, y)) {
                print!("#");
            } else {
                print!(".");
            }
        }
        println!();
    }

    points


}

fn day_13_input() -> (HashSet<(isize, isize)>, Vec<(Axis, isize)>) {
    let lines = get_input_lines("inputs/day-13.txt");
    let mut points: HashSet<(isize, isize)> = HashSet::new();

    for line in lines.iter().filter(|line| line.contains(",")) {
        let parts: Vec<isize> = line.split(",").map(|x| x.parse().unwrap()).collect();
        let point: (isize, isize) = (parts[0], parts[1]);
        points.insert(point);
    }

    println!("points: {:?}", points);

    let mut folds: Vec<(Axis, isize)> = Vec::new();

    for line in lines.iter().filter(|line| line.contains("=")) {
        let prefix = "fold along y=";
        let prefix_len = prefix.len();

        let fold_offset_str: String = line.chars().skip(prefix_len).collect();
        let fold_offset: isize = fold_offset_str.parse().unwrap();
        println!("fold offset {}", fold_offset);

        if line.contains("x=") {
            folds.push((Axis::x, fold_offset))
        } else {
            folds.push((Axis::y, fold_offset))
        }
    }

    (points, folds)
}