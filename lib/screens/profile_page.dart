import 'package:e_commerce/services/auth.dart';
import 'package:e_commerce/theme/preset_styles.dart';
import 'package:e_commerce/widgets/save_button.dart';
import 'package:e_commerce/widgets/text_form_field_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var formKey = GlobalKey<FormState>();

  var name = "";
  var address = "";

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Auth>(context);
    var deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_outlined,
                    color: Colors.deepPurple,
                    size: 30,
                  ),
                  onPressed: () => Navigator.of(context).pop()),
            ),
            SizedBox(height: 20),
            Text(
              "Update Your Profile",
              style: headerTextStyle,
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  buildFormHeader("Name"),
                  TextFormFieldWrappers(
                    child: TextFormField(
                      initialValue: provider.userName,
                      validator: (value) {
                        if (value.length < 3) {
                          return "User name must be at least 3 character long";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        name = value;
                      },
                      keyboardType: TextInputType.name,
                      decoration: defaultInputDecoration(
                          "assets/user.svg", "User Name"),
                    ),
                  ),
                  buildFormHeader("Address"),
                  TextFormFieldWrappers(
                    child: TextFormField(
                      initialValue: provider.useraddress,
                      validator: (value) {
                        if (value.length < 10) {
                          return "User address must be at least 10 character long";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        address = value;
                      },
                      keyboardType: TextInputType.streetAddress,
                      decoration: defaultInputDecoration(
                          "assets/map.svg", "User Address"),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              child: SaveButton(),
              onTap: () async {
                if (formKey.currentState.validate()) {
                  await provider.updateUserName(name);
                  await provider.updateUserAddress(address);
                  await provider.getUserName();
                  await provider.getUserAdress();
                  showToast("Your profile is updated!");
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFormHeader(String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Align(
        child: Text(
          name,
          style: headerTextStyle.copyWith(color: Colors.red, fontSize: 15),
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  void showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      textColor: Colors.white,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
    );
  }
}
