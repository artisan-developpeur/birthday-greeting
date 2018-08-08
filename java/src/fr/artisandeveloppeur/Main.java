package fr.artisandeveloppeur;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.Calendar;

public class Main {

    public static void main(String[] args) {
        String fileName = "../employees.txt";
        try {
            FileReader fileReader =  new FileReader(fileName);
            BufferedReader bufferedReader = new BufferedReader(fileReader);

            System.out.println("Reading file...");
            String line;
            Boolean first_line = true;
            while((line = bufferedReader.readLine()) != null) {
              try {
                    if (first_line) {
                        first_line = false;
                    } else {
                        String[] tokens = line.split(",");
                        for (int i = 0; i < tokens.length; i++)
                            tokens[i] = tokens[i].trim();

                        if (tokens.length == 4 ) {
                            String[] date = tokens[2].split("/");
                            if (date.length == 3) {
                                Calendar cal = Calendar.getInstance();
                                if (cal.get(Calendar.DATE) == Integer.parseInt(date[0]) && cal.get(Calendar.MONTH) == (Integer.parseInt(date[1])-1)) {
                                    Main.sendEmail(tokens[3], "Joyeux Anniversaire !", "Bonjour " + tokens[0] + ",\nJoyeux Anniversaire !\nA bientôt,");
                                }
                            } else {
                                throw new Exception("Cannot read birthdate for " + tokens[0] + " " + tokens[1]);
                            }
                        } else {
                            throw new Exception("Invalid file format");
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            bufferedReader.close();
            System.out.println("Batch job done.");
        }
        catch(FileNotFoundException ex) {
            System.out.println("Unable to open file '" + fileName + "'");
        }
        catch(IOException ex) {
            System.out.println("Error reading file '" + fileName + "'");
        }
    }

    public static void sendEmail(String to, String title, String body) {
        System.out.println("Sending email to : " + to);
        System.out.println("Title: " + title);
        System.out.println("Body: Body\n" + body);
        System.out.println("-------------------------");
    }
}
