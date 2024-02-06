global without sharing class StudentSoapService {
    
    webservice static Student__c getStudentRecord(String studentId){
        Student__c student = [SELECT Id, Student_Name__c, Phone_Number__c, School__c, Email__c
                    FROM Student__c
                    WHERE  Id = :studentId];

        return student;
    }
}