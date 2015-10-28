/*
 * Example of a "callout" method that is invoked by a trigger to make
 * an asynchronous web services request.
 * 
 * Example code per Salesforce trailhead tutorial.
 * URL: https://developer.salesforce.com/trailhead/apex_triggers/apex_triggers_intro
 * 
 */
public class CalloutClass {
    
    @future(callout=true)
    public static void makeCallout() {
        HttpRequest request = new HttpRequest();
        
        // Set the endpoint URL.
        String endpoint = 'http://yourHost/yourService';
        request.setEndPoint(endpoint);
        
        // Set the HTTP verb to GET.
        request.setMethod('GET');
        
        // Send the HTTP request and get the response.
        HttpResponse response = new HTTP().send(request);
    }
}