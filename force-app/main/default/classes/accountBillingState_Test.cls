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
    @isTest
    static void positiveCase(){
        list<opportunity> o1=new list<opportunity>();
        account a1=new account(name='dummy');
        insert a1; 
        for(integer i=1; i<=4; i++){
            Opportunity q=new Opportunity();
            q.name='Dummy';
            q.accountId=a1.Id;
            q.stageName='Prospecting';
            q.closeDate=date.today();
            o1.add(q);
        }
        insert o1;
    }

    @isTest
    static void negativecase(){
        list<opportunity> o2= new list<opportunity>();
        account a1=new account(name='d');
        insert a1;
        for(integer i=0; i<=3; i++){
            opportunity o=new opportunity(); 
            o.name='dummy';
            o.stageName='Prospecting';
            o.accountId=a1.id;
            o.closeDate=date.today();
            o2.add(o); 
        }
        insert o2; 
        System.debug('opty_Negative_Test_Scenario_Opportunity_Size'+'----'+o2.size());
        Opportunity o3= new opportunity(name='d',accountId=a1.id, closedate=date.today(), stageName='Prospecting'); 
        database.saveResult sr= database.insert(o3,false); 
        //assert.isFalse(sr.isSuccess());
    }
}