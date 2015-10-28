/*
 * Example of bulk trigger update per Salesforce trailhead tutorial.
 * 
 * URL: https://developer.salesforce.com/trailhead/apex_triggers/apex_triggers_bulk
 */
trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
    
    List<Task> taskList = new List<Task>();
    
    for (Opportunity o : [SELECT Id,Name FROM Opportunity
                     WHERE Id IN :Trigger.New AND
                     StageName = 'Closed Won']) {
                         
		taskList.add(new Task(Subject='Follow Up Test Task', WhatId=o.Id));
	}
	// If adding one or more records
    if (taskList.size() > 0) {
        // Do a bulk insert
        insert taskList;
    }

}