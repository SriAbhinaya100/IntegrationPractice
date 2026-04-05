import { LightningElement } from 'lwc';
import getImageInfo from '@salesforce/apex/CloudVisionController.getImageInfo';

export default class CloudVisionComponent extends LightningElement {

    data;
    
    handleClick(){
        getImageInfo()
        .then((response) => {
            console.log(response);
            this.data = response;
        })
        .catch((error)=> {
            console.log(error);
        })
    }
}