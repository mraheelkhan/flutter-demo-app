import 'package:flutter/material.dart';
import 'package:flutter_app2/activities/categories.dart';
import 'package:flutter_app2/activities/login.dart';
import 'package:flutter_app2/activities/register.dart';
import 'package:flutter_app2/models/Category.dart';

import 'package:flutter_app2/providers/CategoryProvider.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<CategoryProvider>(
            create: (context) => CategoryProvider(),
          )
        ],
        child: MaterialApp(
          home: Login(),
          routes: {
            '/login': (context) => Login(),
            '/register': (context) => Register(),
            '/categories': (context) => Categories(),
          },
        ));
  }
}
