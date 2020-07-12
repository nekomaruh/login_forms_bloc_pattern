import 'package:flutter/material.dart';
import 'package:loginformsblocpattern/product_model.dart';
import 'package:loginformsblocpattern/product_provider.dart';
import 'package:loginformsblocpattern/utils.dart' as utils;

class ProductPage extends StatefulWidget {

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Product product = new Product();
  final productProvider = new ProductProvider();
  bool _guardando = false;

  @override
  Widget build(BuildContext context) {

    final Product productArg = ModalRoute.of(context).settings.arguments;
    if(productArg!=null){
      product = productArg;
    }

    return Scaffold(
      key: scaffoldKey,
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
                  _available(),
                  _button(),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget _name() {
    return TextFormField(
      initialValue: product.name,
      decoration: InputDecoration(
        labelText: 'Product name',
      ),
      textCapitalization: TextCapitalization.sentences,
      onSaved: (name) => product.name = name,
      validator: (name){
        return name.length < 3 ? 'Add product name' : null;
      },
    );
  }

  Widget _price() {
    return TextFormField(
      initialValue: product.price.toString(),
      decoration: InputDecoration(
        labelText: '\$ Price',
      ),
      keyboardType: TextInputType.number,
      onSaved: (price) => product.price = double.parse(price),
      validator: (price){
        return utils.isNumeric(price) ? null : 'Only numbers accepted';
      },
    );
  }

  Widget _button() {
    return RaisedButton.icon(
      label: Text('Save'),
      icon: Icon(Icons.save),
      color: Colors.deepPurple,
      textColor: Colors.white,
      onPressed: _guardando ? null: _submit,
    );
  }

  void _submit(){
    if(!formKey.currentState.validate()) return;
    formKey.currentState.save();

    setState(() {
      _guardando = true;
    });

    if(product.id == null){
      productProvider.addProduct(product);
    }else{
      productProvider.editProduct(product);
    }

    setState(() {
      _guardando = false;
    });

    _showSnackBar("Registro guardado");

    Navigator.pop(context);

  }

  void _showSnackBar(String message){
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 1000),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  Widget _available() {
    return SwitchListTile.adaptive(
      value: product.available,
      title: Text('Available'),
      onChanged: (value){setState(() {
        product.available = value;
      });},
    );
  }
}
