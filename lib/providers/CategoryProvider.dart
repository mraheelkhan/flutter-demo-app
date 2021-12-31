import 'package:flutter/material.dart';
import 'package:flutter_app2/models/category.dart';
import 'package:flutter_app2/providers/AuthProvider.dart';
import 'package:flutter_app2/services/api.dart';

class CategoryProvider extends ChangeNotifier {
  List<Category> categories = [];

  late ApiService apiService;
  late AuthProvider authProvider;

  CategoryProvider(AuthProvider authProvider) {
    this.authProvider = authProvider;
    this.apiService = ApiService(authProvider.token);
    // this line above is the main part
    init();
  }

  Future getCategories() async {
    categories = await apiService.fetchCategories();
    notifyListeners();
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
      await authProvider.logOut();
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
      await authProvider.logOut();
    }
  }

  Future deleteCategory(Category category) async {
    try {
      await apiService.deleteCategory(category.id);
      categories.remove(category);

      notifyListeners();
    } catch (Exception) {
      print(Exception);
      await authProvider.logOut();
    }
  }
}
