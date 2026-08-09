import { LightningElement,track} from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
export default class CustomErrorHandling extends LightningElement {
    isModalOpen=false; selectedErrorScenario='VALIDATION_ERROR'; @track formAccount={Name:''};
    get errorScenarioOptions(){
        return [{label:'Custom Field Validation Error', value:'VALIDATION_ERROR'}, 
            {label:'System/DML Insert Exception', value:'DML_ERROR'},
            {label:'No Error (Normal Insert)', value:'NONE'}
        ];
    }
    openModal(){
        this.formAccount = {Name:'Test Account'};
        this.selectedErrorScenario='VALIDATION_ERROR';
        this.isModalOpen=true;
    }
    closeModal(){this.isModalOpen=false;}
}