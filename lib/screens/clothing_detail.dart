import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:miaged/globals.dart' as globals;

// TROISIEME PAGE : CLOTHING DETAIL --------------------------------------------

class ClothingDetail extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final clothe;
  const ClothingDetail({Key? key, required this.clothe}) : super(key: key);
  @override
  _ClothingDetailState createState() => _ClothingDetailState();
}

class _ClothingDetailState extends State<ClothingDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        body: CustomScrollView(slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            floating: true,
            snap: false,
            expandedHeight: 300.0,
            backgroundColor: const Color.fromRGBO(127, 129, 205, 1),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(widget.clothe['titre'],
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                  )),
              background: Image.network(widget.clothe['img'],
                  height: 100, width: 100, fit: BoxFit.cover),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
                height: 10, color: const Color.fromRGBO(127, 129, 205, 1)),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return SizedBox(
                  child: Center(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(top: 20, left: 15),
                              child:
                                  Text("Vendeur : " + widget.clothe['vendeur'],
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ))),
                          Padding(
                              padding: const EdgeInsets.only(top: 20, left: 15),
                              child: Text("Marque : " + widget.clothe['marque'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ))),
                          Padding(
                              padding: const EdgeInsets.only(top: 20, left: 15),
                              child: Text("Taille : " + widget.clothe['taille'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ))),
                          Padding(
                              padding: const EdgeInsets.only(top: 20, left: 15),
                              child: Text(
                                  "Prix : " +
                                      widget.clothe['prix'].toString() +
                                      " €",
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ))),
                          const Padding(
                            padding: EdgeInsets.only(top: 20, left: 15),
                            child: Text(
                              "Description : ",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, left: 15, right: 15),
                              child: Text(widget.clothe['description'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ))),
                          Padding(
                              padding: const EdgeInsets.only(
                                  top: 25, left: 90, bottom: 25),
                              child: ElevatedButton(
                                  onPressed: ajoutPanier,
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 11),
                                    child: Text('Ajouter au panier',
                                        style: TextStyle(
                                          fontSize: 18,
                                        )),
                                  ),
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
                                      ))))),
                        ]),
                  ),
                );
              },
              childCount: 1,
            ),
          ),
        ]));
  }

  ajoutPanier() {
    // à changer pcq c'est en dur
    FirebaseFirestore.instance
        .collection('users')
        .doc(globals.user?.uid)
        .update({
      'panier': FieldValue.arrayUnion([widget.clothe.id])
    }).then((value) => {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('article ajouté au panier')))
            });
  }
}
