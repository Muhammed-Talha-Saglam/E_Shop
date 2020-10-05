import 'package:e_commerce/models/Product.dart';
import 'package:e_commerce/screens/product_details.dart';
import 'package:e_commerce/services/database.dart';
import 'package:e_commerce/theme/preset_styles.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  Product product;

  ProductCard({this.product});

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Details(
              product: product,
            ),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            border: Border.all(color: Colors.black, width: 5),
          ),
          width: deviceSize.width * 0.4,
          height: deviceSize.height * 0.3,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),
                ),
                child: Hero(
                  tag: product.id,
                  child: Image(
                    fit: BoxFit.fill,
                    image: getImage(product.imgSrc),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red.shade300,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            product.brand,
                            style: productsTextStyle.copyWith(
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "\$ ${product.price.toString()}",
                            style: productsTextStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
