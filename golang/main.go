package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
	"time"
)

const (
	fileName = "../employees.txt"
)

func main() {
	fmt.Println("Reading file...")
	firstLine := true

	file, err := os.Open(fileName)
	if err != nil {
		panic(err)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)

	for scanner.Scan() {
		line := scanner.Text()
		if firstLine {
			firstLine = false
		} else {
			tokens := strings.Split(line, ",")
			for i := range tokens {
				tokens[i] = strings.Trim(tokens[i], " ")
			}

			if len(tokens) == 4 {
				date := strings.Split(tokens[2], "/")
				day, err := strconv.ParseInt(date[0], 10, 32)
				if err != nil {
					panic(err)
				}
				month, err := strconv.ParseInt(date[1], 10, 32)
				if err != nil {
					panic(err)
				}

				if len(date) == 3 {
					now := time.Now()
					if int64(now.Day()) == day && int64(now.Month()) == month {
						sendEmail(tokens[3], "Joyeux Anniversaire !", "Bonjour "+tokens[0]+",\nJoyeux Anniversaire !\nA bientôt,")
					}
				} else {
					panic("Cannot read birthdate for " + tokens[0] + " " + tokens[1])
				}
			} else {
				panic("Invalid file format")
			}
		}
	}

}

func sendEmail(to, title, body string) {
	fmt.Println("------------------------")
	fmt.Println("Sending email to : " + to)
	fmt.Println("Title : " + title)
	fmt.Println("Body : " + body)
	fmt.Println("------------------------")
}
