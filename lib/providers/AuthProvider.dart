import 'package:flutter/material.dart';
import 'package:flutter_app2/services/Api.dart';

class AuthProvider extends ChangeNotifier {
  bool isAuthenticated = false;

  ApiService apiService = new ApiService();
  AuthProvider();

  Future<String> register(String name, String email, String password,
      String confirmPassword, String deviceName) async {
    String token = await apiService.register(
        name, email, password, confirmPassword, deviceName);

    isAuthenticated = true;

    return token;
  }
}
