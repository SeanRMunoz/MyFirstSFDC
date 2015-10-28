/*
 * Example code per Salesforce trailhead tutorial.
 * 
 * URL: https://developer.salesforce.com/trailhead/apex_triggers/apex_triggers_intro
 * 
 */
trigger AccountAddressTrigger on Account (before insert, before update) {
    
    // Iterate through each account.
    for(Account a : Trigger.New) {
        // Check if checkbox is set.
        if ( a.Match_Billing_Address__c == true && 
             !String.isBlank(a.BillingPostalCode) ) {
            a.ShippingPostalCode = a.BillingPostalCode;
        }           
    }
}