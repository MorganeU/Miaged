import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miaged/globals.dart' as globals;

// login : test@gmail.com
// mdp : coucou

// PREMIERE PAGE : LOGIN PAGE --------------------------------------------------
class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("MIAGED", style: GoogleFonts.aclonica()),
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(127, 129, 205, 1),
          elevation: 7,
          titleTextStyle: const TextStyle(
            fontSize: 27,
          )),
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
  String _login = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Wrap(spacing: 10, runSpacing: 30, children: [
                Material(
                    shadowColor: const Color.fromRGBO(235, 215, 193, 1),
                    color: Colors.transparent,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Login",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(255, 197, 74, 1)),
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(255, 197, 74, 1)),
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        fillColor: Colors.white,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == '') {
                          return 'Veuillez préciser votre adresse email';
                        } else {
                          _login = value.toString();
                        }
                      },
                    )),
                Material(
                    shadowColor: const Color.fromRGBO(235, 215, 193, 1),
                    color: Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Mot de passe",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(255, 197, 74, 1)),
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(255, 197, 74, 1)),
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == '') {
                          return 'Veuillez préciser votre mot de passe';
                        } else {
                          _password = value.toString();
                        }
                      },
                    ))
              ])),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: ElevatedButton(
                onPressed: () {
                  // Navigator.of(context).pushNamed('/home');
                  authentification();
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

  void authentification() async {
    bool isFilled = _formKey.currentState!.validate();
    if (!isFilled) return;
    try {
      UserCredential userCred = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _login, password: _password);
      globals.user = userCred.user!;
      Navigator.of(context).pushNamed('/home');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Une erreur est survenue')));
    }
  }
}
