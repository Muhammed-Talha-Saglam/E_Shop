import 'package:e_commerce/screens/auth_page.dart';
import 'package:e_commerce/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This prevents the landscape orientation
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    // We use "ChangeNotifierProvider" for our "state management"
    return ChangeNotifierProvider(
      create: (_) => Auth(),
      builder: (context, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'E - SHOP',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: AuthScreen(),
      ),
    );
  }
}
