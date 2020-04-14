#include <exception>
#include <fstream>
#include <iostream>
#include <sstream>
#include <string>
#include <vector>

#include <boost/algorithm/string/classification.hpp>
#include <boost/algorithm/string/split.hpp>
#include <boost/date_time/gregorian/gregorian.hpp>

class App {
public:
  static void run() {
    std::string fileName = "../employees.txt";

    try {
      std::fstream file(fileName);

      if (not file.is_open())
        throw std::runtime_error("Unable to open file " + fileName);

      std::cout << "Reading file ..." << std::endl;
      bool first_line = true;
      for (std::string line; std::getline(file, line);) {
        if (first_line)
          first_line = false;
        else {
          std::cout << "Processing line " << line << std::endl;
          std::vector<std::string> tokens;
          boost::algorithm::split(tokens, line, boost::is_any_of(", "),
                                  boost::algorithm::token_compress_on);

          if (tokens.size() == 4) {
            std::vector<std::string> date;
            boost::algorithm::split(date, tokens[2], boost::is_any_of("/"));

            if (date.size() == 3) {
              boost::gregorian::date birthday{
                  static_cast<unsigned short>(std::stoul(date[2])),
                  static_cast<unsigned short>(std::stoul(date[1])),
                  static_cast<unsigned short>(std::stoul(date[0]))};
              auto today = boost::gregorian::day_clock::local_day();

              if (birthday == today)
                sendEmail(tokens[3], "Joyeux Anniversaire !",
                          "Bonjour " + tokens[0] +
                              ",\nJoyeux Anniversaire !\nA bientôt,");

            } else {
              throw std::invalid_argument("Cannot read birthdate for " +
                                          tokens[0] + " " + tokens[1]);
            }
          } else {
            throw std::invalid_argument("Invalid file format");
          }
        }
      }
      file.close();
      std::cout << "Batch job done." << std::endl;
    } catch (const std::exception &e) {
      std::cerr << e.what() << '\n';
    }
  }

  static void sendEmail(const std::string &to, const std::string &title,
                        const std::string &body) {
    std::cout << "Sending email to : " << to << std::endl;
    std::cout << "Title : " << title << std::endl;
    std::cout << "Body : \n" << body << std::endl;
  }
};

int main() { App{}.run(); }