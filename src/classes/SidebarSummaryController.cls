/*
 * Example of creating a custom controller class in Salesforce.
 * 
 * REFERENCES:
 * 		Video course: Developing with Visualforce with Sara Morgan
 * 		Section: Adding Visualforce to the sidebar
 * 		URL: http://www.lynda.com/Visualforce-tutorials/Adding-Visualforce-sidebar/172850/197248-4.html
 */
public with sharing class SidebarSummaryController {

    public Map<String, Integer> oppStages { get; set; }
    
    public SidebarSummaryController() {
        oppStages = new Map<String, Integer>();
        for(AggregateResult ar : [Select StageName, count(ID) cnt FROM Opportunity GROUP BY StageName ORDER BY StageName DESC ] ) {
        
            oppStages.put((String) ar.get('StageName'), (Integer)ar.get('cnt') );
        }
        System.debug('Test debug statement by SRM.');
    }
}