/*
 * Test class for trigger 'RejectDoubleBooking.apxt' per Salesforce Developer Workshop.
 * 
 * URL: http://ccoenraets.github.io/salesforce-developer-workshop/Testing.html
 * 
 */
@isTest
private class RejectDoubleBookingTest {
    
    static testmethod void testSingleBooking() {
        Datetime now = System.now();

        Speaker__c speaker = new Speaker__c(First_Name__c='John', Last_Name__c='Smith');
        insert speaker;
    
        Session__c session = new Session__c(Name='Some Session', Session_Date__c=now);
        insert session;
    
        Session_Speaker__c assignment =
            new Session_Speaker__c(Session__c=session.Id, Speaker__c=speaker.Id);
        Test.startTest();
        Database.SaveResult result = Database.insert(assignment, false);
        Test.stopTest();
    
        System.assert(result.isSuccess());
    }
    
    static testmethod void testDoubleBooking() {
//      Datetime now = System.now();
        Datetime now = Datetime.newInstance(2015, 10, 15);
    
        Speaker__c speaker = new Speaker__c(First_Name__c='John', Last_Name__c='Smith');
        insert speaker;
    
        Session__c session1 = new Session__c(Name='Session 1', Session_Date__c=now);
        insert session1;
        Session__c session2 = new Session__c(Name='Session 2', Session_Date__c=now);
        insert session2;
    
        Session_Speaker__c assignment1 =
            new Session_Speaker__c(Session__c=session1.Id, Speaker__c=speaker.Id);
        insert assignment1;
    
        Session_Speaker__c assignment2 =
            new Session_Speaker__c(Session__c=session2.Id, Speaker__c=speaker.Id);
        Test.startTest();
        Database.SaveResult result = Database.insert(assignment2, false);
        Test.stopTest();
    
        System.assert(!result.isSuccess());
    }    

}