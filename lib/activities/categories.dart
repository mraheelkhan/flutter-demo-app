import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Category {
  int id;
  String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(id: json['id'], name: json['name']);
  }
}

class Categories extends StatefulWidget {
  @override
  CategoriesState createState() => CategoriesState();
}

class CategoriesState extends State<Categories> {
  late Future<List<Category>> futureCategories;
  final _formKey = GlobalKey<FormState>();
  late Category selectCategory;
  final categoryNameController = TextEditingController();

  Future<List<Category>> fetchCategories() async {
    http.Response response = await http.get(Uri.parse(
        'http://192.168.10.15/Laravel-Flutter-Course-API/public/api/categories'));

    List categories = jsonDecode(response.body);

    return categories.map((category) => Category.fromJson(category)).toList();
  }

  Future saveCategory() async {
    final form = _formKey.currentState;

    if (!form!.validate()) {
      return;
    }

    String uri =
        'http://192.168.10.15/Laravel-Flutter-Course-API/public/api/categories/' +
            selectCategory.id.toString();

    http.Response response = await http.put(Uri.parse(uri),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
        body: jsonEncode({'name': categoryNameController.text}));
    print(response.toString());
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    futureCategories = fetchCategories();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Categories'),
        ),
        body: Container(
            color: Theme.of(context).primaryColorDark,
            child: Center(
                child: FutureBuilder<List<Category>>(
                    future: futureCategories,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              Category category = snapshot.data![index];
                              return ListTile(
                                trailing: IconButton(
                                    onPressed: () {
                                      selectCategory = category;
                                      categoryNameController.text =
                                          category.name;

                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Form(
                                                  key: _formKey,
                                                  child: Column(
                                                    children: <Widget>[
                                                      TextFormField(
                                                        controller:
                                                            categoryNameController,
                                                        //initialValue:
                                                        //    category.name,
                                                        validator:
                                                            (String? value) {
                                                          if (value!.isEmpty) {
                                                            return 'Enter category Name';
                                                          }
                                                          if (value!.length <=
                                                              3) {
                                                            return 'Category name should be greater than 3 letters.';
                                                          }
                                                          return null;
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          labelText:
                                                              'Category Name',
                                                        ),
                                                      ),
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 20),
                                                          child: ElevatedButton(
                                                              onPressed: () {
                                                                saveCategory();
                                                              },
                                                              child: Text(
                                                                  'Save'))),
                                                      TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context),
                                                          child: Text('Close')),
                                                    ],
                                                  )),
                                            );
                                          });
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 24.0,
                                    )),
                                title: Text(
                                  category.name,
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                            });
                      }
                      if (snapshot.hasError) {
                        Text("something went wrong");
                      }
                      return CircularProgressIndicator();
                    }))));
  }
}
