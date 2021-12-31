import 'package:flutter/material.dart';
import 'package:flutter_app2/services/Api.dart';

class AuthProvider extends ChangeNotifier {
  late bool isAuthenticated = false;
  late String token;

  // By default, we don't have the token here
  ApiService apiService = new ApiService('');

  Future<void> register(String name, String email, String password,
      String confirmPassword, String deviceName) async {
    token = await apiService.register(
        name, email, password, confirmPassword, deviceName);
    isAuthenticated = true;
  }

  Future<void> login(String email, String password, String deviceName) async {
    token = await apiService.login(email, password, deviceName);
    isAuthenticated = true;
  }

  Future<void> logOut() async {
    token = '';
    isAuthenticated = false;

    notifyListeners();
  }
}
