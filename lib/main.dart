import 'package:flutter/material.dart';
import 'package:loginformsblocpattern/home_page.dart';
import 'package:loginformsblocpattern/login_page.dart';

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
        initialRoute: 'login',
        routes: {
          'login' : (_) => LoginPage(),
          'home' :(_) => HomePage()
        },
      ),
    );

  }
}