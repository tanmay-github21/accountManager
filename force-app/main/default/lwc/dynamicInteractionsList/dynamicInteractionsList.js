import { LightningElement,track} from 'lwc';
import getAccounts from '@salesforce/apex/dynamicAction_Accounts.getAccounts';
export default class DynamicInteractionsList extends LightningElement {
    @track accounts=[];
    connectedCallback(){
        getAccounts().then(data=>this.accounts=data);
        console.log('kemcho majama'); 
    }
    handleSelect(event){
        event.preventDefault();
        let accountId=event.currentTarget.dataset.accountId;
        console.log('Account id selected'+'\t'+accountId);
        this.dispatchEvent(new CustomEvent('accountselected',{detail:{recordId:accountId}}));
    }
}