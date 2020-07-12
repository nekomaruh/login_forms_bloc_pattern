import 'dart:convert';
import 'dart:io';
import 'package:loginformsblocpattern/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';

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

  Future<String> uploadImage(File imageFile) async {
    final url = Uri.parse('https://api.cloudinary.com/v1_1/doqebrksl/image/upload?upload_preset=orkslkzn');
    final mimeType = mime(imageFile.path).split("/"); // image/jpeg

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath(
        'file',
        imageFile.path,
        contentType: MediaType(mimeType[0], mimeType[1])
    );

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final res = await http.Response.fromStream(streamResponse);

    if(res.statusCode != 200 && res.statusCode!=201){
      print("Something went wrong");
      print(res.body);
      return null;
    }

    final resData = json.decode(res.body);
    print(resData);
    return resData['secure_url'];
  }
}