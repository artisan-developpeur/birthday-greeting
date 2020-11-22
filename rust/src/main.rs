use chrono::prelude::*;
use std::{
    fs::File,
    io::{BufRead, BufReader},
    str::FromStr,
};

trait BirthdayGreeting {
    fn run(&self, file_name: String);
    fn send_email(&self, to: String, title: String, body: String);
}

struct App();

impl BirthdayGreeting for App {
    fn run(&self, file_name: String) {
        let file = File::open(file_name).unwrap();
        let reader = BufReader::new(file);
        let mut first_line = true;
        println!("Reading file ...");
        for (index, line) in reader.lines().enumerate() {
            if first_line {
                first_line = false;
            } else {
                let line_str = line.unwrap();
                let mut tokens = Vec::new();
                for token in line_str.split(',') {
                    tokens.push(token.trim());
                }
                if tokens.len() == 4 {
                    let date: Vec<&str> = tokens[2].split('/').collect();
                    if date.len() == 3 {
                        let today = Utc::now().date();
                        if today.day() == u32::from_str(date[0]).unwrap_or(0)
                            && today.month() == u32::from_str(date[1]).unwrap_or(0)
                        {
                            self.send_email(
                                tokens[3].to_string(),
                                String::from("Joyeux Anniversaire !"),
                                format!(
                                    "Bonjour {},\nJoyeux Anniversaire !\nA bientôt,",
                                    tokens[0]
                                ),
                            );
                        }
                    } else {
                        eprintln!("Cannot read birthdate for {} {}", tokens[0], tokens[1]);
                    }
                } else {
                    eprintln!("Invalid file format at line {}", index);
                }
            }
        }
    }

    fn send_email(&self, to: String, title: String, body: String) {
        println!("Sending email to : {}", to);
        println!("Title: {}", title);
        println!("Body: {}", body);
        println!("-------------------------");
    }
}

fn main() {
    App {}.run(String::from("../employees.txt"));
}
