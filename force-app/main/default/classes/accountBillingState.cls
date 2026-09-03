public with sharing class accountBillingState {
    public static void method1(list<account> acts){
        integer count1=acts.size(), count2=0, count3=0;
        list<account> insertAccounts= new list<account>();
        for(account tempAct:acts){
            if(tempAct.type =='Prospect'){
                 insertAccounts.add(tempAct);
            }
            else{
                tempAct.addError('Account type isnt Prospect');
                list<database.error> errors=tempAct.getErrors();
                for(database.error er:errors)
                System.debug('Main class account \'s type isnt prospect'+'\n'+
                'Main classError message'+'----'+er.getMessage()+'\n'+
                'Main class Error field'+'----'+er.getFields());
            }
        }
        insert insertAccounts;
        System.debug('Inserted'+'\t'+insertAccounts.size()+'\t'+'accounts'+'\n'+
        'total accounts passed'+'\t'+count1);
    }
    public static void method2(list<account>acts2){
        list<account> ia2=new list<account>(); 
        for(account temp2:acts2){
            if(temp2.type=='Partner'){
                ia2.add(temp2);
            }
            else{
                temp2.addError('Account isnt a partner account');
                list<database.error> errors=temp2.getErrors();
                for(database.error er:errors)
                System.debug('Main class method2 error'+'\n'+
                'Error message'+'----'+er.getmessage()+'\n'+
                'Erro Status'+'----'+er.getStatusCode());
            }
        }
    }

    public static void checkOpportunity(list<opportunity> ops){
        set<id> acctIds=new set<id>(); 
        list<opportunity> oq= new list<opportunity>();
        for(Opportunity o1:ops){
            if(o1.accountId !=null) acctIds.add(o1.accountId);
        }
        map<Id,Account> accMap=new map<id,Account>([select Id,(select id from opportunities where isClosed=false) from account where id in:acctIds]);
        for(opportunity o1:ops){
            if(o1.accountId !=null && accMap.containsKey(o1.accountId)){
                if(accMap.get(o1.accountId).opportunities.size() <4) oq.add(o1);
                else{
                    o1.addError('No more than 4 active opportunities');
                    list<database.error> errors=new list<database.error>();
                    for(database.error er:errors)
                    System.debug('Account has more than 4 active opportunities'+'\n'+
                    'Error Status Code'+'\t'+er.getStatusCode());
                } //account has more than 4 active opty
            }
        }
        insert oq; 
    }
}