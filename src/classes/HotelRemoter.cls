/*
 * Creates an Apex class that can be called from JavaScript code contained
 * within a custom Visualforce page, per Salesforce Developer Workshop.
 * 
 * URL: http://ccoenraets.github.io/salesforce-developer-workshop/Using-JavaScript-in-Visualforce-Pages.html
 * 
 */
global with sharing class HotelRemoter {
    
    @RemoteAction
    global static List<Hotel__c> findAll() {
        return [SELECT Id, Name, Location__Latitude__s, Location__Longitude__s
                        FROM Hotel__c];
        
    }

}