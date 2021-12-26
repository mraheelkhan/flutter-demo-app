import 'dart:convert';
import 'dart:io';

import 'package:flutter_app2/models/category.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl =
      'http://192.168.43.213/Laravel-Flutter-Course-API/public/api/';

  Future<List<Category>> fetchCategories() async {
    http.Response response = await http.get(Uri.parse(baseUrl + 'categories'));

    List categories = jsonDecode(response.body);

    return categories.map((category) => Category.fromJson(category)).toList();
  }

  Future<Category> updateCategory(Category category) async {
    String uri = baseUrl + 'categories/' + category.id.toString();

    http.Response response = await http.put(Uri.parse(uri),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
        body: jsonEncode({'name': category.name}));

    if (response.statusCode != 200) {
      throw Exception('Something went wrong! Error code: ' +
          response.statusCode.toString());
    }
    return Category.fromJson(jsonDecode(response.body));
  }
}
