import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Container(
            color: Theme.of(context).primaryColorDark,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Card(
                    elevation: 8,
                    margin: EdgeInsets.only(left: 16, right: 16),
                    child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: <Widget>[
                            TextField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: 'Email',
                              ),
                            ),
                            TextField(
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                labelText: 'Password',
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () => print('Login clicked'),
                              child: Text('Login'),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.blue,
                                  minimumSize: Size(double.infinity, 36)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, '/register');
                                },
                                child: Text("Register new user"),
                              ),
                            )
                          ],
                        )),
                  )
                ])));
  }
}
