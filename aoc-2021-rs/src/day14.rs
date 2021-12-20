use std::{collections::HashMap, cmp};

use itertools::Itertools;

use crate::utils::get_input_lines;

struct Rule {
    pub lhs: (char, char),
    pub rhs: char,
}

pub fn day_14_1() -> usize {
    let lines = get_input_lines("inputs/day-14.txt");

    let mut cur: Vec<char> = lines[0].clone().chars().collect();

    let mut rules = Vec::new();

    for line in lines.iter().skip(2) {
        let mut lhs = line[0..2].chars();

        let rhs = line.chars().last().unwrap();

        let new_rule = Rule { lhs: (lhs.next().unwrap(), lhs.next().unwrap()), rhs };
        rules.push(new_rule)

    }

    for i in 0..10 {
        let mut new: Vec<char> = Vec::new();
        for (a, b) in cur.iter().tuple_windows() {
            let reconstructed = (*a, *b);
            new.push(*a);
            for Rule {lhs, rhs} in &rules {
                if *lhs == reconstructed {
                    // println!("applying rule where lhs = {:?}, and rhs = {:?}", lhs, rhs);
                    new.push(*rhs);
                }
            }
            // new.push(*b);
        }
        new.push(*cur.last().unwrap());
        cur = new;
        let cur_str: String = cur.iter().collect();
        // println!("at set {}, we have {}", i, cur_str);
    }

    let mut char_counts: HashMap<char, usize> = HashMap::new();

    for char in cur {
        let val = char_counts.entry(char).or_insert(0);
        *val += 1
    }

    let max_char = char_counts.iter().max_by(|(_, c1), (_, c2)| c1.cmp(c2)).unwrap();
    let min_char = char_counts.iter().min_by(|(_, c1), (_, c2)| c1.cmp(c2)).unwrap();

    let max_char_count = max_char.1;
    let min_char_count = min_char.1;

    max_char_count - min_char_count
}

type Pair = (char, char);

pub fn day_14_2() -> i128 {

    let mut char_pairs: HashMap<Pair, i128> = HashMap::new();

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

        let new_rule = Rule { lhs: (lhs.next().unwrap(), lhs.next().unwrap()), rhs };
        rules.push(new_rule)

    }

    for i in 0..40 {
        let mut mods_to_make: HashMap<Pair, i128> = HashMap::new();
        for rule in &rules {
            let lhs = rule.lhs;
            let rhs = rule.rhs;

            let old = char_pairs.entry(lhs).or_insert(0);
            let v = mods_to_make.entry(lhs).or_insert(0);
            let count = *old;
            *v -= *old as i128;

            let old_right = char_pairs.entry((lhs.0, rhs)).or_insert(0);
            let v = mods_to_make.entry((lhs.0, rhs)).or_insert(0);
            *v += count;
            drop(v);

            let old_left = char_pairs.entry((rhs, lhs.1)).or_insert(0);
            let v = mods_to_make.entry((rhs, lhs.1)).or_insert(0);
            *v += count;

        }
        for (pair, diff) in mods_to_make {
            let v = char_pairs.entry(pair).or_insert(0);
            *v += diff;
        }

        // println!("char_pairs at {:?}, {:?}", i, char_pairs);

    }

    let mut counts: HashMap<char, i128> = HashMap::new();

    for ((char1, char2), count) in char_pairs {
        // let v = counts.entry(char1).or_insert(0);
        // *v += count;
        // drop(v);

        let v = counts.entry(char2).or_insert(0);
        *v += count;

    }

    // println!("counts: {:?}", counts);

    let max_char = counts.iter().max_by(|(_, c1), (_, c2)| c1.cmp(c2)).unwrap();
    let min_char = counts.iter().min_by(|(_, c1), (_, c2)| c1.cmp(c2)).unwrap();

    let max_char_count = max_char.1;
    let min_char_count = min_char.1;

    max_char_count - min_char_count

}
