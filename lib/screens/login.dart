import 'package:flutter/material.dart';

// login : test@gmail.com
// mdp : coucou

// PREMIERE PAGE : LOGIN PAGE --------------------------------------------------
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('MIAGED'),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(127, 129, 205, 1),
      ),
      body: const FonctionLogin(),
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
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
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Wrap(spacing: 10, runSpacing: 30, children: const [
                Material(
                    elevation: 5.0,
                    shadowColor: Color.fromRGBO(235, 215, 193, 1),
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Login",
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(255, 197, 74, 1)),
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      keyboardType: TextInputType.emailAddress,
                    )),
                Material(
                    elevation: 5.0,
                    shadowColor: Color.fromRGBO(235, 215, 193, 1),
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Mot de passe",
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(255, 197, 74, 1)),
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      obscureText: true,
                    ))
              ])),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/home');
                },
                child: const Text('Se connecter'),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromRGBO(247, 173, 43, 1)),
                    elevation: MaterialStateProperty.all<double>(2),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.yellow.shade800),
                    )))),
          ),
        ],
      ),
    );
  }
}
