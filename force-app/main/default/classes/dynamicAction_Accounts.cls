public with sharing class dynamicAction_Accounts {
    public dynamicAction_Accounts() {

    }
    @AuraEnabled(cacheable=true)
    public static list<account> getAccounts(){
        return [select name, industry,format(createddate),format(lastModifieddate) from account where industry !='' Limit 20]; 
    }
}