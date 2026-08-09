import { LightningElement, wire} from 'lwc';
import {getRecord} from 'lightning/uiRecordApi';
import name from '@salesforce/schema/account.name';
import industry from '@salesforce/schema/account.industry';
import rating from '@salesforce/schema/account.rating';
import website from '@salesforce/schema/account.website';
import phone from '@salesforce/schema/account.phone';
export default class ChildLwc extends LightningElement {
    accountId;
    @wire(getRecord,{recordId:'$accountId',fields:[name, industry, rating,website,phone]})
    account;
    handleIdChange(event){
        this.accountId=event.target.value;
        console.log('AccountID received'+'\t'+this.accountId);
    }
    sendEvent(){
        if(this.accountId && this.account.data){
            console.log('Button clicked with data');
            const event= new CustomEvent('child',{detail:this.account.data} );
            this.dispatchEvent(event);
        }
        else console.log('Button was clicked from child without any record id');
    }
    fireCase1(){
        this.dispatchEvent(new CustomEvent('testevent',{bubbles:false,composed:false,detail:{msg:'case-1 (false,false)'}}));
    }
    fireCase2(){
        this.dispatchEvent(new CustomEvent('testevent',{bubbles:true,composed:false,detail:{msg:'Case-2 (true,false)'}}));
    }
    fireCase3(){
        this.dispatchEvent(new CustomEvent('testevent',{bubbles:true,composed:true, detail:{msg:'Case-3 (true,true) fired'}}));
    }
    fireCase4(){
        this.dispatchEvent(new CustomEvent('testevent',{bubbles:false,composed:true,details:{msg:'Case-4 Only Composed is True'}}));
    }
}