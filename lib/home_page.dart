import 'package:flutter/material.dart';
import 'provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Email: ${bloc.email}'),
            SizedBox(height: 10,),
            Text('Password: ${bloc.password}'),
          ],
        ),
      ),
    );
  }
}
