/*
 * Example code per Salesforce trailhead tutorial.
 * 
 * URL: https://developer.salesforce.com/trailhead/apex_testing/apex_testing_triggers
 * 
 */
@isTest
private class TestRestrictContactByName {

    @isTest static void testInsertInvalid() {

		// Create test data        
        Contact contact = new Contact(LastName='INVALIDNAME');

        // Perform test
        Test.startTest();
        Database.SaveResult result = Database.insert(contact, false);
        Test.stopTest();

        // Verify result
		System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('The Last Name "INVALIDNAME" is not allowed for DML',
                             result.getErrors()[0].getMessage());
    }

}