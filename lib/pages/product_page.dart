import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  File picture;

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
            onPressed: _selectPicture,
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _takePicture,
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
                  _showPicture(),
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

  Future<void> _submit() async {
    if(!formKey.currentState.validate()) return;
    formKey.currentState.save();

    setState(() {
      _guardando = true;
    });


    if(picture!=null){
      product.imgUrl = await productProvider.uploadImage(picture);
    }

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

  Widget _showPicture(){
    if(product.imgUrl!= null){
      return FadeInImage(
        image: NetworkImage(product.imgUrl),
        placeholder: AssetImage('assets/jar-loading.gif'),
        fit: BoxFit.cover,
      );
    }else{
      if(picture!=null){
        return Image(
          image: AssetImage(picture?.path ?? 'assets/no-image.png'),
          height: 300,
          fit: BoxFit.cover,
        );
      }
      return Image.asset('assets/no-image.png');
    }
  }

  Future<void> _selectPicture() async {
    _processImage(ImageSource.gallery);
  }

  Future<void> _takePicture() async {
    _processImage(ImageSource.camera);
  }

  _processImage(ImageSource origin) async {
    picture =  await ImagePicker.pickImage(source: origin);
    if(picture!=null){
      product.imgUrl = null;
    }
    setState(() {

    });
  }
}
