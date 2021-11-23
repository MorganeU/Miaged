import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
        .doc('xnO8BxdHn3KeLUaPKeeQ')
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
          title: const Text("Panier"),
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(99, 55, 44, 1),
        ),
        backgroundColor: const Color.fromRGBO(242, 229, 215, 1),
        body: FutureBuilder(
          future: getPanier(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List data = snapshot.data as List;
              return Column(children: [
                Expanded(
                  child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: data.length,
                      itemBuilder: (BuildContext _context, int i) {
                        return InkWell(
                            child: ListTile(
                                title: Column(
                          children: [
                            Text(data[i]['titre']),
                            Text(data[i]['taille']),
                            Text(data[i]['prix'].toString()),
                            Image.network(data[i]['img'],
                                height: 100, width: 100, fit: BoxFit.cover),
                            ElevatedButton(
                                onPressed: () => suppPanier(data[i].id),
                                child: const Text('Supprimer')),
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
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }

  void suppPanier(id) {
    // à changer pcq c'est en dur
    FirebaseFirestore.instance
        .collection('users')
        .doc('xnO8BxdHn3KeLUaPKeeQ')
        .update({
      'panier': FieldValue.arrayRemove([id])
    }).then((value) => {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('article supprimé du panier')))
            });
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
