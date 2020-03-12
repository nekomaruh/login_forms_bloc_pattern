import 'package:flutter/material.dart';
import '../provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: _body(),
      floatingActionButton: _button(context),
    );
  }

  _body() {
    return Container();
  }

  _button(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: (){
        Navigator.pushNamed(context, 'product');
      },
    );
  }
}
