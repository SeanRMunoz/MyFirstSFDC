@isTest
public class RandomContactFactoryTest {

	@isTest static void testCreateTenContacts() {
        
        String lastName  = 'Jones';
        Integer contactsToCreate = 10;
            
        List<Contact> contactList = RandomContactFactory.generateRandomContacts(contactsToCreate, lastName);
        System.assertEquals(contactsToCreate, contactList.size());
        Integer countContacts = 0;
        for(Contact c : contactList) {
            ++countContacts;
	        System.assert(c.FirstName.endsWith('' + countContacts) );
        	System.assertEquals(c.LastName, lastName);
        }
    }        
    
}