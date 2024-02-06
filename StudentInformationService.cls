@RestResource(urlMapping='/studentsInfo/*')
global with sharing class StudentInformationService {
    private static final String ERROR_MESSAGE   = 'No record was retrieve from the query';
    private static final String SUCCESS_MESSAGE = 'Record retrieve successfully.';
    @HttpGet
    global static StudentInfo getStudent(){
        StudentInfo stdInfo = new StudentInfo();
        RestRequest request = RestContext.Request;
        String studentId    = request.requestURI.substring(request.requestURI.lastIndexOf('/') + 1);
        List<Student__c> students  = [SELECT Id, Name, Address__c, Student_Name__c, Phone_Number__c, School__r.Name
                                FROM Student__c
                                WHERE Id =: studentId 
                                WITH SECURITY_ENFORCED];

        if(students.size() <= 0){
            stdInfo.infoMessage = ERROR_MESSAGE;
        }
        else{
            stdInfo.studentName     = students[0].Student_Name__c;
            stdInfo.studentAddress  = students[0].Address__c;
            stdInfo.studentPhone    = students[0].Phone_Number__c;
            stdInfo.schoolName      = students[0].School__r.Name;
            stdInfo.infoMessage     = SUCCESS_MESSAGE;
        }
        return stdInfo;
    }

    global class StudentInfo{
        String studentName {get;set;}
        String studentAddress {get;set;}
        String studentPhone {get;set;}
        String schoolName {get;set;}
        String infoMessage {get;set;}
    }
}