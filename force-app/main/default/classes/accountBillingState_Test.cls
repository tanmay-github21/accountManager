@isTest
public class accountBillingState_Test {
    integer dmlRows=limits.getDmlRows(), dmlStatements=limits.getDmlStatements(), cpuTime=limits.getCputime(), heapSize=limits.getHeapSize();
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
        System.debug('Positive Test Case'+'\n'+
        '+ve DML Statements issued'+'\t'+limits.getDmlStatements()+'\n'+
        '+ve DML Rows Processesd'+'\t'+Limits.getdmlRows()+'\n'+
        '+ve CPU Time Consumed'+'\t'+limits.getcpuTime()+'\n'+
        '+ve heapSize'+'\t'+limits.getheapSize());
    }
    @isTest
    static void opportunityAccount() {
        Account a1 = new Account(Name = 'Dummy');
        insert a1; 

        Integer getDml = Limits.getDmlRows();
        Integer getDmlStatements = Limits.getDmlStatements();
        Integer allowedStatements = Limits.getLimitQueries(); 
        Integer allowedDmlRows = Limits.getLimitDmlRows();

        System.debug('=== TEST CLASS LIMITS METRICS ==='+'\n'+
        'DML Rows Used: ' + getDml+'\n'+
        'DML Statements Used:' + getDmlStatements+'\n'+
        'SOQL Allowed'+'\t'+allowedStatements+'\n'+
        'DML Rows Allowed'+'\t'+allowedDmlRows);
        
        list<opportunity> ops=new list<opportunity>(); 
        for(integer i=0; i<5; i++){
            opportunity op=new opportunity();
            op.name='Dummy Opportunity'+i; 
            op.closedate=date.today();
            op.stageName='Prospecting';
            op.accountId=a1.id; 
            ops.add(op);
        }
        insert ops;
        integer optyDml= limits.getDmlRows()-getDml;
        System.debug('=== TEST CLASS LIMIT METRICS INSERTING 5 Opportunities==='+'\n'+
        'DML Rows Used'+'\t'+optyDml);
        opportunity invalidOpty=new opportunity(name='Invalid',closedate=date.today(), stageName='Prospecting',accountId=a1.id);

        database.saveResult sr=database.insert(invalidOpty,false); 


        boolean success=sr.isSuccess(); 
        assert.areEqual(false,success,'Assertion failed expected to be false');
        assert.isFalse(sr.isSuccess());
    }
}
        