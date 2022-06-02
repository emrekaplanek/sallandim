import 'package:http/http.dart' as http;

class RequestService {
  post(String url, String requestData) {}

  static Future<String?> get(String url) async {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }
}
