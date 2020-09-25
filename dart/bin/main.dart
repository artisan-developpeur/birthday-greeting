import 'dart:io';

void main(List<String> args) {
  const fileName = "./employees.txt";

  try {
    final file = File(fileName);
    var lines = file.readAsLinesSync();

    print("Reading file...");
    var firstLine = true;

    for (var line in lines) {
      try {
        if (firstLine) {
          firstLine = false;
        } else {
          var tokens = line.split(",");
          for (var i=0; i < tokens.length ; i++) {
            tokens[i] = tokens[i].trim();
          }
        
          if (tokens.length == 4) {
            var date = tokens[2].split("/");

            if (date.length == 3) {
              var now = DateTime.now();
              if (now.day == int.parse(date[0]) && now.month == int.parse(date[1])) {
                sendEmail(tokens[3],"Joyeux Anniversaire !", "Bonjour " + tokens[0] + ",\nJoyeux Anniversaire !\nA bientôt,");
              }
            } else {
              throw Exception(
                  "Cannot read birthdate for " + tokens[0] + " " + tokens[1]);
            }
          } else {
            throw Exception("Invalid file format");
          }
        }
      } catch (e, stackTrace) {
        print(e);
        print(stackTrace.toString());
      }
    }
  } catch (e) {
    print(e);
    print("Unable to read file " + fileName);
  }
}

void sendEmail(String to, String title, String body) {
  print("------------------------");
  print("Sending email to : " + to);
  print("Title : " + title);
  print("Body : " + body);
  print("------------------------");
}
