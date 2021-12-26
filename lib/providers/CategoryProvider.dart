import 'package:flutter/material.dart';
import 'package:flutter_app2/models/category.dart';
import 'package:flutter_app2/services/api.dart';

class CategoryProvider extends ChangeNotifier {
  List<Category> categories = [];
  late ApiService apiService;

  CategoryProvider() {
    this.apiService = ApiService();

    init();
  }

  Future init() async {
    categories = await apiService.fetchCategories();
    notifyListeners();
  }

  Future updateCategory(Category category) async {
    try {
      Category updatedCategory = await apiService.updateCategory(category);
      int index = categories.indexOf(category);

      categories[index] = updatedCategory;

      categories = await apiService.fetchCategories();
      notifyListeners();
    } catch (Exception) {
      print(Exception);
    }
  }
}
