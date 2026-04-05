import { LightningElement, wire } from 'lwc';
import getRepos from '@salesforce/apex/GithubReposController.getRepos';

export default class GetGithubRepos extends LightningElement {

    @wire(getRepos)
    repos({ error, data }){
        if(data){
            console.log(data);
        }
        else if(error){
            console.log(error);
        }

    }
}