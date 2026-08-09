import { LightningElement, track, wire} from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { encodeDefaultFieldValues } from 'lightning/pageReferenceUtils';
import searchAccounts from '@salesforce/apex/accountSearchController.searchAccounts';
import createAccount from '@salesforce/apex/accountSearchController.createAccount'; 
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
//export default class SearchAccount extends LightningElement {
export default class SearchAccount extends NavigationMixin(LightningElement){
    searchKey='';
    searchResults=[];
    selectedAccountId='';
    selectedAccount=null;
    
    showToast(title, message, variant){
        const evt= new ShowToastEvent({title:title, message:message, variant:variant});
        this.dispatchEvent(evt);
    }
    //ui visibility tags
    hasSearchResults=false; showDetails=false; isModalOpen=false; isCreateFormOpen=false;

    //Form inputs
    newAccName=''; newAccEmployees=null; newAccIndustry=''; serverError='';

    get accountOptions() {
        return this.searchResults.map(acc =>{return {label:acc.Name, value:acc.Id};});
    } //end of get accountOptions() method
    get isDetailsBtnDisabled() {return !this.selectedAccountId;} 
    handleSearchKeyChange(event){
        this.searchKey=event.target.value;
        console.log('Captured value from Input textbox'+'\t'+this.searchKey); 
    }
    handleSearch(){
        console.log('Button has been clicked');
        this.showDetails=false; this.selectedAccountId='';this.selectedAccount=null;
        if(!this.searchKey || !this.searchKey.trim()){
            this.showToast('Warning','Please enter an search term','warning');
            return;
        } //check for blank inputs
        searchAccounts({searchKey:this.searchKey})
        .then((result)=>{
            this.searchResults=result;
            if(result && result.length >0){this.hasSearchResults=true; this.isModalOpen=false;} //result length is >0
            else{this.hasSearchResults=false; this.isModalOpen=true;}
        })
        .catch((error)=>{
            console.error('Error occured while searching accounts'+'\t'+error);
            this.showToast('Error','Failed to retrieve data','error');
        }); 
    } //end of buttonClick event
    handleAccountSelect(event){
        this.selectedAccountId=event.detail.value;
        this.showDetails=false;
        console.log('Account selected in radio button'+'\t'+this.selectedAccountId);
    } //radioButton event change 
    handleShowDetails(){
        const foundAct=this.selectedAccount=this.searchResults.find(acc => acc.Id === this.selectedAccountId);
        if(foundAct){
            this.showDetails=true;
            this.selectedAccount=foundAct;
            console.log('Selected account'+'\t'+this.selectedAccount); 
        }
    }
    closeModal(){this.isModalOpen=false; console.log('Modal is closed');}
    openCreationForm(){
        console.log('Modal Box Name'+'\t'+this.searchKey);
        this.isModalOpen=false;
        const defaultValues=encodeDefaultFieldValues({Name:this.searchKey});
        console.log('Modal Box'+'\t'+defaultValues);
        this[NavigationMixin.Navigate]({type:'standard__objectPage', attributes:{objectApiName:'Account', actionName:'new'}, state:{defaultFieldValues:defaultValues}});
    }

    
}// end of the class    