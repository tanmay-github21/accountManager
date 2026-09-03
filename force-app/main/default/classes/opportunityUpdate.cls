public with sharing class opportunityUpdate {
    public static void processRecords(list<opportunity> opps){
        list<opportunity> opps2Update=new list<opportunity>(); 
        for(Opportunity o:opps){
            if(o.StageName=='Closed Won'){}
        } //loop through passed opportunities
    }
}