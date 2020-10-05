import 'package:carousel_pro/carousel_pro.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';

class MainCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      child: Carousel(
        dotSize: 7,
        dotColor: Colors.white,
        dotIncreasedColor: Colors.red,
        indicatorBgPadding: 10,
        images: [
          Image(
            image: FirebaseImage(
                "gs://e-commerce-a4269.appspot.com/jeans_pic1.jpg"),
          ),
          Image(
            image: FirebaseImage(
                "gs://e-commerce-a4269.appspot.com/shirts_pic1.jpg"),
          ),
          Image(
            image: FirebaseImage(
                "gs://e-commerce-a4269.appspot.com/shoes_pic1.jpg"),
          ),
          Image(
            image: FirebaseImage(
                "gs://e-commerce-a4269.appspot.com/tshirts_pic1.jpg"),
          ),
        ],
      ),
    );
  }
}
