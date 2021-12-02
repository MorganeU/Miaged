import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:miaged/screens/home.dart';
import 'package:miaged/screens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
      home: const LoginPage(),
      // ROUTING
      initialRoute: '/login',
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => const LoginPage(),
        '/home': (BuildContext context) => const Home(),
        // '/detail': (BuildContext context) => ClothingDetail(),
        // '/bag': (BuildContext context) => ShoppingBag(),
        // '/profile': (BuildContext context) => UserProfile(),
      },
    );
  }
}
