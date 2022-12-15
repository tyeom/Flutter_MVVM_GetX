import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

enum HttpRequestMethod { GET, POST }

class HttpHelper {
  static const String _baseURL = 'arong.info:7004';
  static final Client _client = http.Client();

  static Future<String?> requestHttp(HttpRequestMethod method, String uriPath,
      Map<String, dynamic>? queryParams, String? body) async {
    print('http 요청 - $method / $uriPath');

    try {
      var url = Uri.http(_baseURL, uriPath, queryParams);

      if (method == HttpRequestMethod.GET) {
        final response = await _client.get(url);

        return response.body;
      } else if (method == HttpRequestMethod.POST) {
        final response = await _client.post(url);

        return response.body;
      } else {
        throw Exception("This is an unknown method.");
      }
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  static Future<dynamic?> requestHttpFromJson(HttpRequestMethod method,
      String uriPath, Map<String, dynamic>? queryParams, String? body) async {
    print('http 요청 form json - $method / $uriPath');

    try {
      var url = Uri.http(_baseURL, uriPath, queryParams);

      if (method == HttpRequestMethod.GET) {
        final response = await _client.get(url);
        final jsonMap = jsonDecode(response.body);

        return jsonMap;
      } else if (method == HttpRequestMethod.POST) {
        final response = await _client.post(url);
        final jsonMap = jsonDecode(response.body);

        return jsonMap;
      } else {
        throw Exception("This is an unknown method.");
      }
    } catch (ex) {
      print(ex);
      return null;
    }
  }
}
