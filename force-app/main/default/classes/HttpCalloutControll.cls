public with sharing class HttpCalloutControll {
    
    @AuraEnabled
    public static Map<String, Object> getCalloutResponseContent(String url){
        Integer timeout = 10000;  
        String method = 'GET';
        
        Map<String, Object> mapStringObject = new Map<String, Object>();
        HttpResponse response = new HttpResponse();
        HttpRequest request = new HttpRequest();
        Http h = new Http();
        
        request.setMethod(method);
        request.setEndpoint(url);
        request.setTimeout(timeout);

        response = h.send(request);
        System.debug('response: ' + response.getBody());

        if(response.getStatusCode() >= 200 && response.getStatusCode() < 300){
            mapStringObject = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        }
        else{
            mapStringObject.put('Fail', NULL);
        }

        return mapStringObject;
    }
}