public with sharing class GithubReposController {
    public static final String Endpoint = 'https://api.github.com/repositories?since=1';
    public GithubReposController() {

    }

    @AuraEnabled(cacheable=true)
    public static String getRepos(){
        //1.Instantiate the HTTP Class
        Http http = new Http();
        //2.Create/Draft a Request
        HttpRequest req= new HttpRequest();
        req.setMethod('GET');
        req.setEndPoint(Endpoint);
        //3.Send the request and get the response
        HttpResponse response = http.send(req);
        if(response.getStatusCode() == 200){
            return response.getBody();
        }
        else {
            return 'Something went wrong';
        }
    }
}