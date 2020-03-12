import 'package:flutter/material.dart';
import 'package:loginformsblocpattern/pages/product_model.dart';
import 'package:loginformsblocpattern/utils.dart' as utils;

class ProductPage extends StatefulWidget {

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final formKey = GlobalKey<FormState>();
  Product product = new Product();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: (){},
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: (){},
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(15),
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  _name(),
                  _price(),
                  _button(),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }

  _name() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Product name',
      ),
      textCapitalization: TextCapitalization.sentences,
      validator: (name){
        return name.length < 3 ? 'Add product name' : null;
      },
    );
  }

  _price() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: '\$ Price',
      ),
      keyboardType: TextInputType.number,
      validator: (price){
        return utils.isNumeric(price) ? null : 'Only numbers accepted';
      },
    );
  }

  _button() {
    return RaisedButton.icon(
      label: Text('Save'),
      icon: Icon(Icons.save),
      color: Colors.deepPurple,
      textColor: Colors.white,
      onPressed: _submit,
    );
  }

  _submit(){
    if(!formKey.currentState.validate()) return;
  }
}
