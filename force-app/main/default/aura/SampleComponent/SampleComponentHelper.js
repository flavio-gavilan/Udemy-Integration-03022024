({
    getResponse : function(component) {
        //console.log('i am inside the helper');
        var action = component.get("c.getCalloutResponseContent");
        var accessKey = ''; //access key from https://fixer.io/dashboard
        action.setParams({
            "url":"http://data.fixer.io/api/latest?access_key=" + accessKey
        });
        action.setCallback(this,function(response){
            var state = response.getState();
            if(component.isValid && state == "SUCCESS"){
                console.log("response.getReturnValue():" + response.getReturnValue());
                component.set("v.response", response.getReturnValue());
                var getAllRates = component.get("v.response")['rates'];
                console.log("getAllRates: " + JSON.stringify(getAllRates));
                var CurrencyList = [];

                for(var key in getAllRates){
                    CurrencyList.push(key + "=" + getAllRates[key]);
                }
                component.set("v.ListOfCurrency", CurrencyList);
            }
        });

        $A.enqueueAction(action);
    }
})
