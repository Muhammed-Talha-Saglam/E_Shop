import 'package:e_commerce/models/Product.dart';
import 'package:flutter/cupertino.dart';

class BasketItem {
  Product item;
  int quantity;

  BasketItem({@required this.item, @required this.quantity});
}
