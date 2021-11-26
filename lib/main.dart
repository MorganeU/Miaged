import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:miaged/screens/home.dart';
import 'package:miaged/screens/login.dart';

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
      theme: ThemeData(
          colorScheme: const ColorScheme.light(
            primary: Color.fromRGBO(255, 197, 74, 1),
          ),
          errorColor: const Color.fromRGBO(247, 87, 42, 1)),
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


// https://api.flutter.dev/flutter/widgets/CustomScrollView-class.html