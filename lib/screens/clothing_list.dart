import 'package:flutter/material.dart';

// DEUXIEME PAGE : CLOTHING LIST -----------------------------------------------

class ClothingList extends StatefulWidget {
  const ClothingList({Key? key}) : super(key: key);

  @override
  _ClothingListState createState() => _ClothingListState();
}

class _ClothingListState extends State<ClothingList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste de vêtements"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Text('kikou'),
    );
  }
}
