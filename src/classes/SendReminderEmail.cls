/*
 * Example class that implements 'Batchable' interface per Salesforce Developer Workshop.
 * 
 * URL: http://ccoenraets.github.io/salesforce-developer-workshop/Batch-and-Schedule.html
 * 
 * EXECUTION CODE:
		String q = 'SELECT First_Name__c, Last_Name__c, Email__c FROM Speaker__c WHERE Email__c LIKE \'sean%\' or Email__c LIKE \'srm%\'';
		SendReminderEmail batch = new SendReminderEmail(q, 'Salesforce Final Reminder', 'The conference starts next Monday');
		Database.executeBatch(batch);
 * 
 */
global class SendReminderEmail implements Database.Batchable<sObject> {

    global String query;
    global String subject;
    global String body;
    
    // Constructor
    global SendReminderEmail (String query, String subject, String body) {
		this.query = query;
        this.subject = subject;
        this.body = body;
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<Speaker__c> scope) {
        for (Speaker__c speaker : scope) {
            EmailManager.sendMail(speaker.Email__c, this.subject, this.body);
        }
    }
    
    global void finish(Database.BatchableContext bc) {
        
    }

}