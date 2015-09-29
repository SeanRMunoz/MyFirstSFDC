# MyFirstSFDC
First experience developing on the Salesforce platform through creating custom **Visualforce** pages and writing **Apex** code for classes, triggers and custom controllers, including associated unit tests.   

## Technologies used:
- Salesforce Developer Edition Account
- Visualforce [Pages](src/pages/)
- Apex: [Classes](src/classes/), [Triggers](src/triggers), Custom [Controllers](src/classes/SidebarSummaryController.cls) & Controller [Extensions](src/classes/SpeakerControllerExtension.cls)
- Unit Tests (see classes: [SidebarSummaryControllerTest](src/classes/SidebarSummaryControllerTest.cls) & [TestRejectDoubleBooking](src/classes/TestRejectDoubleBooking.cls))
- Custom Objects & Fields
- Field Sets & dynamic titles (see page: [ContactEdit](src/pages/ContactEdit.page))
- Batch Processing (see class: [SendReminderEmail](src/classes/SendReminderEmail.cls))
- Static Resources (see page: [SidebarSummary](src/pages/SidebarSummary.page))
- SOQL and DML

## References:

This project is based upon code found at:

- [*Video Course - Developing with Visualforce*](http://www.lynda.com/sdk/Visualforce-tutorials/Developing-Visualforce/172850-2.html)
- [*Salesforce Developer Workshop - Fast Track to Salesforce Development*](http://ccoenraets.github.io/salesforce-developer-workshop/index.html)

