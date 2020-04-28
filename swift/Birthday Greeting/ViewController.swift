//
//  ViewController.swift
//  Birthday Greeting
//
//  Created by Max on 27/04/2020.
//  Copyright © 2020 artisandeveloppeur. All rights reserved.
//

import Foundation
import UIKit


class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    main()
  }

  func main() {
    let fileName = "employees"
    let fileType = "txt"
    guard let path = Bundle.main.path(forResource: fileName, ofType: fileType) else {
      print("Unable to open file \(fileName).\(fileType)")
      return
    }
    print("Reading file...")
    var firstLine = true

    do {
      let data = try String(contentsOfFile: path, encoding: .utf8)
      let myStrings = data.components(separatedBy: .newlines)

      for string in myStrings {
        if firstLine {
          firstLine = false
        } else {
          var tokens = string.split(separator: ",").map { $0.trimmingCharacters(in: CharacterSet.whitespaces) }
          tokens.enumerated().forEach { (index, content) in
            if content.isEmpty { tokens.remove(at: index) }
          }

          if tokens.count == 4 {
            let date = tokens[2].split(separator: "/").map { $0.trimmingCharacters(in: CharacterSet.whitespaces) }
            if date.count == 3 {
              let currentDay = Date()
              let day = Calendar.current.component(.day, from: currentDay)
              let month = Calendar.current.component(.month, from: currentDay)
              if day == Int(date[0]) && month == Int(date[1]) {
                sendEmail(to: tokens[3], title: "Joyeux Anniversaire !", body: "Bonjour \(tokens[0]),\nJoyeux Anniversaire !\nA bientôt,")
              }
            } else {
              print("Cannot read birthdate for \(tokens[0]) \(tokens[1])")
            }
          } else {
            print("Invalid file format")
          }
        }
      }
      print("Batch job done.")
    } catch {
      print("Error reading file \(fileName).\(fileType)")
    }
  }

  func sendEmail(to: String, title: String, body: String) {
    print("Sending email to: \(to)")
    print("Title: \(title)\n")
    print("Body: \(body)\n")
    print("-------------------------")
  }
}
