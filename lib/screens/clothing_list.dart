import 'package:flutter/material.dart';

// DEUXIEME PAGE : CLOTHING LIST -----------------------------------------------
class ClothingList extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste de vêtements"),
      ),
      body: FonctionClothing(),
    );
  }
}

class FonctionClothing extends StatefulWidget {
  const FonctionClothing({Key? key}) : super(key: key);
  @override
  FonctionClothingState createState() {
    return FonctionClothingState();
  }
}

class FonctionClothingState extends State<FonctionClothing> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Détails articles ----------------------------------
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/detail');
              },
              child: const Text('détails'),
            ),
          ),
          // Profil de l'utilisateur ---------------------------
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/profile');
              },
              child: const Text('Profil'),
            ),
          ),
          // Panier -------------------------------------------
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/bag');
              },
              child: const Text('Panier'),
            ),
          ),
        ],
      ),
    );
  }
}