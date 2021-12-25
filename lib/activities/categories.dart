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
  Future<List<Category>> fetchCategories() async {
    http.Response response = await http.get(Uri.parse(
        'http://192.168.10.15/Laravel-Flutter-Course-API/public/api/categories'));

    List categories = jsonDecode(response.body);

    return categories.map((category) => Category.fromJson(category)).toList();
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
                                    onPressed: () => {print(category.name)},
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
