import 'dart:convert';
import 'dart:io';

import 'package:flutter_app2/models/category.dart';
import 'package:http/http.dart' as http;

class ApiService {
  late String token;

  ApiService(String token) {
    this.token = token;
  }

  final String baseUrl =
      // 'http://192.168.10.17/Laravel-Flutter-Course-API/public/api/';
      'http://192.168.1.190/Laravel-Flutter-Course-API/public/api/';

  Future<List<Category>> fetchCategories() async {
    http.Response response = await http.get(
      Uri.parse(baseUrl + 'categories'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
    );

    List categories = jsonDecode(response.body);

    return categories.map((category) => Category.fromJson(category)).toList();
  }

  Future<Category> addCategory(String name) async {
    String uri = baseUrl + 'categories';

    http.Response response = await http.post(Uri.parse(uri),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token'
        },
        body: jsonEncode({'name': name}));
    if (response.statusCode != 201) {
      throw Exception('Something went wrong while create! Error code: ' +
          response.statusCode.toString());
    }
    return Category.fromJson(jsonDecode(response.body));
  }

  Future<Category> updateCategory(Category category) async {
    String uri = baseUrl + 'categories/' + category.id.toString();

    http.Response response = await http.put(Uri.parse(uri),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token'
        },
        body: jsonEncode({'name': category.name}));

    if (response.statusCode != 200) {
      throw Exception('Something went wrong! Error code: ' +
          response.statusCode.toString());
    }
    return Category.fromJson(jsonDecode(response.body));
  }

  Future<void> deleteCategory(int id) async {
    String uri = baseUrl + 'categories/' + id.toString();

    http.Response response = await http.delete(
      Uri.parse(uri),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      },
    );
    if (response.statusCode != 204) {
      throw Exception('Something went wrong while deleting! Error code: ' +
          response.statusCode.toString());
    }
  }

  Future<String> register(String name, String email, String password,
      String confirmPassword, String deviceName) async {
    String uri = baseUrl + 'auth/register';

    http.Response response = await http.post(Uri.parse(uri),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': confirmPassword,
          'device_name': deviceName,
        }));
    if (response.statusCode == 422) {
      Map<String, dynamic> body = jsonDecode(response.body);
      Map<String, dynamic> errors = body['errors'];
      String errorMessage = '';
      int index = 1;
      errors.forEach((key, value) {
        value.forEach((error) {
          errorMessage += index.toString() + '. ' + error + '\n';
          index++;
        });
      });

      throw Exception(errorMessage);
    }
    return response.body;
  }

  Future<String> login(String email, String password, String deviceName) async {
    String uri = baseUrl + 'auth/login';

    http.Response response = await http.post(Uri.parse(uri),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
          'device_name': deviceName,
        }));
    if (response.statusCode == 422) {
      Map<String, dynamic> body = jsonDecode(response.body);
      Map<String, dynamic> errors = body['errors'];
      String errorMessage = '';
      int index = 1;
      errors.forEach((key, value) {
        value.forEach((error) {
          errorMessage += index.toString() + '. ' + error + '\n';
          index++;
        });
      });

      throw Exception(errorMessage);
    }
    return response.body;
  }
}
