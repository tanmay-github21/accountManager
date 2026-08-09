import { LightningElement, track} from 'lwc';

export default class ErrorFixing extends LightningElement {
    accountId='';
    @track statusMessage;
    handleInputChange(event){
        this.accountId=event.target.value;
        console.log('Accountid passed'+'\t'+this.accountId);
    }
    processAccount(){
        try{
            console.log('----START PROCESSING----');
            console.log('User entered id as'+'\t'+this.accountId);
            if(!this.accountId) throw new Error('Account Id cant be blank');
            this.statusMessage=`Processing Account:${this.accountId}`;
            console.log('Processing of account id is successfull');
        }
        catch(error){
            this.statusMessage=`Error: ${error.message}`;
            console.log('console.log output'+'\t'+error.message);
            console.error('console.error output'+'\t'+error);
        }
        finally{
            console.log('----PROCESS COMPLETED----');
        }
    }
}