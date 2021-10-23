const fs = require("fs");

class App {
  static main() {
    let fileName = "../employees.txt";

    try {
      if (fs.existsSync(fileName)) {
        const b = fs.readFileSync(fileName);
        let content = b.toString().split("\n");

        console.log("Reading file...");
        let fl = true;
        for (let l of content) {
          try {
            if (fl) {
              fl = false;
            } else {
              let t = l.split(",");
              for (let i = 0; i < t.length; i++) {
                t[i] = t[i].trim();
              }

              if (t.length == 4) {
                const d = t[2].split("/");
                if (d.length == 3) {
                  let n = new Date();
                  if (n.getDate() == Number.parseInt(d[0]) && n.getMonth() == Number.parseInt(d[1]) - 1) {
                    App.sendEmail(
                      t[3],
                      "Joyeux Anniversaire !",
                      "Bonjour " + t[0] + ",\nJoyeux Anniversaire !\nA bientôt,"
                    );
                  }
                } else {
                  throw new Error("Cannot read birthdate for " + t[0] + " " + t[1]);
                }
              } else {
                throw new Error("Invalid file format");
              }
            }
          } catch (e) {
            console.log(e);
            console.error("Error reading file '" + fileName + "'");
          }
        }
        console.log("Batch job done.");
      } else {
        throw new Error("Unable to open file '" + fileName + "'");
      }
    } catch (error) {
      console.error("Error reading file '" + fileName + "'");
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
