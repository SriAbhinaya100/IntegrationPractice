import { LightningElement } from "lwc";
// import {NavigationMixin} from 'lightning/navigation';
import getAuthStatus from "@salesforce/apex/hubspotAuthController.getAuthStatus";

// export default class HubspotAuthInitiate extends NavigationMixin(LightningElement) {
export default class HubspotAuthInitiate extends LightningElement {

  connectedCallback() {
    const url = window.location.href;
    const code = new URL(url).searchParams.get("c__code");
    console.log("code: " + code);
    getAuthStatus({ code: code })
      .then((response) => {
        console.log("response: " + JSON.stringify(response));
      })
      .catch((error) => {
        console.log("error: " + JSON.stringify(error));
      });
  }

  handleAuth() {
    window.location.href =
      "https://app-na2.hubspot.com/oauth/authorize?client_id=7645e535-044f-4f2f-ad3a-853d6ede4acf&redirect_uri=https%3A%2F%2Forgfarm-90461e28d7-dev-ed--c.develop.vf.force.com%2Fapex%2FHubSpotRedirectPage&scope=oauth+crm.objects.companies.read";

    // let pageReference = {
    //     type: 'standard__webPage',
    //     attributes: {
    //         url : 'https://app-na2.hubspot.com/oauth/authorize?client_id=7645e535-044f-4f2f-ad3a-853d6ede4acf&redirect_uri=https%3A%2F%2Fwww.google.com&scope=oauth+crm.objects.companies.read'
    //     }
    // }

    // this[NavigationMixin.Navigate](pageReference,[true]);
  }
}
