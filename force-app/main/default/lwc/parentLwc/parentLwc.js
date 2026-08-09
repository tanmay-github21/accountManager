import { LightningElement,track} from 'lwc';
export default class ParentLwc extends LightningElement {
    name; rating; industry; phone; website; 
    @track parentLog='None';
    show(event){
        const act=event.detail;
        console.log('Parent syas hello'+'\n'+
            'Data passed from child'+'\t'+JSON.stringify(event.detail)
        );
        this.name=act.fields.Name.value;
        this.industry=act.fields.Industry.value;
        this.rating=act.fields.Rating.value;
        this.phone=act.fields.Phone.value;
        this.website=act.fields.Website.value;
    }
    handleParentContainerEvent(event){
        this.parentLog=event.detail.msg;
        console.log('parentContainer received'+'\t'+event.detail.msg);
    }
    handleTestEvent(event){
        
    }
}