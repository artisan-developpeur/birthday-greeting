package fr.artisandeveloppeur;

public class EmailRouter {
    public void sendEmail(String to, String title, String body) {
        System.out.println("Sending email to : " + to);
        System.out.println("Title: " + title);
        System.out.println("Body: Body\n" + body);
        System.out.println("-------------------------");
    }
}
