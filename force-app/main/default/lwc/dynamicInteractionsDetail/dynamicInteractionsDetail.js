import { LightningElement, track} from 'lwc';
import getAccounts from '@salesforce/apex/dynamicAction_Accounts.getAccounts';
export default class DynamicInteractionsDetail extends LightningElement {
    @track contacts=[];
    connectedCallback(){
        getAccounts().then(data=>this.contacts=data);
    }
    selectAccount(event){
        event.preventDefault();
        let accountId=event.currentTarget.dataset.accountId;
        console.log('Account selected'+'\t'+accountId);
        this.dispatchEvent(new CustomEvent('accountselected',{detail:{recordId:contactId}})); 
    }
}