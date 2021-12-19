use std::{
    collections::{HashMap, HashSet},
    io::BufRead,
};

use crate::utils::get_input_lines;
pub fn day_12_1() -> usize {
    // let lines = F

    let lines = get_input_lines("inputs/day-12.txt");
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
        used_double: bool,
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
                if used_double {
                    continue;
                } else {
                    count += paths_rec(neighbor.to_string(), visited.clone(), graph, true);
                    continue;
                }
            }

            let mut new_visited = visited.clone();
            new_visited.insert(neighbor.to_string());

            count += paths_rec(neighbor.to_string(), new_visited, graph, used_double)
        }

        count
    }

    paths_rec("start".to_string(), HashSet::new(), &graph, false)
}
