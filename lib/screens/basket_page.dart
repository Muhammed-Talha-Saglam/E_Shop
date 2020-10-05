import 'package:e_commerce/services/database.dart';
import 'package:e_commerce/theme/preset_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BasketPage extends StatefulWidget {
  @override
  _BasketPageState createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  List basket = getBasket();

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      bottomSheet: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                if (basket.length > 0) {
                  clearBasket();
                  showToast("Your basket is cleared!");
                  setState(() {
                    basket.clear();
                  });
                }
              },
              child: Container(
                height: deviceSize.height * 0.10,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(50)),
                ),
                child: Text(
                  "Clear Basket",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                if (basket.length > 0) {
                  clearBasket();
                  showToast("Your purchase is done!");
                  setState(() {
                    basket.clear();
                  });
                } else {
                  showToast("You have to add item to you basket first!");
                }
              },
              child: Container(
                height: deviceSize.height * 0.10,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(50)),
                ),
                child: Text(
                  "Buy",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("My Basket",
                  style: headerTextStyle.copyWith(color: Colors.red)),
            ),
            Container(
              width: double.infinity,
              height: deviceSize.height * 0.25,
              child: SvgPicture.asset(
                "assets/shopping-cart.svg",
                color: Colors.black,
              ),
            ),
            ListView.separated(
              separatorBuilder: (_, __) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(
                    height: 4,
                    color: Colors.grey,
                  ),
                );
              },
              shrinkWrap: true,
              primary: false,
              itemCount: basket.length,
              itemBuilder: (context, index) => buildBasketItem(index),
            ),
          ],
        ),
      ),
    );
  }

  ListTile buildBasketItem(int index) {
    return ListTile(
      leading: CircleAvatar(
        child: Image(
          image: getImage(basket[index].item.imgSrc),
        ),
      ),
      title: Text(basket[index].item.brand),
      subtitle: Text(
        "\$ ${basket[index].item.price.toString()}",
        style: TextStyle(color: Colors.orange),
      ),
      trailing: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.red,
          ),
          onPressed: () {
            showToast("Item is removed from your basket!");

            setState(() {
              basket.remove(basket[index]);
            });
            removeBasketItem(basket[index]);
          }),
    );
  }

  void showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      textColor: Colors.white,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.red,
    );
  }
}
