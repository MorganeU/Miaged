import 'package:flutter/material.dart';

// CINQUIEME PAGE : USER PROFILE -----------------------------------------------
class UserProfile extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
      ),
      body: const Center(
        child: Text('liste'),
      ),
      backgroundColor: Colors.lightGreen[100],
    );
  }
}