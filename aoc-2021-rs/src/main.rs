use crate::{
    day12::day_12_1,
    day13::{day_13_1, day_13_2},
};

mod day12;
mod day13;
mod utils;

fn main() {
    println!("day_12_1: {:?}", day_12_1());
    // println!("day_12_2: {:?}", day_12_2());
    println!("day_13_1: {:?}", day_13_1());
    println!("day_13_2: {:?}", day_13_2());
}

#[cfg(test)]
mod tests {
    use std::collections::HashSet;

    use crate::{
        day12::{day_12_1, day_12_2},
        day13::{day_13_1, day_13_2},
    };

    #[test]
    fn day_12() {
        assert_eq!(day_12_1(), 5874);
        assert_eq!(day_12_2(), 153592);
    }
    #[test]
    fn day_13() {
        let part_2_expected_result = HashSet::from_iter([
            (23, 2),
            (15, 2),
            (22, 3),
            (8, 5),
            (32, 2),
            (30, 0),
            (0, 4),
            (2, 3),
            (36, 3),
            (12, 5),
            (15, 5),
            (15, 1),
            (7, 2),
            (32, 5),
            (26, 0),
            (33, 0),
            (11, 2),
            (25, 1),
            (28, 3),
            (25, 2),
            (28, 4),
            (3, 2),
            (5, 0),
            (27, 0),
            (18, 0),
            (36, 0),
            (1, 3),
            (21, 3),
            (7, 0),
            (15, 0),
            (8, 1),
            (33, 5),
            (25, 4),
            (30, 5),
            (8, 0),
            (5, 4),
            (31, 5),
            (37, 3),
            (30, 3),
            (35, 5),
            (20, 2),
            (10, 3),
            (11, 0),
            (18, 3),
            (30, 1),
            (15, 4),
            (10, 0),
            (18, 1),
            (26, 3),
            (2, 0),
            (16, 2),
            (35, 4),
            (6, 3),
            (0, 3),
            (28, 2),
            (35, 0),
            (10, 5),
            (1, 0),
            (0, 2),
            (37, 4),
            (13, 5),
            (20, 1),
            (30, 4),
            (22, 4),
            (20, 0),
            (38, 1),
            (23, 5),
            (17, 2),
            (35, 3),
            (31, 2),
            (6, 5),
            (18, 2),
            (10, 1),
            (28, 5),
            (18, 4),
            (31, 0),
            (18, 5),
            (10, 4),
            (12, 2),
            (35, 1),
            (25, 3),
            (0, 5),
            (7, 5),
            (22, 0),
            (30, 2),
            (38, 2),
            (32, 0),
            (15, 3),
            (3, 1),
            (6, 0),
            (20, 5),
            (12, 0),
            (11, 5),
            (25, 5),
            (0, 0),
            (23, 1),
            (35, 2),
            (37, 0),
            (13, 0),
            (28, 1),
            (21, 0),
            (10, 2),
            (20, 3),
            (20, 4),
            (5, 5),
            (0, 1),
            (27, 3),
            (38, 5),
        ]);
        assert_eq!(day_13_1(), 814);
        assert_eq!(day_13_2(), part_2_expected_result);
    }
}
