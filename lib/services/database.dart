import 'package:e_commerce/models/basket_item.dart';
import 'package:firebase_image/firebase_image.dart';

// we fetch product pictures from firebase storage
FirebaseImage getImage(String imgUrl) {
  var url = "gs://e-commerce-a4269.appspot.com/" + imgUrl;
  return FirebaseImage(url);
}

// Keep track of what user has added to the basket
List<BasketItem> basket = [];

List<BasketItem> getBasket() {
  return basket;
}

void addToBasket(BasketItem item) {
  basket.add(item);
}

void removeBasketItem(BasketItem item) {
  basket.remove(item);
}

void clearBasket() {
  basket.clear();
}
