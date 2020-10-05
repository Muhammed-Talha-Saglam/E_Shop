import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

// This is where we handle the "state management" and user authentication
// We use Firebase as our backend server and user authentication

class Auth with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();

  User user;
  var userName = "";
  var useraddress = "";
  bool isSignIn = false;
  bool isNewUser = false;
  bool isGoogleUser = false;
  var googleIdToken = "";

  // we keep track of whether user is signed in or signed out,
  void toggleisSignIn() {
    isSignIn = !isSignIn;
    notifyListeners();
  }

  // If it is a new user, we change the UI so that user can create an account
  void toggleisNewUser() {
    isNewUser = !isNewUser;
    notifyListeners();
  }

  // If the user is using the app for the first time , we register them using firebase auth
  Future<bool> handleEmailSignUp(
      String email, String password, String name) async {
    try {
      var result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      user = result.user;
      isSignIn = true;

      // We store the user info to the database inside "users" collection
      await FirebaseFirestore.instance.collection("users").doc(user.uid).set(
        {"userId": user.uid, "name": name, "address": "", "photo": ""},
      );
      userName = name;
      useraddress = "";
      notifyListeners();
      return true;
    } catch (e) {
      // If user gets error while registering, we show the message inside the toast
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_LONG,
        textColor: Colors.white,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
      );
      return false;
    }
  }

  // If user has signed up before, they login with their email and password
  Future<bool> handleEmailSignIn(String email, String password) async {
    try {
      var result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = result.user;
      isSignIn = true;
      await getUserName();
      await getUserAdress();
      notifyListeners();
      return true;
    } catch (e) {
      // If user gets error while logging in, we show the message inside the toast
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_LONG,
        textColor: Colors.white,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
      );
      return false;
    }
  }

  // Handle user sign out
  Future<void> signOut() async {
    await auth.signOut();
    isSignIn = false;
    notifyListeners();
  }

  // User can log in with their Google account
  Future<bool> handleGoogleSignIn() async {
    var googleSingInAccount = await googleSignIn.signIn();
    var googleSignInAuth = await googleSingInAccount.authentication;
    var credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuth.idToken,
        accessToken: googleSignInAuth.accessToken);

    googleIdToken = credential.idToken;

    var result = await auth.signInWithCredential(credential);
    user = result.user;
    isSignIn = true;
    isGoogleUser = true;

    var addr = await getUserAdress();
    var nam = await getUserName();

    // We store the user info to the database inside "users" collection
    await FirebaseFirestore.instance
        .collection("users")
        .doc(credential.idToken)
        .set(
      {
        "userId": user.uid,
        "name": nam ?? user.displayName,
        "address": addr ?? "",
      },
    );

    await getUserName();
    await getUserAdress();
    notifyListeners();
    return true;
  }

  // Handle user sign out
  Future<void> googleSignOut() async {
    await auth.signOut().then((value) => {googleSignIn.signOut()});
    isSignIn = false;
    isGoogleUser = false;
    notifyListeners();
  }

  Future getUserName() async {
    var docId = isGoogleUser ? googleIdToken : user.uid;

    var ins =
        await FirebaseFirestore.instance.collection("users").doc(docId).get();
    var data = ins.data();

    if (data == null) {
      userName = "no name";
      notifyListeners();
      return "no name";
    } else {
      userName = data["name"];
      notifyListeners();
      return data["name"];
    }
  }

  Future updateUserName(String newName) async {
    var docId = isGoogleUser ? googleIdToken : user.uid;

    await FirebaseFirestore.instance
        .collection("users")
        .doc(docId)
        .update({"name": newName});
  }

  Future getUserAdress() async {
    var docId = isGoogleUser ? googleIdToken : user.uid;

    var ins =
        await FirebaseFirestore.instance.collection("users").doc(docId).get();
    var data = ins.data();

    // if such user doesn't exist, return null
    if (ins == null ||
        data == null ||
        data["address"] == null ||
        data["address"] == "") {
      notifyListeners();
      return null;
    } else {
      useraddress = data["address"];
      notifyListeners();
      return data["address"];
    }
  }

  Future updateUserAddress(String newAddress) async {
    var docId = isGoogleUser ? googleIdToken : user.uid;

    await FirebaseFirestore.instance
        .collection("users")
        .doc(docId)
        .update({"address": newAddress});
  }
}