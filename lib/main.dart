import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/resource/login_page.dart';
import 'package:flutter_app/resource/my_main_app.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: isLogin,
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            if (snapShot.data != null) {
              bool isLogin = snapShot.data;
              if (isLogin) {
                return MainPage();
              } else {
                return LoginPage();
              }
            }
          }
          return LoginPage();
        },
      ),
    );
  }

  Future<bool> get isLogin async =>
      (await FirebaseAuth.instance.currentUser()) != null;
}
