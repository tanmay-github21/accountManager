public with sharing class accountSearchController {
    public accountSearchController() {}
    
    //fetchAccounts
    @AuraEnabled(cacheable=true)
    public static list<account> searchAccounts(string searchKey){
        if(string.isBlank(searchKey)){return new list<account>();}
        string key='%'+searchKey+'%';
        return [select id,name,industry,rating,website,type,phone from account where name like :key with USER_MODE limit 50]; 
    }

    //insertAccount
    @AuraEnabled(cacheable=true)
    public static account createAccount(account acc){
        //SERVER__SIDE__Verification
        if(acc ==null || string.isBlank(acc.name)) {
            system.debug('Server error account name or account is blank'); 
            throw new auraHandledException('Server side validation failed'); 
        } //check loop for account name being blank or account being null
        try {
            insert acc; 
            SYstem.debug('Account created successfully with id'+'\t'+acc.Id); 
            return acc;
        }
        catch(exception e){
            
            throw new auraHandledException('Database error while inserting'+'\t'+e.getMessage()+'\n'+
            'Line number'+'\t'+e.getLineNumber()); 

        }
    }
}
