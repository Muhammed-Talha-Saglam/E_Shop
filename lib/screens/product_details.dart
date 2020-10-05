import 'package:e_commerce/models/Product.dart';
import 'package:e_commerce/models/basket_item.dart';
import 'package:e_commerce/services/database.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Details extends StatefulWidget {
  final Product product;

  const Details({Key key, this.product}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int pieces = 1;

  void decrementPieces() {
    if (pieces > 1) {
      setState(() {
        pieces = pieces - 1;
      });
    }
  }

  void incrementPieces() {
    if (pieces < 10) {
      setState(() {
        pieces = pieces + 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      body: ListView(
        children: [
          SizedBox(
            height: 30,
          ),
          Hero(
            tag: widget.product.id,
            child: Image(
              height: 250,
              width: 200,
              image: getImage(widget.product.imgSrc),
            ),
          ),
          SizedBox(height: 20),
          buildDetails("Brand: ", widget.product.brand),
          buildDetails("Price: ", widget.product.price.toString()),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Text(
              "Quantity",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                  decoration: TextDecoration.underline),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: incrementPieces,
                    icon: Icon(
                      Icons.keyboard_arrow_up_outlined,
                      size: 40,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    pieces.toString(),
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  IconButton(
                    onPressed: decrementPieces,
                    icon: Icon(
                      Icons.keyboard_arrow_down_outlined,
                      size: 40,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              buildCartButton(),
            ],
          ),
        ],
      ),
    );
  }

  Padding buildCartButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
        padding: EdgeInsets.all(16),
        color: Colors.red,
        splashColor: Colors.purple,
        onPressed: () {
          // We add product and its quantity to basket
          addToBasket(BasketItem(item: widget.product, quantity: pieces));
          showToast();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            SizedBox(width: 15),
            Text(
              "Add to cart",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  void showToast() {
    Fluttertoast.showToast(
      msg: "Item is added to your basket!",
      toastLength: Toast.LENGTH_LONG,
      textColor: Colors.white,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.red,
    );
  }

  Padding buildDetails(String name, String detail) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 2, color: Colors.teal),
            borderRadius: BorderRadius.circular(25)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: TextStyle(fontSize: 20),
            ),
            Spacer(),
            Text(
              detail,
              style: TextStyle(color: Colors.red, fontSize: 15),
            ),
            Spacer(),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
