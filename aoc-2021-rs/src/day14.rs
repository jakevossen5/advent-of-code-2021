use std::{collections::HashMap};

use itertools::Itertools;

use crate::utils::get_input_lines;

struct Rule {
    pub lhs: (char, char),
    pub rhs: char,
}

pub fn day_14_1() -> usize {
    day14(10)
}

type Pair = (char, char);

pub fn day_14_2() -> usize {
    day14(40)
}

fn day14(steps: usize) -> usize {
    let mut char_pairs: HashMap<Pair, isize> = HashMap::new();

    let lines = get_input_lines("inputs/day-14.txt");

    let cur: Vec<char> = lines[0].clone().chars().collect();

    for (a, b) in cur.iter().tuple_windows() {
        let v = char_pairs.entry((*a, *b)).or_insert(0);
        *v += 1;
    }

    // println!("initial char pairs: {:?}", char_pairs);

    let mut rules = Vec::new();

    for line in lines.iter().skip(2) {
        let mut lhs = line[0..2].chars();

        let rhs = line.chars().last().unwrap();

        let new_rule = Rule {
            lhs: (lhs.next().unwrap(), lhs.next().unwrap()),
            rhs,
        };
        rules.push(new_rule)
    }

    for _ in 0..steps {
        let mut mods_to_make: HashMap<Pair, isize> = HashMap::new();
        for rule in &rules {
            let lhs = rule.lhs;
            let rhs = rule.rhs;

            let old = char_pairs.entry(lhs).or_insert(0);
            let v = mods_to_make.entry(lhs).or_insert(0);
            let count = *old;
            *v -= *old as isize;

            let v = mods_to_make.entry((lhs.0, rhs)).or_insert(0);
            *v += count;
            drop(v);

            let v = mods_to_make.entry((rhs, lhs.1)).or_insert(0);
            *v += count;
        }
        for (pair, diff) in mods_to_make {
            let v = char_pairs.entry(pair).or_insert(0);
            *v += diff;
        }
    }

    let mut counts: HashMap<char, usize> = HashMap::new();

    for ((_, c), count) in char_pairs {
        let v = counts.entry(c).or_insert(0);
        *v += count as usize;
    }

    let max_char = counts.iter().max_by(|(_, c1), (_, c2)| c1.cmp(c2)).unwrap();
    let min_char = counts.iter().min_by(|(_, c1), (_, c2)| c1.cmp(c2)).unwrap();

    let max_char_count = max_char.1;
    let min_char_count = min_char.1;

    max_char_count - min_char_count
}
