import 'package:flutter/material.dart';

// QUATRIEME PAGE : SHOPPING BAG -----------------------------------------------
class ShoppingBag extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Panier"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: const Center(
        child: Text('liste'),
      ),
      backgroundColor: Colors.lightGreen[100],
    );
  }
}
