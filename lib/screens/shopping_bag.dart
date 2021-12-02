import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:miaged/globals.dart' as globals;

import 'clothing_detail.dart';

// QUATRIEME PAGE : SHOPPING BAG -----------------------------------------------

class ShoppingBag extends StatefulWidget {
  const ShoppingBag({Key? key}) : super(key: key);
  @override
  _ShoppingBagState createState() => _ShoppingBagState();
}

class _ShoppingBagState extends State<ShoppingBag> {
  // Recuperer le panier
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getPanier() async {
    var user = await FirebaseFirestore.instance
        .collection('users')
        .doc(globals.user?.uid)
        .get();
    var listId = user['panier'];

    var items = await FirebaseFirestore.instance
        .collection('clothes')
        .where(FieldPath.documentId, whereIn: listId)
        .get();

    return items.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("MIAGED"),
            automaticallyImplyLeading: false,
            centerTitle: true,
            backgroundColor: const Color.fromRGBO(127, 129, 205, 1),
            elevation: 7,
            titleTextStyle: const TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.w600,
            )),
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        body: FutureBuilder(
          future: getPanier(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              List data = [];
              if (snapshot.data != null) {
                data = snapshot.data as List;
              }
              return Column(children: [
                Expanded(
                  child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: data.length,
                      itemBuilder: (BuildContext _context, int i) {
                        return InkWell(
                            onTap: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ClothingDetail(clothe: data[i])))
                                },
                            child: ListTile(
                                title: Row(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Image.network(data[i]['img'],
                                        height: 70,
                                        width: 70,
                                        fit: BoxFit.cover)),
                                Expanded(
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 30),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10),
                                                  child: Text(
                                                    data[i]['titre'],
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    textAlign: TextAlign.left,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  )),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 4),
                                                  child: Text(
                                                    "Taille : " +
                                                        data[i]['taille'],
                                                    style: const TextStyle(
                                                        fontSize: 13),
                                                    textAlign: TextAlign.right,
                                                  )),
                                              Text(
                                                "Prix : " +
                                                    data[i]['prix'].toString() +
                                                    " €",
                                                style: const TextStyle(
                                                    fontSize: 13),
                                                textAlign: TextAlign.right,
                                              ),
                                            ]))),
                                Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: IconButton(
                                      onPressed: () => suppPanier(data[i].id),
                                      icon: const Icon(Icons.delete),
                                      splashRadius: 20,
                                      splashColor: const Color.fromRGBO(
                                          216, 216, 216, 1),
                                      color:
                                          const Color.fromRGBO(247, 87, 42, 1),
                                    ))
                              ],
                            )));
                      }),
                ),
                Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      getTotalPrix(data),
                      style: const TextStyle(fontSize: 20),
                    ))
              ]);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }

  void suppPanier(id) async {
    // à changer pcq c'est en dur
    await FirebaseFirestore.instance
        .collection('users')
        .doc(globals.user?.uid)
        .update({
      'panier': FieldValue.arrayRemove([id])
    });
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('article supprimé du panier')));
    setState(() {});
  }

  String getTotalPrix(List articles) {
    double total = 0;
    for (var element in articles) {
      total += element['prix'];
    }
    return 'Total : $total €';
  }
}
