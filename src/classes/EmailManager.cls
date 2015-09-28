/*
 * Apex class example per Salesforce Developer Workshop.
 * 
 * URL: http://ccoenraets.github.io/salesforce-developer-workshop/Creating-an-Apex-Class.html
 * 
 */
public class EmailManager {
    
    public static void sendMail(String address, String subject, String body) {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        Messaging.SingleEmailMessage [] emailMessages = new Messaging.SingleEmailMessage[] {mail};
        String [] toAddresses = new String [] {address};

		mail.setToAddresses(toAddresses);
        mail.setSubject(subject);
        mail.setPlainTextBody(body);
        Messaging.sendEmail(emailMessages);
    }

}