public with sharing class CloudVisionController {

    public static final string API_KEY = 'AIzaSyAP_Sis7D0DGtLf5dBvnW9QhF2PD5o1PAI';
    public CloudVisionController() {

    }

    @AuraEnabled(cacheable = true)
    public static List<labelAnnotations> getImageInfo(){
        Http http = new Http();
        String requestBody = '{ "requests": [ { "features": [ { "maxResults": 5, "type": "LABEL_DETECTION" } ], "image": { "source": { "imageUri": "https://www.partysuppliesindia.com/cdn/shop/products/1_30_a7f6d93e-7b15-4f61-a90a-2fa69cb23fbe.jpg?v=1735574325&width=1500" } } } ] }';

        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndPoint('https://vision.googleapis.com/v1/images:annotate?key='+API_KEY);
        req.setHeader('Content-Type','application/json');
        req.setBody(requestBody);
        HttpResponse response = http.send(req);

        if(response.getStatusCode() == 200){
            /*Map<String,Object> responseMap = (Map<String,Object>) JSON.deserializeUntyped(response.getBody());
            List<Object> reponseList = (List<Object>)responseMap.get('responses');
            Map<String,Object> firstResponse = (Map<String,Object>) reponseList[0];
            List<Object> labelAnnotations = (List<Object>) firstResponse.get('labelAnnotations');
            List<ImageAnnotationInfo> imagesInfo = new List<ImageAnnotationInfo>();
        
            for ( Object annotation : labelAnnotations){
                Map<String,Object> annotationMap = (Map<String,Object>) annotation;
                String description = (String) annotationMap.get('description');
                Decimal score = (Decimal) annotationMap.get('score');

                ImageAnnotationInfo imageInfo = new ImageAnnotationInfo();
                imageInfo.description = description;
                imageInfo.score = score;
                imagesInfo.add(imageInfo);

                system.debug('Description: '+description+', Score: '+score);
            }

            system.debug('imagesInfo: '+imagesInfo);

            //return 'Callout Successful. Please check developer logs.';
            return imagesInfo;*/
            JsonParser imageInfo= (JsonParser) JSON.deserialize(response.getBody(), JsonParser.class);
            // for(labelAnnotations annotation : imageInfo.responses[0].labelAnnotations){
                
            // }
            return imageInfo.responses[0].labelAnnotations;
        }

        //return 'Something went wrong';
        return null;
    }

    // public class ImageAnnotationInfo{
    //     @AuraEnabled
    //     public String description;
    //     @AuraEnabled
    //     public Decimal score;
    // }

    public class JsonParser{
		public list<responses> responses{get;set;}
    }
	public class responses{
		public list<labelAnnotations> labelAnnotations{get;set;}
	}
	public class labelAnnotations{
        @AuraEnabled
		public Decimal topicality{get;set;}
        @AuraEnabled
		public Decimal score{get;set;}
        @AuraEnabled
		public String description{get;set;}
        @AuraEnabled
		public String mid{get;set;}
	}
}