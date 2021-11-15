import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:miaged/screens/clothing_detail.dart';
import 'package:miaged/screens/home.dart';
import 'package:miaged/screens/login.dart';
// import 'package:miaged/screens/shopping_bag.dart';
// import 'package:miaged/screens/user_profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      // ROUTING
      initialRoute: '/login',
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => LoginPage(),
        '/home': (BuildContext context) => Home(),
        // '/detail': (BuildContext context) => ClothingDetail(),
        // '/bag': (BuildContext context) => ShoppingBag(),
        // '/profile': (BuildContext context) => UserProfile(),
      },
    );
  }
}
