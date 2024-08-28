import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../../app_config/app_config.dart';

class ApiHelper {
  static Future<dynamic> postData({
    required String endPoint,
    Map<String, dynamic>? body,
  }) async {
    final url = Uri.parse('https://fakestoreapi.com$endPoint');
    final headers = {"Content-Type": "application/json"};

    final response = await http.post(
      url,
      headers: headers,
      body: body != null ? jsonEncode(body) : null, // Convert Map to JSON string
    );

    // Handle response and decoding here
  }

  static Future<dynamic> getData({
    required String endPoint,
    Map<String, String>? header,
  }) async {
    log("ApiHelper -> getData");
    final url = Uri.parse(AppConfig.baseUrl + endPoint);
    log("url -> $url");
    try {
      var response = await http.get(url, headers: header);
      log("getData -> Status code -> ${response.statusCode}");
      log("response -> ${response.body.toString()}");
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        log("Decoded data: $decodedData");
        return decodedData;
      } else {
        log("API call failed with status code: ${response.statusCode}");
        return null;
      }
    } catch (e, stackTrace) {
      log("Error in ApiHelper.getData: $e\nStackTrace: $stackTrace");
      return null;
    }
  }

 

  

}