import 'package:uuid/uuid.dart';

class Product {
  final id = Uuid().v1();
  final String brand;
  final double price;
  final String imgSrc;

  Product({this.brand, this.price, this.imgSrc});

  factory Product.fromJson(Map map) {
    return Product(
      brand: map["brand"],
      price: double.tryParse(map["price"].toString()),
      imgSrc: map["img_url"],
    );
  }
}
