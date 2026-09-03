@isTest
public class accountBillingState_Test {
    @isTest
    static void testMethod1(){
        list<account> acts=new list<account>{new account(name='1', type='Prospect'),
        new account(name='2',type='Partner')};
        try{
            accountBillingState.method1(acts);
        }
        catch(exception e){}
        for(account a:acts){
            if(a.type=='Prospect'){
                System.debug('Test class assertMethod for account prospect');
                assert.areequal(false,a.hasErrors()); 
                assert.areequal(0,a.getErrors().size());
            } //prospect check test
            else {
                System.debug('Test class assertMethod for account not prospect');
                assert.areEqual(true,a.hasErrors());
            }
        } //for loop
    } 
    
    @isTest
    static void testMethod2(){
        list<account> a2=new list<account>{new account(name='', type='prospect'), new account(name='',type='Partner')};
        accountBillingState.method2(a2); 
        for(account a:a2){
            if(a.type=='Patner') assert.areequal(false,a.hasErrors());
            else {
                boolean isNotPartner=(a.type !='Patner')?true:false;
                system.assertEquals(true,isNotPartner,'method2 assert values do not match');
                system.debug('Test class method2 account type'+'----'+a.type);
            }
        }
    } // end of testMethod2 
}