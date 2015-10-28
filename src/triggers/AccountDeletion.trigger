/*
 * Example code per Salesforce trailhead tutorial.
 * 
 * URL: https://developer.salesforce.com/trailhead/apex_testing/apex_testing_triggers
 * 
 */
trigger AccountDeletion on Account (before delete) {
   
    // Prevent the deletion of accounts if they have related contacts.
    for (Account a : [SELECT Id FROM Account
                     WHERE Id IN (SELECT AccountId FROM Opportunity) AND
                     Id IN :Trigger.old]) {
        Trigger.oldMap.get(a.Id).addError(
            'Cannot delete account with related opportunities.');
    }
    
}