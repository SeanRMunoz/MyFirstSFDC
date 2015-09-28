/*
 * Example of a unit test class for a custom controller in Salesforce.
 * 
 * REFERENCES:
 * 		Video course: Developing with Visualforce with Sara Morgan
 * 		Section: Writing and running basic unit tests
 * 		URL: http://www.lynda.com/Visualforce-tutorials/Writing-running-basic-unit-tests/172850/197260-4.html
 */
@IsTest
private class SidebarSummaryControllerTest {
    static testMethod void SideTest() {
        
        // CREATE test data
        Account acc = new Account(Name='My Account');
        insert acc;
        Opportunity opp1 = new Opportunity(AccountId=acc.Id, Name='1st Test Opportunity', StageName='Prospecting', CloseDate=Date.today() );
        insert opp1;
        Opportunity opp2 = new Opportunity(AccountId=acc.Id, Name='2nd Test Opportunity', StageName='Prospecting', CloseDate=Date.today() );
        insert opp2;
        Opportunity opp3 = new Opportunity(AccountId=acc.Id, Name='3rd Test Opportunity', StageName='Qualification', CloseDate=Date.today() );
        insert opp3;
        
        SidebarSummaryController ctrl = new SidebarSummaryController();

		// START test case
        Test.startTest();
		Map<String, Integer> testStages = ctrl.oppStages;
        Test.stopTest();
        
        // Test ASSERTIONS
        System.assertNotEquals(null, testStages);
        System.assertEquals(testStages.size(), 2);
    }
}