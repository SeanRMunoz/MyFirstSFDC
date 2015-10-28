trigger AccountValidateShippingAddress on Account(after insert, after update) {

	List<String> accountIdList = new List<String>();

    // Build a list of Account Ids for the callout method
    for(Account a : trigger.new) {
        if(a.Validate_Shipping_Address__c == true) {
            accountIdList.add(a.Id);
        }
    }

    if( accountIdList.size() > 0 ) {
        // Invoke the REST API via future/async callout method
	    WebServicesCallout.verifyAccountShippingAddress( accountIdList );
    }
    
}