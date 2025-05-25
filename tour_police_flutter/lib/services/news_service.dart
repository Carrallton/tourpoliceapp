// lib/services/news_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/news_model.dart';
import '../constants.dart';

class NewsService {
  static const String _baseUrl = apiBaseUrl;

  Future<List<NewsModel>> getNews() async {
    final response = await http.get(Uri.parse('$_baseUrl/api/news/'));

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((item) => NewsModel.fromJson(item)).toList();
    } else {
      throw Exception('Не удалось загрузить новости');
    }
  }
}