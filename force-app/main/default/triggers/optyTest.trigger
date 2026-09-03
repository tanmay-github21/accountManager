trigger optyTest on opportunity (before insert) {
    accountBillingState.checkOpportunity(trigger.new); 
}