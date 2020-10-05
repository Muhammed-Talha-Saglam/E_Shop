import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/screens/basket_page.dart';
import 'package:e_commerce/screens/profile_page.dart';
import 'package:e_commerce/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Auth>(context);

    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent,
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    child: SvgPicture.asset("assets/avatar.svg",
                        height: 75, width: 75),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(provider.userName),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(provider.user.email),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    child: Text(
                      provider.useraddress,
                      style: TextStyle(fontSize: 11),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ProfilePage())),
            leading: Icon(
              Icons.person,
              color: Colors.black,
            ),
            title: Text("My Profile"),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          Divider(height: 2, color: Colors.grey),
          ListTile(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => BasketPage())),
            leading: Icon(
              Icons.shopping_basket,
              color: Colors.black,
            ),
            title: Text("My Basket"),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          Divider(height: 2, color: Colors.grey),
          Spacer(),
          ListTile(
            onTap: () {
              showAboutDialog(
                applicationName: "E-SHOP",
                context: context,
                children: [
                  Text("This application is for demonstration purposes only."),
                ],
              );
            },
            title: Text(
              "About",
              style: TextStyle(color: Colors.purple),
            ),
          ),
          Container(height: 25),
        ],
      ),
    );
  }
}
