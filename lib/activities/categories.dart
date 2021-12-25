import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app2/models/category.dart';
import 'package:flutter_app2/services/Api.dart';
import 'dart:convert';

import 'package:flutter_app2/widgets/CategoryEdit.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late Future<List<Category>> futureCategories;
  ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    futureCategories = apiService.fetchCategories();
  }

  @override
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
                                      showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          builder: (context) {
                                            return CategoryEdit(category);
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
