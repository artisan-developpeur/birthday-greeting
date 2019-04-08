const fs = require("fs");

class App {
  static main() {
    let fileName = "../employees.txt";

    try {
      if (fs.existsSync(fileName)) {
        const byteStream = fs.readFileSync(fileName);
        let content = byteStream.toString().split("\n");

        console.log("Reading file...");
        let first_line = true;
        for (let line of content) {
          if (first_line) {
            first_line = false;
          } else {
            let tokens = line.split(",");
            for (let i = 0; i < tokens.length; i++) {
              tokens[i] = tokens[i].trim();
            }

            if (tokens.length == 4) {
              const date = tokens[2].split("/");
              if (date.length == 3) {
                let now = new Date();
                if (now.getDate() == Number.parseInt(date[0]) && now.getMonth() == Number.parseInt(date[1]) - 1) {
                  App.sendEmail(
                    tokens[3],
                    "Joyeux Anniversaire !",
                    "Bonjour " + tokens[0] + ",\nJoyeux Anniversaire !\nA bientôt,"
                  );
                }
              } else {
                throw new Error("Cannot read birthdate for " + tokens[0] + " " + tokens[1]);
              }
            } else {
              throw new Error("Invalid file format");
            }
          }
        }
        console.log("Batch job done.");
      } else {
        throw new Error("Unable to open file '" + fileName + "'");
      }
    } catch (error) {
      console.error("Error reading file '" + fileName + "'");
      throw error;
    }
  }

  static sendEmail(to, title, body) {
    console.log("Sending email to : " + to);
    console.log("Title: " + title);
    console.log("Body: Body\n" + body);
    console.log("-------------------------");
  }
}

App.main();
