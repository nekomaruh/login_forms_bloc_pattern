import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  String id;
  String name;
  double price;
  bool available;
  String imgUrl;

  Product({
    this.id,
    this.name,
    this.price,
    this.available = false,
    this.imgUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    available: json["available"],
    imgUrl: json["img_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "available": available,
    "img_url": imgUrl,
  };
}
