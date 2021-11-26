import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:miaged/globals.dart' as globals;

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
    var list_id = user['panier'];

    var items = await FirebaseFirestore.instance
        .collection('clothes')
        .where(FieldPath.documentId, whereIn: list_id)
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
                            child: ListTile(
                                title: Row(
                          children: [
                            Image.network(data[i]['img'],
                                height: 100, width: 100, fit: BoxFit.cover),
                            Column(children: <Widget>[
                              Text(data[i]['titre']),
                              Text("Taille : " + data[i]['taille']),
                              Text("Prix : " +
                                  data[i]['prix'].toString() +
                                  " €"),
                              ElevatedButton.icon(
                                  onPressed: () => suppPanier(data[i].id),
                                  icon: const Icon(Icons.delete),
                                  label: const Text(''),
                                  // const Text('Supprimer'),
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
                                      ))))
                            ])
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
    articles.forEach((element) {
      total += element['prix'];
    });
    return 'Total : $total €';
  }
}


// class ShoppingBag extends StatelessWidget {
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Panier"),
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
