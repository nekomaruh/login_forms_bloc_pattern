import 'dart:convert';
import 'package:loginformsblocpattern/product_model.dart';
import 'package:http/http.dart' as http;

class ProductProvider{

  final String _url = 'https://flutter-test-dcdf3.firebaseio.com';

  Future<bool> addProduct(Product product) async {
    final url = '$_url/products.json';
    final res = await http.post(url, body: productToJson(product));
    final decoded = json.decode(res.body);
    //print(decoded);
    return true;
  }

  Future<bool> editProduct(Product product) async {
    final url = '$_url/products/${product.id}.json';
    final res = await http.put(url, body: productToJson(product));
    final decoded = json.decode(res.body);
    //print(decoded);
    return true;
  }

  Future<List<Product>> loadProducts() async {
    final url = '$_url/products.json';
    final res = await http.get(url);
    final Map<String, dynamic> decoded = json.decode(res.body);
    final List<Product> products = new List();
    if(decoded==null) return [];
    decoded.forEach((id,product){
      final tempProd = Product.fromJson(product);
      tempProd.id = id;
      products.add(tempProd);
    });
    //print(products);
    return products;
  }

  Future<int> deleteProduct(String id) async {
    final url = '$_url/products/$id.json';
    final res = await http.delete(url);
    //print(res.body);
    return 1;
  }
}