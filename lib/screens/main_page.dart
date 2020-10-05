import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/models/Product.dart';
import 'package:e_commerce/screens/auth_page.dart';
import 'package:e_commerce/screens/product_details.dart';
import 'package:e_commerce/services/auth.dart';
import 'package:e_commerce/services/database.dart';
import 'package:e_commerce/theme/preset_styles.dart';
import 'package:e_commerce/widgets/header.dart';
import 'package:e_commerce/widgets/main_carousel.dart';
import 'package:e_commerce/widgets/main_drawer.dart';
import 'package:e_commerce/widgets/product_card.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

// Enums for product categories
enum Category { JEANS, SHOES, TSHIRTS, SHIRTS, SOCKS, BAGS, COATS }

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var productName = "shoes";
  var selectedCategory = "Jeans";
  var provider;

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    provider = Provider.of<Auth>(context);

    return Scaffold(
      drawer: MainDrawer(),
      appBar: buildAppBar(),
      body: ListView(
        children: [
          // A slider with pictures
          MainCarousel(),

          SizedBox(height: 25),
          MainHeader(name: "Categories"),

          // This is where user can select a product category
          Container(
            height: deviceSize.height * 0.25,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                buildCategory(deviceSize, "Jeans", "assets/catJeans.svg"),
                buildCategory(deviceSize, "T-shirts", "assets/catTshirt.svg"),
                buildCategory(deviceSize, "Shirts", "assets/catShirt.svg"),
                buildCategory(deviceSize, "Shoes", "assets/catShoes.svg"),
                buildCategory(deviceSize, "Coats", "assets/jacket.svg"),
                buildCategory(deviceSize, "Socks", "assets/socks.svg"),
                buildCategory(deviceSize, "Bags", "assets/bag.svg"),
              ],
            ),
          ),

          SizedBox(height: 15),
          MainHeader(name: "Best Selling"),

          // Fetch data from Firebase database
          StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection(productName).snapshots(),
            builder: (context, snapshot) {
              // If database gives error, show spinning circles
              if (!snapshot.hasData) {
                return SpinKitChasingDots(
                  color: Colors.red,
                );
              }

              // If fetching data from database is successful, show a grid list of products
              else {
                var products = snapshot.data.documents
                    .map((document) => Product.fromJson(document.data()))
                    .toList();
                print(products[0].brand);

                // Build a grid list of products with 2 columns
                return GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  children: products.map<Widget>((prod) {
                    return ProductCard(
                      product: prod,
                    );
                  }).toList(),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  // AppBar of the main page
  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.deepPurple,
      elevation: 0.0,
      centerTitle: true,
      title: Text("E-SHOP"),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: InkWell(
            child: SvgPicture.asset(
              "assets/log_out.svg",
              height: 30,
              width: 30,
              color: Colors.white,
            ),
            onTap: handleSignOut,
          ),
        )
      ],
    );
  }

  // when user clicks sign out icon in the appbar, log out and return to authentication page
  Future<void> handleSignOut() async {
    if (provider.isGoogleUser) {
      await provider.googleSignOut();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => AuthScreen()));
    } else {
      await provider.signOut();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => AuthScreen()));
    }
  }

  // When user taps a category, we switch the selectedCategory
  // The product variable also change accordingly and we fetch the
  // product from the database according to the selected category.
  Widget buildCategory(Size deviceSize, String name, String imgSrc) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedCategory = name;
        });
        if (name == "Jeans") {
          handleCategoryChange(Category.JEANS);
        } else if (name == "Shoes") {
          handleCategoryChange(Category.SHOES);
        } else if (name == "T-shirts") {
          handleCategoryChange(Category.TSHIRTS);
        } else if (name == "Shirts") {
          handleCategoryChange(Category.SHIRTS);
        } else if (name == "Socks") {
          handleCategoryChange(Category.SOCKS);
        } else if (name == "Coats") {
          handleCategoryChange(Category.COATS);
        } else if (name == "Bags") {
          handleCategoryChange(Category.BAGS);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Stack(
            children: [
              SvgPicture.asset(
                imgSrc,
                color: selectedCategory == name ? Colors.red : Colors.black,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(name),
              )
            ],
          ),
          width: deviceSize.width * 0.25,
          height: deviceSize.height * 0.25,
        ),
      ),
    );
  }

  // The product variable also change when selected category changes
  // We change the product variable to fetch data from the database according to the selected category.
  void handleCategoryChange(Category cat) {
    var product = "";
    if (cat == Category.JEANS) {
      product = "jeans";
    } else if (cat == Category.SHIRTS) {
      product = "shirts";
    } else if (cat == Category.TSHIRTS) {
      product = "tshirts";
    } else if (cat == Category.SHOES) {
      product = "shoes";
    } else if (cat == Category.SOCKS) {
      product = "socks";
    } else if (cat == Category.COATS) {
      product = "coats";
    } else if (cat == Category.BAGS) {
      product = "bags";
    }

    setState(() {
      productName = product;
    });
  }
}
