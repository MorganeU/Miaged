import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// CINQUIEME PAGE : USER PROFILE -----------------------------------------------

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  // Recuperer les infos utilisateur
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getPanier() async {
    QuerySnapshot<Map<String, dynamic>> res =
        await FirebaseFirestore.instance.collection('users').get();
    var users = res.docs;
    print('Utilisateurs : ');
    users.forEach((user) => {print(user['name'])});
    return users;
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Profil"),
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const TextField(
                  decoration: InputDecoration(labelText: "Nom"),
                ),
                const TextField(
                  decoration: InputDecoration(labelText: "Prenom"),
                ),
                const TextField(
                  decoration: InputDecoration(labelText: "Adresse email"),
                  keyboardType: TextInputType.emailAddress,
                ),
                const TextField(
                  decoration: InputDecoration(labelText: "Mot de passe"),
                  obscureText: true,
                ),
                const TextField(
                  decoration: InputDecoration(labelText: "Date de naissance"),
                ),
                const TextField(
                  decoration: InputDecoration(labelText: "Adresse du domicile"),
                ),
                const TextField(
                  decoration: InputDecoration(labelText: "Ville"),
                ),
                const TextField(
                  decoration: InputDecoration(labelText: "Code postal"),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Enregistrer les informations'),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}



// class UserProfile extends StatelessWidget {
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Profil"),
//         automaticallyImplyLeading: false,
//         centerTitle: true,
//       ),
//       body: const Center(
//         child: Text('liste'),
//       ),
//       backgroundColor: Colors.lightGreen[100],
//     );
//   }
// }
