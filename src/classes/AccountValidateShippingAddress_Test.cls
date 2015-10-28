@IsTest
private class AccountValidateShippingAddress_Test {

    @isTest static void testInsertTwoFullShippingAddress() {
        List<String> acctIds = new List<String>();

		// HTTP calls get routed to mock instead of out to the internet
		Test.setMock(HttpCalloutMock.class, new MockHttp());
        
        Account a1 = new Account(
            Name='Test 1', 
            ShippingStreet		= '910 Second Street, Suite 200',
            ShippingCity		= 'Sacramento',
            ShippingState		= 'CA',
            ShippingPostalCode	= '95814',
            Validate_Shipping_Address__c = true
        );
		
        Account a2 = new Account(
            Name='Test 2', 
            ShippingStreet		= '1500 W El Camino Ave #121',
            ShippingPostalCode	= '95833',
            Validate_Shipping_Address__c = true
        );
		
		Test.startTest();
        insert a1;
        acctIds.add(a1.Id);
        insert a2;
        acctIds.add(a2.Id);
		Test.stopTest();
        
		for( Account a : [SELECT Name, Id, Validate_Shipping_Address__c, ShippingStreet, ShippingCity, ShippingState, ShippingPostalCode FROM Account WHERE Id in :acctIds] ) {
            System.assert(a.Validate_Shipping_Address__c == false, 'Validate checkbox cleared.');
        }
    }
	    
    @isTest static void testInsertNoShippingAddress() {
        List<String> acctIds = new List<String>();

		// HTTP calls get routed to mock instead of out to the internet
		Test.setMock(HttpCalloutMock.class, new MockHttp());
        
        Account a1 = new Account(
            Name='Test 1', 
            Validate_Shipping_Address__c = true
        );
		
		Test.startTest();
        insert a1;
        acctIds.add(a1.Id);
		Test.stopTest();
        
		for( Account a : [SELECT Name, Id, Validate_Shipping_Address__c, ShippingStreet, ShippingCity, ShippingState, ShippingPostalCode FROM Account WHERE Id in :acctIds] ) {
            System.assert(a.Validate_Shipping_Address__c == a1.Validate_Shipping_Address__c, 'Validate checkbox NOT changed.');
        }
    }
	    
	private class MockHttp implements HttpCalloutMock {
		public HTTPResponse respond(HTTPRequest req) {
            HTTPResponse res = new HTTPResponse();
            res.setStatusCode(200);
            if (req.getEndpoint().containsIgnoreCase('api.smartystreets.com')) {
				List<SmartyStreetsAddressResJSON> resAddresses = new List<SmartyStreetsAddressResJSON>();
				List<SmartyStreetsAddressReqJSON> reqAddresses = 
                    (List<SmartyStreetsAddressReqJSON>)JSON.deserialize(req.getBody(), List<SmartyStreetsAddressReqJSON>.class);
                System.assert( reqAddresses != null, 'HTTP body request not null');
                System.assert( reqAddresses.size() > 0, 'HTTP body request >= 1 address.');
                for( SmartyStreetsAddressReqJSON reqAddress : reqAddresses ) {
	                SmartyStreetsAddressResJSON resAddress = new SmartyStreetsAddressResJSON();
					resAddress.input_id = reqAddress.input_id;
                    resAddress.delivery_line_1 = 'TEST-Delivery Line1';
                    resAddress.last_line = 'TEST-Last Line';
                    resAddresses.add(resAddress);
                }
                res.setBody(JSON.serialize(resAddresses));
                
            } else if (req.getEndpoint().endsWith('apirequest')) {
                // Mock the response if necessary
                res.setBody('');
            }
            return res;
        }
    } 
    
}