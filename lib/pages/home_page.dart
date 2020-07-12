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
                return _buildItem(context, products[i]);
              });
        }else{
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  _buildItem(BuildContext context, Product product){
    return Dismissible(
      key: UniqueKey(),
      background: Container(color: Colors.red,),
      onDismissed: (direction){
        print(product.id);
        productProvider.deleteProduct(product.id);
      },
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          children: <Widget>[
            product.imgUrl == null ? Image(
              image: AssetImage('assets/no-image.png'),)
                : FadeInImage(
              image: NetworkImage(product.imgUrl),
              placeholder: AssetImage('assets/jar-loading.gif'),
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            ListTile(
              title: Text('${product.name} - ${product.price}'),
              subtitle: Text(product.id),
              onTap: (){
                Navigator.pushNamed(context, 'product', arguments: product);
              },
            ),
          ],
        ),
      )
    );
  }


}
