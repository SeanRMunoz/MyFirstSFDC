/*
 * Standard controller extension example per Salesforce Developer Workshop.
 * 
 * URL: http://ccoenraets.github.io/salesforce-developer-workshop/Creating-a-Controller-Extension.html
 * 
 */
public class SpeakerControllerExtension {
    
    public blob picture { get; set; }
    public String errorMessage { get; set; }
    
    private final Speaker__c speaker;
    private ApexPages.StandardController stdController;

        // Constructor    
    public SpeakerControllerExtension(ApexPages.StandardController stdController) {
        this.speaker = (Speaker__c) stdController.getRecord();
        this.stdController = stdController;
    }
    
    public PageReference save() {
        errorMessage = '';
        PageReference returnPage = null;
        try {
            upsert speaker;
            if (picture != null) {
                Attachment attachment = new Attachment();
                attachment.body = picture;
                attachment.name = 'speaker_' + speaker.id + '.jpg';
                attachment.parentid = speaker.id;
                attachment.ContentType = 'application/jpg';
                insert attachment;
                speaker.Picture_Path__c = '/servlet/servlet.FileDownload?file='
                                          + attachment.id;
                update speaker;
            }
                        returnPage = new ApexPages.StandardController(speaker).view();            
        } catch (System.Exception ex) {
            errorMessage = ex.getMessage();
        }
                return returnPage;
    }

}