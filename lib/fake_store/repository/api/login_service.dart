import 'dart:developer';
import 'dart:convert';
import 'package:http/http.dart'as http;

import 'package:demo/fake_store/repository/helper/api_helper.dart';

class LoginService {
  static Future<dynamic> postLoginData(String username, String password) async {
    final url = Uri.parse('https://fakestoreapi.com/auth/login');
    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode({"username": username, "password": password});

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      // Log status code and response body
      log("Status Code: ${response.statusCode}");
      log("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        // Log response error for debugging
        log("API Error: ${response.reasonPhrase}");
        return null;
      }
    } catch (e) {
      log("Error: $e");
      return null;
    }
  }
}
