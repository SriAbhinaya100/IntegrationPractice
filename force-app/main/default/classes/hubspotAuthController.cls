public with sharing class hubspotAuthController {
  public hubspotAuthController() {
  }

  @AuraEnabled
  public static String getAuthStatus(String code) {
    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.setEndpoint('https://api.hubapi.com/oauth/v1/token');
    request.setMethod('POST');
    request.setHeader('Content-Type', 'application/x-www-form-urlencoded');

    String requestBody =
      'grant_type=authorization_code&code=' +
      code +
      '&redirect_uri=https://orgfarm-90461e28d7-dev-ed--c.develop.vf.force.com/apex/HubSpotRedirectPage' +
      '&client_id=7645e535-044f-4f2f-ad3a-853d6ede4acf&client_secret=8467a56f-9509-4bba-873a-2c03dab05f65';

    request.setBody(requestBody);
    HttpResponse response = http.send(request);

    if (response.getStatusCode() == 200) {
      Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
      String accessToken = (String) responseMap.get('access_token');
    //   String companyInfo = syncAccount(accessToken);
      String companyInfo = syncAccounts(accessToken);
      System.debug('accessToken: ' + accessToken);
      return companyInfo;
    } else {
      return 'Something went wrong, authentication failed!';
    }
  }

  @AuraEnabled
  public static string syncAccount(String accessToken) {
    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.setMethod('GET');
    request.setEndpoint(
      'https://api.hubapi.com/crm/v3/objects/companies/300406701796?properties=name&properties=industry&propertiesWithHistory=name'
    );
    request.setHeader('Content-Type', 'application/json');
    request.setHeader('Authorization', 'Bearer ' + accessToken);
    HttpResponse response = http.send(request);
    return response.getBody();
  }

  @AuraEnabled
  public static string syncAccounts(String accessToken) {
    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.setMethod('POST');
    request.setEndpoint(
      'https://api.hubapi.com/crm/v3/objects/companies/batch/read'
    );
    request.setHeader('Content-Type', 'application/json');
    request.setHeader('Authorization', 'Bearer ' + accessToken);
    //request.setBody('{ "propertiesWithHistory": [ "name" ], "inputs": [ { "id": "300406701796" } ], "properties": [ "name", "industry" ] }');
    BatchReadRequestBody requestBody = new BatchReadRequestBody();
    requestBody.propertiesWithHistory = new List<String>{ 'name' };
    requestBody.inputs = new List<Map<String,String>>{
        new Map<String,String>{'id' => '300406701796'}
    };
    requestBody.properties = new List<String>{ 'name', 'industry' };

    request.setBody(JSON.serialize(requestBody));
    
    HttpResponse response = http.send(request);
    if(response.getStatusCode() == 200){
      Map<String,Object> responseMap = (Map<String,Object>) JSON.deserializeUntyped(
        response.getBody()
      );
      List<Object> results = (List<Object>) responseMap.get('results');
      String name;
      String industry;
      for(Object result : results){
        Map<String,Object> companyMap = (Map<String,Object>) result;
        Map<String,Object> properties = (Map<String,Object>) companyMap.get('properties');
        name = (String) properties.get('name');
        industry = (String) properties.get('industry');
      }
      return name + '--' + industry;
    } else {
        return 'Something went wrong, callout failed!';
    }
  }

  private class BatchReadRequestBody {
    public List<String> propertiesWithHistory;
    public List<Map<String,String>> inputs;
    public List<String> properties;
  }
}
