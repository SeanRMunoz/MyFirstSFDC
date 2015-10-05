@isTest
private class CampsiteDoubleBookingTest {

    @isTest static void testInsertSuccess() {
        // Date range for reservation
        Date begDate1 = Date.newInstance(2015, 10, 15);
        Date endDate1 = Date.newInstance(2015, 10, 25);

		// CREATE two different campsites
        Campsite__c campsite1 = new Campsite__c(
            	Name='Campsite-1', Description__c='Test data', Rate__c=15 );
        insert campsite1;
        Campsite__c campsite2 = new Campsite__c(
            	Name='Campsite-2', Description__c='Test data', Rate__c=20 );
        insert campsite2;

        // CREATE two reservations on same date; one at each campsite (allowed)
		Campsite_Reservation__c res1 = new Campsite_Reservation__c(
        		Campsite__c=campsite1.Id, Start_Date__c=begDate1, End_Date__c=endDate1, User__c=campsite1.CreatedById);
        insert res1;
		Campsite_Reservation__c res2 = new Campsite_Reservation__c(
        		Campsite__c=campsite2.Id, Start_Date__c=begDate1, End_Date__c=endDate1, User__c=campsite1.CreatedById);
        
        Test.startTest();
        Database.SaveResult result = Database.insert(res2, false);
        Test.stopTest();
    
        System.assert(result.isSuccess(), 
                      'Allow INSERT with identical dates but at different campsite.');
    }

    @isTest static void testInsertFailure() {
        // Date range for reservation
        Date begDate1 = Date.newInstance(2015, 10, 15);
        Date endDate1 = Date.newInstance(2015, 10, 25);
		// Date range that overlaps 1st
        Date begDate2 = Date.newInstance(2015, 10, 20);
        Date endDate2 = Date.newInstance(2015, 10, 28);

		// CREATE campsite
        Campsite__c campsite1 = new Campsite__c(
            	Name='Campsite-1', Description__c='Test data', Rate__c=15 );
        insert campsite1;

        // CREATE two reservations with overlapping dates (disallowed)
		Campsite_Reservation__c res1 = new Campsite_Reservation__c(
        		Campsite__c=campsite1.Id, Start_Date__c=begDate1, End_Date__c=endDate1, User__c=campsite1.CreatedById);
        insert res1;
		Campsite_Reservation__c res2 = new Campsite_Reservation__c(
        		Campsite__c=campsite1.Id, Start_Date__c=begDate2, End_Date__c=endDate2, User__c=campsite1.CreatedById);
        
        Test.startTest();
        Database.SaveResult result = Database.insert(res2, false);
        Test.stopTest();
        
    	System.assert(!result.isSuccess(), 
                      'Prevent INSERT with overlapping dates.');
    }    

    @isTest static void testUpdateSuccess() {
        // Date range for reservation
        Date begDate1 = Date.newInstance(2015, 10, 15);
        Date endDate1 = Date.newInstance(2015, 10, 25);
        // Date range that overlaps 1st
        Date begDate2 = Date.newInstance(2015, 10, 16);
        Date endDate2 = Date.newInstance(2015, 10, 20);

		// CREATE campsite
        Campsite__c campsite1 = new Campsite__c(
            	Name='Campsite-1', Description__c='Test data', Rate__c=15 );
        insert campsite1;

        // CREATE reservation 
		Campsite_Reservation__c res1 = new Campsite_Reservation__c(
        		Campsite__c=campsite1.Id, Start_Date__c=begDate1, End_Date__c=endDate1, User__c=campsite1.CreatedById);
        insert res1;

		// UPDATE reservation dates to overlap self (allowed)
        res1.Start_Date__c = begDate2;
        res1.End_Date__c = endDate2;

        Test.startTest();
        Database.SaveResult result = Database.update(res1, false);
        Test.stopTest();

    	System.assert(result.isSuccess(), 
                      'Allow UPDATE with dates overlapping self.');
    }    
    
    @isTest static void testUpdateFailure() {
        // Date ranges for reservations (non-overlapping)
        Date begDate1 = Date.newInstance(2015, 10, 01);
        Date endDate1 = Date.newInstance(2015, 10, 20);
        Date begDate2 = Date.newInstance(2015, 10, 21);
        Date endDate2 = Date.newInstance(2015, 10, 30);
        // Date range that overlaps 2nd range
        Date begDate3 = Date.newInstance(2015, 10, 15);
        Date endDate3 = Date.newInstance(2015, 10, 25);

		// CREATE campsite
        Campsite__c campsite1 = new Campsite__c(
            	Name='Campsite-1', Description__c='Test data', Rate__c=15 );
        insert campsite1;

        // CREATE two reservations
		Campsite_Reservation__c res1 = new Campsite_Reservation__c(
        		Campsite__c=campsite1.Id, Start_Date__c=begDate1, End_Date__c=endDate1, User__c=campsite1.CreatedById);
        insert res1;
		Campsite_Reservation__c res2 = new Campsite_Reservation__c(
        		Campsite__c=campsite1.Id, Start_Date__c=begDate2, End_Date__c=endDate2, User__c=campsite1.CreatedById);
        insert res2;

		// UPDATE 1st reservation dates to overlap 2nd (disallowed)
        res1.Start_Date__c = begDate3;
        res1.End_Date__c = endDate3;

        Test.startTest();
        Database.SaveResult result = Database.update(res1, false);
        Test.stopTest();

    	System.assert(!result.isSuccess(), 
                      'Prevent UPDATE with dates overlapping another.');
    }    
}