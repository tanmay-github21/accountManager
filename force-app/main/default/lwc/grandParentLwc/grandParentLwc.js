import { LightningElement, track} from 'lwc';

export default class GrandParentLwc extends LightningElement {
    @track gpLog='None';
    handleGrandParentEvent(event){
        this.gpLog=event.detail.msg;
        console.log('Grandparent received'+'\t'+event.detail.msg); 
    }
}