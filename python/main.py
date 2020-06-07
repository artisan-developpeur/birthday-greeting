from pathlib import Path
import datetime


class App:
    def run(self):
        filename = "../employees.txt"
        try:
            with Path.open(Path(filename)) as file:
                print('Reading file...')
                first_line = True

                for line in file.readlines():
                    try:
                        if first_line:
                            first_line = False
                        else:
                            tokens = line.split(',')
                            tokens = [token.strip() for token in tokens]
                            if len(tokens) == 4:
                                date = tokens[2].split("/")
                                if len(date) == 3:
                                    today = datetime.date.today()
                                    if today.day == int(date[0]) and today.month == int(date[1]):
                                        send_email(tokens[3],
                                                   "Joyeux Anniversaire !",
                                                   "Bonjour " + tokens[0] + ",\nJoyeux Anniversaire !\nA bientôt,")
                                else:
                                    raise Exception("Cannot read birthdate for " + tokens[0] + " " + tokens[1])
                            else:
                                raise Exception("Invalid file format")

                    except Exception as err:
                        print(err)

        except FileNotFoundError:
            print(f"Unable to open file '{filename}'")


def send_email(to, title, body):
    print(f"Sending email to #{to}")
    print(f"Title: {title}")
    print(f"Body:\n{body}")
    print("--------------")


App().run()
