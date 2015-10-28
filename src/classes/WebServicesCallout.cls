public class WebServicesCallout {
	
    /*
     * Test execution code:
        List<String> acctIds = new List<String>();
        acctIds.add('00161000004tbHN');
        acctIds.add('00161000004tbHM');
        WebServicesCallout.verifyAccountShippingAddress(acctIds);
     *
     */
    @future(callout=true)
    public static void verifyAccountShippingAddress(List<String> accountIds) {
        if( accountIds == null || (accountIds != null && accountIds.size() <= 0) ) {
			System.debug('NO ACTION taken due to null or empty list: accountIds.');
            return;
        }
        final String ADDRESS_NOT_FOUND =  '[ Address NOT found! ]';
        List <SmartyStreetsAddressReqJSON> addressReqList = new List<SmartyStreetsAddressReqJSON>();
        for( Account a : [SELECT Name, Id, ShippingStreet, ShippingCity, ShippingState, ShippingPostalCode FROM Account WHERE Id in :accountIds] ) {
			System.debug('Account name: ' 			+ a.Name);
			System.debug('  ShippingStreet: ' 		+ a.ShippingStreet);
			System.debug('  ShippingCity: ' 		+ a.ShippingCity);
			System.debug('  ShippingState: ' 		+ a.ShippingState);
			System.debug('  ShippingPostalCode: ' 	+ a.ShippingPostalCode);
            SmartyStreetsAddressReqJSON AddrReq = new SmartyStreetsAddressReqJSON();
            addrReq.input_id 	= a.Id;
            addrReq.street 		= a.ShippingStreet;
            addrReq.city		= a.ShippingCity;
            AddrReq.state		= a.ShippingState;
            AddrReq.zip			= a.ShippingPostalCode;

            // Must have non-blank values for one of the following field combinations:
            //	: street + city + state
            //	: street + zipcode
            if( (String.isNotBlank( AddrReq.street ) &&
               	 String.isNotBlank( AddrReq.city )	 &&
               	 String.isNotBlank( AddrReq.state ))
               ||
               	(String.isNotBlank( AddrReq.street ) &&
                 String.isNotBlank( AddrReq.zip )) 
              ) {
				                     
	            // FIXME: Must limit request to 200 max, per API spec
	            addressReqList.add(AddrReq);
			}
                
        }
        
        if( addressReqList.size() <= 0 ) {
			System.debug('NO ACTION taken due to NO valid address field combinations.');
            return;
        }
        
        String jsonAddressRequest = System.JSON.serialize(addressReqList);
        System.debug('JSON Addr Req: ' + jsonAddressRequest );

		// Put your authentication ID/token here (don't forget you need the encoded form)
		String authId = 'c1c371f0-0ad5-10c2-8182-ae509cd820a7';
		String authToken = 'UP2yodfi79eopEFhjEo3';

		// The REST endpoint
		String url = 'https://api.smartystreets.com/street-address/?auth-id=' + authId + '&auth-token=' + authToken;
        
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http http = new Http();

        req.setEndpoint(url);
        req.setMethod('POST');
        req.setBody(jsonAddressRequest);

        try {
            res = http.send(req);
        } catch(System.CalloutException e) {
            System.debug('Callout error: '+ e);
            System.debug(res.toString());
        }
	
        System.debug('HTTP Response body: ' + res.getBody());
		List<SmartyStreetsAddressResJSON> verifiedAddresses = 
            (List<SmartyStreetsAddressResJSON>)System.JSON.deserialize(res.getBody(), List<SmartyStreetsAddressResJSON>.class);
        
        List<Account> accountUpdateList = new List<Account>();
        
        // For each address verification request
        for( SmartyStreetsAddressReqJSON addressReq : addressReqList ) {
            String verifiedShippingAddress = ADDRESS_NOT_FOUND;
            
	        for( SmartyStreetsAddressResJSON verifiedAddress : verifiedAddresses ) {
                // Found matching address
                if( addressReq.input_id.equals(verifiedAddress.input_id) ) {
                    verifiedShippingAddress = verifiedAddress.delivery_line_1 + 
                        '\n' + verifiedAddress.last_line;
                    System.debug('  delivery_line_1: ' 	+ verifiedAddress.delivery_line_1 );
                    System.debug('  last_line: ' 		+ verifiedAddress.last_line );
                    if( verifiedAddress.components != null ) {
	                    System.debug('  Zip code: ' 	+ verifiedAddress.components.zipcode );
                    }
                    if( verifiedAddress.metadata != null ) {
                        System.debug('  latitude: ' 	+ verifiedAddress.metadata.latitude );
                        System.debug('  longitude: ' 	+ verifiedAddress.metadata.longitude );
                        System.debug('  Time zone: ' 	+ verifiedAddress.metadata.time_zone );
                    }
                    System.debug('----------------');
                    break;
                }
            }
            // To prevent endless loop, MUST set Validate_Shipping_Address__c=false
            accountUpdateList.add( new Account(
                Id=addressReq.input_id, 
                Validate_Shipping_Address__c = false,
                Verified_ShippingAddress__c = verifiedShippingAddress ));
        }
        
		System.debug('Record UPDATE count: ' +  accountUpdateList.size() );
        
        if( accountUpdateList.size() > 0 ) {
            update accountUpdateList;
        }
    }
    
}