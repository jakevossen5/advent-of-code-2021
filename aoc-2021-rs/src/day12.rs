use std::{
    collections::{HashMap, HashSet, VecDeque},
    fmt::format,
    fs::File,
    io::{BufRead, BufReader},
};

use crate::utils::get_input_lines;
pub fn day_12_1() -> usize {
    // let lines = F

    let lines = get_input_lines("inputs/day-12.txt");
    let mut explored: HashSet<String> = HashSet::new();
    let mut queue: VecDeque<String> = VecDeque::new();

    let mut graph: HashMap<String, Vec<String>> = HashMap::new();

    for line in lines {
        let parts: Vec<&str> = line.split("-").collect();

        let from = String::from(parts[0]);
        let to = String::from(parts[1]);

        let v = graph.entry(from.clone()).or_insert(Vec::new());
        v.push(to.clone());

        let v = graph.entry(to).or_insert(Vec::new());
        v.push(from);
    }

    fn paths_rec(
        cur: String,
        visited: HashSet<String>,
        graph: &HashMap<String, Vec<String>>,
    ) -> usize {
        if cur == "end".to_string() {
            return 1;
        }

        let mut count = 0;

        for neighbor in &graph[&cur] {
            if neighbor == "start" {
                continue;
            }
            if neighbor.to_string() == neighbor.to_lowercase() && visited.contains(neighbor) {
                continue;
            }

            let mut new_visited = visited.clone();
            new_visited.insert(neighbor.to_string());

            count += paths_rec(neighbor.to_string(), new_visited, graph)
        }

        count
    }

    paths_rec("start".to_string(), HashSet::new(), &graph)
}

pub fn day_12_2() -> usize {
    // let lines = F

    let lines = get_input_lines("inputs/day-12.txt");
    let mut explored: HashSet<String> = HashSet::new();
    let mut queue: VecDeque<String> = VecDeque::new();

    let mut graph: HashMap<String, Vec<String>> = HashMap::new();

    for line in lines {
        let parts: Vec<&str> = line.split("-").collect();

        let from = String::from(parts[0]);
        let to = String::from(parts[1]);

        let v = graph.entry(from.clone()).or_insert(Vec::new());
        v.push(to.clone());

        let v = graph.entry(to).or_insert(Vec::new());
        v.push(from);
    }

    fn paths_rec(
        cur: String,
        visited: HashSet<String>,
        graph: &HashMap<String, Vec<String>>,
    ) -> usize {
        if cur == "end".to_string() {
            return 1;
        }

        let mut count = 0;

        for neighbor in &graph[&cur] {
            if neighbor == "start" {
                continue;
            }
            if neighbor.to_string() == neighbor.to_lowercase() && visited.contains(neighbor) {
                if visited.iter().any(|x| x.ends_with("_2")) {
                    continue;
                } else {
                    let mut new_visited = visited.clone();
                    let next = format!("{}_2", neighbor);
                    new_visited.insert(next);

                    count += paths_rec(neighbor.to_string(), new_visited, graph);
                    continue;
                }
            }

            let mut new_visited = visited.clone();
            new_visited.insert(neighbor.to_string());

            count += paths_rec(neighbor.to_string(), new_visited, graph)
        }

        count
    }

    paths_rec("start".to_string(), HashSet::new(), &graph)
}
