use std::{
    collections::{HashMap, HashSet, VecDeque},
    fmt::format,
    fs::File,
    io::{BufRead, BufReader},
};
pub fn get_input_lines(filename: &str) -> Vec<String> {
    let mut lines = Vec::new();
    let file = File::open(filename).unwrap();
    let reader = BufReader::new(file);

    for line in reader.lines() {
        let line = line.unwrap();

        lines.push(line)
    }

    lines
}