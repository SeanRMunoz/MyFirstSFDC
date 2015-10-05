@isTest
private class CampsiteDoubleBookingTest {

    @isTest static void testDatesSameSiteDiff() {
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
    
        System.assert(result.isSuccess());
        
    }

    @isTest static void testDatesOverlapSiteSame() {
        // Date ranges for reservation
        Date begDate1 = Date.newInstance(2015, 10, 15);
        Date endDate1 = Date.newInstance(2015, 10, 25);
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
    
        System.assert(!result.isSuccess());
    }    
}