import 'package:flutter/material.dart';
import 'package:loginformsblocpattern/pages/home_page.dart';
import 'package:loginformsblocpattern/pages/login_page.dart';
import 'package:loginformsblocpattern/pages/product_page.dart';

import 'provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return Provider(
      child: MaterialApp(
        title: 'Login & Forms',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        initialRoute: 'home',
        routes: {
          'login' : (_) => LoginPage(),
          'home' :(_) => HomePage(),
          'product' : (_) => ProductPage()
        },
      ),
    );

  }
}