//Adding 2 DML statements here so Guest user can submit these 2 DMLs
//Without this, Guest user will not be able to submit these records becasue of new Guest user security
//
public without sharing class  ViewSurveyControllerWithoutSharing {
    //this method is ONLY to do DML in without sharing mode
    //Make sure to try/catch any errors in the calling method
    public static void createSurveyTaken(SurveyTaker__c st){
        insert st;
    }
    //this method is ONLY to do DML in without sharing mode
    //Make sure to try/catch any errors in the calling method
    public static void createSurveyQuestionResponse(List <SurveyQuestionResponse__c> sqrList, Map<String,Blob> uploadFilesMap){
        insert sqrList;

        // Add files to Survey question response
        for (SurveyQuestionResponse__c sqr : sqrList) {
            System.debug(sqr.Question_Type__c);
            if(sqr.isFile__c){
                Attachment myAttachment  = new Attachment();  
                myAttachment.Body = uploadFilesMap.get(sqr.Response__c);  
                myAttachment.Name = sqr.Response__c;  
                myAttachment.ParentId = sqr.Id;  
                insert myAttachment;  
            }
        }
    }
}