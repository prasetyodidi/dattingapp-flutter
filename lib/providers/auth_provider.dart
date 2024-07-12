// lib/providers/auth_provider.dart
import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AuthProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  String? _token;

  String? get token => _token;

  Future<void> login(String email, String password) async {
    _token = await _apiService.login(email, password);
    notifyListeners();
  }

  Future<void> register(String email, String password, String name) async {
    _token = await _apiService.register(email, password, name);
    notifyListeners();
  }

  Future<void> logout() async {
    await _apiService.logout(_token!);
    _token = null;
    notifyListeners();
  }

  bool get isAuthenticated => _token != null;
}
