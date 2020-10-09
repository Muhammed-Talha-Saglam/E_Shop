import 'package:e_commerce/screens/main_page.dart';
import 'package:e_commerce/services/auth.dart';
import 'package:e_commerce/theme/preset_styles.dart';
import 'package:e_commerce/widgets/auth_page_header.dart';
import 'package:e_commerce/widgets/auth_page_new_user.dart';
import 'package:e_commerce/widgets/google_signIn_button.dart';
import 'package:e_commerce/widgets/sign_in_button.dart';
import 'package:e_commerce/widgets/text_form_field_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var formKey = GlobalKey<FormState>();

  bool isLoading = false;
  String email = "";
  String password = "";
  String userName = "";

  // We check if the user enters a correct email address
  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  // When user clicks sign in button, we validate the form fields.
  // If the form fields are correct, navigate to main page
  // If it is a new user, we register to firebase
  Future<void> handleSignIn(context, provider) async {
    if (formKey.currentState.validate()) {
      if (provider.isNewUser) {
        setState(() {
          isLoading = true;
        });
        var isSuccesful =
            await provider.handleEmailSignUp(email, password, userName);
        if (!isSuccesful) {
          showToast("Error Cannot Sign Up");
          setState(() {
            isLoading = false;
          });
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MainPage()));
        }
      } else {
        setState(() {
          isLoading = true;
        });
        var isSuccesful = await provider.handleEmailSignIn(email, password);
        if (!isSuccesful) {
          showToast("Error Cannot Sign In");
          setState(() {
            isLoading = false;
          });
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MainPage()));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Auth>(context);
    var deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.indigo,
      // We show spinning circles, while the page is loading.
      body: isLoading
          ? Center(
              child: SpinKitFadingCircle(
                color: Colors.white,
              ),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: deviceSize.height * 0.15),

                  // Page Header
                  AuthPageheader(),

                  SizedBox(height: deviceSize.height * 0.05),

                  // Email and password form
                  buildForm(provider),

                  // User clicks this button to log in
                  InkWell(
                    child: SignInButton(),
                    onTap: () async {
                      await handleSignIn(context, provider);
                    },
                  ),

                  // Switch auth page for an existing user or new user
                  NewUser(),

                  // User can sign in with their Google account
                  FlatButton(
                    color: Colors.white,
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      var r = await provider.handleGoogleSignIn();
                      if (r) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainPage()));
                      } else {
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                    child: GoogleSignInButton(),
                  ),
                ],
              ),
            ),
    );
  }

  // This create form fields for email and password
  Form buildForm(Auth provider) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormFieldWrappers(
            child: TextFormField(
              validator: (value) {
                if (!validateEmail(value)) {
                  return "Invalid Email";
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
              keyboardType: TextInputType.emailAddress,
              decoration: defaultInputDecoration("assets/email.svg", "Email"),
            ),
          ),
          TextFormFieldWrappers(
            child: TextFormField(
              validator: (value) {
                if (value.length < 6) {
                  return "Password must be at least 8 character long";
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: defaultInputDecoration("assets/key.svg", "Password"),
            ),
          ),
          if (provider.isNewUser)
            TextFormFieldWrappers(
              child: TextFormField(
                validator: (value) {
                  if (value.length < 3) {
                    return "User name must be at least 3 character long";
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    userName = value;
                  });
                },
                keyboardType: TextInputType.name,
                decoration:
                    defaultInputDecoration("assets/user.svg", "Username"),
              ),
            ),
        ],
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
