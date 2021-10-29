import 'package:flutter/material.dart';

// login : test@gmail.com
// mdp : coucou

// PREMIERE PAGE : LOGIN PAGE --------------------------------------------------
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MIAGED'),
        centerTitle: true,
      ),
      body: const FonctionLogin(),
    );
  }
}

class FonctionLogin extends StatefulWidget {
  const FonctionLogin({Key? key}) : super(key: key);
  @override
  FonctionLoginState createState() {
    return FonctionLoginState();
  }
}

class FonctionLoginState extends State<FonctionLogin> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const TextField(
            decoration: InputDecoration(labelText: "Login"),
            keyboardType: TextInputType.emailAddress,
          ),
          const TextField(
            decoration: InputDecoration(labelText: "Mot de passe"),
            obscureText: true,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/home');
              },
              child: const Text('Se connecter'),
            ),
          ),
        ],
      ),
    );
  }
}
