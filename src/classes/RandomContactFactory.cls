/*
 * Example code per Salesforce trailhead tutorial.
 * 
 * URL: https://developer.salesforce.com/trailhead/apex_testing/apex_testing_data
 * 
 */
public class RandomContactFactory {

    public static List<Contact> generateRandomContacts(Integer numContacts, String lastName ){
        
        List<Contact> contacts = new List<Contact>();
        for(Integer i=1; i<=numContacts; i++) {
            String firstName = 'Test' + i;
            contacts.add(new Contact(LastName=lastName, FirstName=firstName));
        }
        return contacts;
    }

}