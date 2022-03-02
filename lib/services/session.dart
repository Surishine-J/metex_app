import 'dart:convert';

import 'package:http/http.dart' as http;

class MySession {
  static Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8'
  };

  static Future<http.Response> get(String url) async {
    Uri uri = Uri.parse(url); //url on web
    http.Response response = await http.get(uri, headers: headers);
    updateCookie(response);
    // return json.decode(response.body);
    return response;
  }

  static Future<http.Response> post(String url, dynamic data) async {
    Uri uri = Uri.parse(url);
    print(headers);
    http.Response response = await http.post(uri, body: data, headers: headers);
    updateCookie(response);
    // return json.decode(response.body);
    return response;
  }

  static void updateCookie(http.Response response) {
    print(response.headers);
    String? rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      headers['cookie'] =
          (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }
}
