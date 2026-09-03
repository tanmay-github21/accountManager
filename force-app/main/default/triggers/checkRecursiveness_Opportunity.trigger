trigger checkRecursiveness_Opportunity on Opportunity (after insert, after update) {
    if(tanmaypd2.triggerRecursiveDepth.hasRecursed==false){
         System.debug('Trigger check for variable positivity negativity');
         tanmaypd2.triggerRecursiveDepth.hasRecursed=true; 
         tanmaypd2.triggerRecursiveDepth.calculateValue(trigger.new);
    }
                
               
               
}