import 'package:flutter/material.dart';
import 'package:loginformsblocpattern/product_model.dart';
import 'package:loginformsblocpattern/product_provider.dart';
import '../provider.dart';

class HomePage extends StatelessWidget {

  final productProvider = new ProductProvider();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: _showProducts(),
      floatingActionButton: _button(context),
    );
  }

  _button(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: (){
        Navigator.pushNamed(context, 'product');
      },
    );
  }

  _showProducts() {
    return FutureBuilder(
      future: productProvider.loadProducts(),
      builder: (BuildContext context, AsyncSnapshot<List<Product>> snap){
        if(snap.hasData){
          final products = snap.data;
          return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, i){
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(color: Colors.red,),
                  onDismissed: (direction){

                  },
                  child: ListTile(
                    title: Text('${products[i].name} - ${products[i].price}'),
                    subtitle: Text(products[i].id),
                    onTap: (){
                      Navigator.pushNamed(context, 'product');
                    },
                  ),
                );
              });
        }else{
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
