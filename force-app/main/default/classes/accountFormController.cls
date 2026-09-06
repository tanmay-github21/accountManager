public with sharing class accountFormController {
    public string name {get;set;}
    public string type {get;set;}
    public string industry{get;set;}
    public string rating{get;set;}
    public pageReference save(){
        if(string.isBlank(name)){
            apexPages.addMessage(new ApexPages.message(apexPages.severity.Error,'Name is required'));
            return null;
        }
        account ac=new account(name=name, type=type, industry=industry, rating=rating);
        try{
            insert ac;
            pageReference pr= new pageReference('/'+ac.id);
            pr.setRedirect(true);
            return pr;
        }
        catch(Exception e){
            apexPages.addMessage(new apexPages.message(apexPages.severity.error, e.getMessage()));
            return null;
        }
    } //pageReference 
} //end main class