import 'dart:convert';

import 'package:http/http.dart' as http;

class RequestHelpers {

  static Future<dynamic> getRequest(String url) async {
    var response = await http.get(url);

    try {
      if (response.statusCode == 200) {
        String data = response.body;
        var decodedData = jsonDecode(data);
        return decodedData;
      } else {
        return 'failed';
      }
    }
    catch(error) {
      return 'Some error occurred while fetching data';
    }
  }
}