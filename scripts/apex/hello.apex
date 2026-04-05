// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

// string tempvar = 'Enter_your_name_here';
// System.debug('Hello World!');
// System.debug('My name is ' + tempvar);

Http http = new Http();
        String requestBody = '{ "requests": [ { "features": [ { "maxResults": 5, "type": "LABEL_DETECTION" } ], "image": { "source": { "imageUri": "https://www.partysuppliesindia.com/cdn/shop/products/1_30_a7f6d93e-7b15-4f61-a90a-2fa69cb23fbe.jpg?v=1735574325&width=1500" } } } ] }';
        public static final string API_KEY = 'AIzaSyAP_Sis7D0DGtLf5dBvnW9QhF2PD5o1PAI';

        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndPoint('https://vision.googleapis.com/v1/images:annotate?key='+API_KEY);
        req.setHeader('Content-Type','application/json');
        req.setBody(requestBody);
        HttpResponse response = http.send(req);
        system.debug(response.getBody());