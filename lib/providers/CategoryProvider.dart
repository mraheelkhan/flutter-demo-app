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

  Future addCategory(String name) async {
    try {
      Category addCategory = await apiService.addCategory(name);
      categories.add(addCategory);

      notifyListeners();
    } catch (Exception) {
      print(Exception);
    }
  }

  Future updateCategory(Category category) async {
    try {
      Category updatedCategory = await apiService.updateCategory(category);
      int index = categories.indexOf(category);

      categories[index] = updatedCategory;

      notifyListeners();
    } catch (Exception) {
      print(Exception);
    }
  }

  Future deleteCategory(Category category) async {
    try {
      await apiService.deleteCategory(category.id);
      categories.remove(category);

      notifyListeners();
    } catch (Exception) {
      print(Exception);
    }
  }
}
