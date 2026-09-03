trigger OpportunityPlatformEvent on Opportunity (before update) {
    list<opportunity_Event__e> opportunityEvents= new list<opportunity_Event__e>(); 
    for(opportunity o1:trigger.new){
        if(o1.StageName=='Closed Won' || o1.StageName=='Closed Lost'){
            System.debug('Event is going to be published for'+'\t'+o1.Name+'\t'+o1.StageName);
             opportunityEvents.add( new opportunity_Event__e(Opportunity_name__c=o1.Name,
                                                            amount__c=o1.Amount,
                                                            Instalation_Date__c=o1.CloseDate+14,
                                                            opportunity_Id__c=o1.Id,
                                                            status__c=(o1.StageName=='Closed Won')?'Deal Won':'Deal Lost'));
        } //if statement check for stageName
        
    } //outter for loop 
    Opportunity_Event__e optyEvent=(opportunity_Event__e)Opportunity_Event__e.sObjectType.newSObject(null,true);
    string local_UUID=optyEvent.eventUUID; 
    myEventPublishCallBack cb= new myEventPublishCallBack(); 
    
    SYstem.debug('EventUUID received in the trigger'+'\t'+local_UUID); 
    list<database.saveResult> dsr=Eventbus.publish(opportunityEvents,cb);
    for(database.saveResult sr:dsr){
        if(sr.isSuccess()) System.debug('Immediate Check IN trigger :Gatekeeper accepts the event');
        else{
            for(database.error err:sr.getErrors()) System.debug('Immediate Check In Trigger - Gatekeeper Refuses The event'+'\n'+
                                                               'Error'+'\t'+'-'+
                                                               err.getStatusCode()+'\n'+
                                                               err.getMessage());
        }
    }
}