import 'dart:io';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/models/category.dart';
import 'package:flutter_app2/providers/CategoryProvider.dart';
import 'package:flutter_app2/services/Api.dart';
import 'dart:convert';

import 'package:flutter_app2/widgets/CategoryEdit.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CategoryProvider>(context);
    List<Category> categories = provider.categories;
    return Scaffold(
        appBar: AppBar(
          title: Text('Categories'),
        ),
        body: Container(
            color: Theme.of(context).primaryColorDark,
            child: Center(
                child: ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (BuildContext context, int index) {
                      Category category = categories[index];
                      return ListTile(
                        title: Text(
                          category.name,
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return CategoryEdit(
                                        category, provider.updateCategory);
                                  });
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 24.0,
                            )),
                      );
                    }))));
  }
}
