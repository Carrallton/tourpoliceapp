// lib/providers/auth_provider.dart
import 'package:flutter/material.dart';
import 'package:tour_police_flutter/services/api_service.dart';
import '../models/user_model.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoading = false;
  UserModel? _user;
  String? _token;

  bool get isLoading => _isLoading;
  UserModel? get user => _user;
  String? get token => _token;

  Future<void> register(String username, String email, String password) async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await ApiService().post('/register/', {
        'username': username,
        'email': email,
        'password': password,
      });

      _user = UserModel.fromJson(response['user']);
      _token = response['token'];

      notifyListeners();
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> login(String username, String password) async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await ApiService().post('/auth/token/', {
        'username': username,
        'password': password,
      });

      _token = response['access'];
      _user = UserModel.fromJson(response['user']);

      notifyListeners();
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void logout() {
    _user = null;
    _token = null;
    notifyListeners();
  }
}