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
  Future<DocumentSnapshot<Map<String, dynamic>>> getUser() async {
    var user = await FirebaseFirestore.instance
        .collection('users')
        .doc('xnO8BxdHn3KeLUaPKeeQ')
        .get();
    return user;
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(99, 55, 44, 1),
      ),
      backgroundColor: const Color.fromRGBO(242, 229, 215, 1),
      body: SingleChildScrollView(
          child: FutureBuilder(
        future: getUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            DocumentSnapshot data = snapshot.data as DocumentSnapshot;
            UserInfo userinfo = UserInfo(
                data['lastname'],
                data['name'],
                data['email'],
                data['mdp'],
                data['birthday'],
                data['adr'],
                data['city'],
                data['postcode']);
            return Column(children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Nom"),
                initialValue: userinfo.lastname,
                onChanged: (value) {
                  userinfo.lastname = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Prenom"),
                initialValue: userinfo.name,
                onChanged: (value) {
                  userinfo.name = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Adresse email"),
                keyboardType: TextInputType.emailAddress,
                initialValue: userinfo.email,
                onChanged: (value) {
                  userinfo.email = value;
                },
                enabled: false,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Mot de passe"),
                obscureText: true,
                initialValue: userinfo.mdp,
                onChanged: (value) {
                  userinfo.mdp = value;
                },
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: "Date de naissance"),
                initialValue: userinfo.birthday,
                onChanged: (value) {
                  userinfo.birthday = value;
                },
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: "Adresse du domicile"),
                initialValue: userinfo.adr,
                onChanged: (value) {
                  userinfo.adr = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Ville"),
                initialValue: userinfo.city,
                onChanged: (value) {
                  userinfo.city = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Code postal"),
                initialValue: userinfo.postcode,
                onChanged: (value) {
                  userinfo.postcode = value;
                },
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Wrap(
                    runSpacing: 10,
                    direction: Axis.horizontal,
                    spacing: 10,
                    children: [
                      ElevatedButton(
                          onPressed: () => saveInfo(userinfo),
                          child: const Text('Enregistrer'),
                          style: ElevatedButton.styleFrom(
                              primary: const Color.fromRGBO(146, 182, 213, 1))),
                      ElevatedButton(
                          onPressed: logOut,
                          child: const Text('Déconnection'),
                          style: ElevatedButton.styleFrom(
                              primary: const Color.fromRGBO(245, 158, 112, 1))),
                    ],
                  )),
            ]);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      )),
    );
  }

  saveInfo(UserInfo userinfo) async {
    var user = await FirebaseFirestore.instance
        .collection('users')
        .doc('xnO8BxdHn3KeLUaPKeeQ')
        .update({
      'lastname': userinfo.lastname,
      'name': userinfo.name,
      'birthday': userinfo.birthday,
      'adr': userinfo.adr,
      'city': userinfo.city,
      'postcode': userinfo.postcode
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Profil mis à jour')));
  }

  logOut() {
    Navigator.pushReplacementNamed(context, '/login');
  }
}

class UserInfo {
  String lastname;
  String name;
  String email;
  String mdp;
  String birthday;
  String adr;
  String city;
  String postcode;

  UserInfo(this.lastname, this.name, this.email, this.mdp, this.birthday,
      this.adr, this.city, this.postcode);
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
