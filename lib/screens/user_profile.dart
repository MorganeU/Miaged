import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miaged/globals.dart' as globals;

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
        .doc(globals.user?.uid)
        .get();
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: Text("MIAGED", style: GoogleFonts.aclonica()),
              automaticallyImplyLeading: false,
              centerTitle: true,
              backgroundColor: const Color.fromRGBO(127, 129, 205, 1),
              elevation: 7,
              titleTextStyle: const TextStyle(
                fontSize: 27,
              ),
              bottom: const TabBar(
                tabs: [
                  Tab(text: 'Identifiants'),
                  Tab(text: 'Informations'),
                ],
                indicatorColor: Color.fromRGBO(255, 197, 74, 1),
              ),
            ),
            backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
            body: TabBarView(children: [
              SingleChildScrollView(
                  child: FutureBuilder(
                future: getUser(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    DocumentSnapshot data = snapshot.data as DocumentSnapshot;
                    UserInfo userinfo = UserInfo(
                        data['lastname'],
                        data['name'],
                        globals.user?.email ?? '',
                        '',
                        data['birthday'],
                        data['adr'],
                        data['city'],
                        data['postcode']);
                    return Column(children: [
                      Padding(
                          padding: const EdgeInsets.only(
                              right: 20, left: 20, bottom: 30, top: 15),
                          child: Wrap(spacing: 10, runSpacing: 30, children: [
                            const Text(
                              'Identifiants de connection :',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            Material(
                                elevation: 2.0,
                                shadowColor:
                                    const Color.fromRGBO(235, 215, 193, 1),
                                color: Colors.transparent,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30.0)),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                      labelText: "Adresse email",
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(),
                                      disabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  216, 216, 216, 1)),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30.0)))),
                                  initialValue: userinfo.email,
                                  onChanged: (value) {
                                    userinfo.email = value;
                                  },
                                  enabled: false,
                                )),
                            Material(
                                elevation: 2.0,
                                shadowColor:
                                    const Color.fromRGBO(235, 215, 193, 1),
                                color: Colors.transparent,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30.0)),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: "Entrer un nouveau mot de passe",
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromRGBO(
                                                255, 197, 74, 1)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30.0))),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(255, 197, 74, 1),
                                          width: 2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.0)),
                                    ),
                                  ),
                                  initialValue: userinfo.mdp,
                                  onChanged: (value) {
                                    userinfo.mdp = value;
                                  },
                                  obscureText: true,
                                )),
                          ])),
                      Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Wrap(
                            direction: Axis.horizontal,
                            spacing: 14,
                            children: [
                              ElevatedButton(
                                  onPressed: () => saveInfo(userinfo),
                                  child: const Text('Enregistrer'),
                                  autofocus: true,
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              const Color.fromRGBO(
                                                  247, 173, 43, 1)),
                                      elevation:
                                          MaterialStateProperty.all<double>(2),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side: BorderSide(
                                            color: Colors.yellow.shade800),
                                      )))),
                              ElevatedButton(
                                  onPressed: logOut,
                                  child: const Text('D??connection'),
                                  autofocus: true,
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              const Color.fromRGBO(
                                                  247, 87, 42, 1)),
                                      elevation:
                                          MaterialStateProperty.all<double>(2),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side:
                                            const BorderSide(color: Colors.red),
                                      )))),
                            ],
                          )),
                    ]);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              )),
              SingleChildScrollView(
                  child: FutureBuilder(
                future: getUser(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    DocumentSnapshot data = snapshot.data as DocumentSnapshot;
                    UserInfo userinfo = UserInfo(
                        data['lastname'],
                        data['name'],
                        globals.user?.email ?? '',
                        '',
                        data['birthday'],
                        data['adr'],
                        data['city'],
                        data['postcode']);
                    return Column(children: [
                      Padding(
                          padding: const EdgeInsets.only(
                              right: 20, left: 20, bottom: 10, top: 15),
                          child: Wrap(spacing: 10, runSpacing: 20, children: [
                            const Text('Informations du compte :',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500)),
                            Material(
                                elevation: 2.0,
                                shadowColor:
                                    const Color.fromRGBO(235, 215, 193, 1),
                                color: Colors.transparent,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30.0)),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: "Nom",
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromRGBO(
                                                255, 197, 74, 1)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30.0))),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(255, 197, 74, 1),
                                          width: 2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.0)),
                                    ),
                                  ),
                                  initialValue: userinfo.lastname,
                                  onChanged: (value) {
                                    userinfo.lastname = value;
                                  },
                                )),
                            Material(
                                elevation: 2.0,
                                shadowColor:
                                    const Color.fromRGBO(235, 215, 193, 1),
                                color: Colors.transparent,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30.0)),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: "Pr??nom",
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromRGBO(
                                                255, 197, 74, 1)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30.0))),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(255, 197, 74, 1),
                                          width: 2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.0)),
                                    ),
                                  ),
                                  initialValue: userinfo.name,
                                  onChanged: (value) {
                                    userinfo.name = value;
                                  },
                                )),
                            Material(
                                elevation: 2.0,
                                shadowColor:
                                    const Color.fromRGBO(235, 215, 193, 1),
                                color: Colors.transparent,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30.0)),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: "Date de naissance",
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromRGBO(
                                                255, 197, 74, 1)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30.0))),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(255, 197, 74, 1),
                                          width: 2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.0)),
                                    ),
                                  ),
                                  initialValue: userinfo.birthday,
                                  onChanged: (value) {
                                    userinfo.birthday = value;
                                  },
                                )),
                            Material(
                                elevation: 2.0,
                                shadowColor:
                                    const Color.fromRGBO(235, 215, 193, 1),
                                color: Colors.transparent,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30.0)),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: "Adresse du domicile",
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromRGBO(
                                                255, 197, 74, 1)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30.0))),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(255, 197, 74, 1),
                                          width: 2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.0)),
                                    ),
                                  ),
                                  initialValue: userinfo.adr,
                                  onChanged: (value) {
                                    userinfo.adr = value;
                                  },
                                )),
                            Material(
                                elevation: 2.0,
                                shadowColor:
                                    const Color.fromRGBO(235, 215, 193, 1),
                                color: Colors.transparent,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30.0)),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: "Ville",
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromRGBO(
                                                255, 197, 74, 1)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30.0))),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(255, 197, 74, 1),
                                          width: 2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.0)),
                                    ),
                                  ),
                                  initialValue: userinfo.city,
                                  onChanged: (value) {
                                    userinfo.city = value;
                                  },
                                )),
                            Material(
                                elevation: 2.0,
                                shadowColor:
                                    const Color.fromRGBO(235, 215, 193, 1),
                                color: Colors.transparent,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30.0)),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: "Code postal",
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromRGBO(
                                                255, 197, 74, 1)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30.0))),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(255, 197, 74, 1),
                                          width: 2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.0)),
                                    ),
                                  ),
                                  initialValue: userinfo.postcode,
                                  onChanged: (value) {
                                    userinfo.postcode = value;
                                  },
                                )),
                          ])),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: ElevatedButton(
                            onPressed: () => saveInfo(userinfo),
                            child: const Text('Enregistrer'),
                            autofocus: true,
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color.fromRGBO(247, 173, 43, 1)),
                                elevation: MaterialStateProperty.all<double>(2),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side:
                                      BorderSide(color: Colors.yellow.shade800),
                                )))),
                      ),
                    ]);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              )),
            ])));
  }

  saveInfo(UserInfo userinfo) async {
    // ignore: unused_local_variable
    var user = await FirebaseFirestore.instance
        .collection('users')
        .doc(globals.user?.uid)
        .update({
      'lastname': userinfo.lastname,
      'name': userinfo.name,
      'birthday': userinfo.birthday,
      'adr': userinfo.adr,
      'city': userinfo.city,
      'postcode': userinfo.postcode
    });
    if (userinfo.mdp != '') {
      await globals.user?.updatePassword(userinfo.mdp);
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Profil mis ?? jour')));
  }

  logOut() {
    FirebaseAuth.instance.signOut();
    globals.user = null;
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
