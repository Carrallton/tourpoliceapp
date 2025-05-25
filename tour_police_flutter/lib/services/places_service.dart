import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/place_model.dart';
import '../constants.dart';

class PlacesService {
  static const String _baseUrl = apiBaseUrl;

  Future<List<PlaceModel>> getPlaces() async {
    final response = await http.get(Uri.parse('$_baseUrl/api/places/'));
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((item) => PlaceModel.fromJson(item)).toList();
    } else {
      throw Exception('Не удалось загрузить места');
    }
  }
}