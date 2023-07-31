import 'package:http/http.dart' as http;

class ApiRequestsServices {
  Future<http.Response> post({
    required String url,
    Map<String, String>? headers = const {'Content-Type': 'application/json'},
    Object? body,
  }) async {
    http.Response response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    return response;
  }

  Future<http.Response> get({
    required String url,
    Map<String, String>? headers = const {'Content-Type': 'application/json'},
  }) async {
    http.Response response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    return response;
  }

  Future<http.Response> put({
    required String url,
    Map<String, String>? headers = const {'Content-Type': 'application/json'},
    Object? body,
  }) async {
    http.Response response = await http.put(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    return response;
  }

  Future<http.Response> delete({
    required String url,
    Map<String, String>? headers = const {'Content-Type': 'application/json'},
    Object? body,
  }) async {
    http.Response response = await http.delete(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    return response;
  }
}
