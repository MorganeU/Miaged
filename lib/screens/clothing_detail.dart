import 'package:flutter/material.dart';

// TROISIEME PAGE : CLOTHING DETAIL --------------------------------------------
class ClothingDetail extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Détail"),
      ),
      body: const Center(
        child: Text('liste'),
      ),
      backgroundColor: Colors.lightGreen[100],
    );
  }
}

class FonctionDetail extends StatefulWidget {
  const FonctionDetail({Key? key}) : super(key: key);
  @override
  FonctionDetailState createState() {
    return FonctionDetailState();
  }
}

class FonctionDetailState extends State<FonctionDetail> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        children: [],
      ),
    );
  }
}
