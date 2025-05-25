import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = String.fromEnvironment('API_BASE_URL');

  Future<dynamic> get(String endpoint) async {
    final response = await http.get(Uri.parse('$_baseUrl$endpoint'));
    if (response.statusCode == 200) return jsonDecode(response.body);
    throw Exception('Ошибка загрузки данных');
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$_baseUrl$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    if (response.statusCode == 200 || response.statusCode == 201) return jsonDecode(response.body);
    throw Exception('Ошибка отправки данных');
  }
}