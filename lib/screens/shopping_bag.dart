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
    QuerySnapshot<Map<String, dynamic>> res =
        await FirebaseFirestore.instance.collection('users').get();
    var users = res.docs;
    print('panier : ');
    users.forEach(
        (user) => {print(user['name'] + ' : '), print(user['panier'])});
    return users;
  }

  // Recuperer les habits
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getData() async {
    QuerySnapshot<Map<String, dynamic>> res =
        await FirebaseFirestore.instance.collection('clothes').get();
    var clothes = res.docs;
    print('clothes : ');
    clothes.forEach((clothe) => {print(clothe['titre'])});
    return clothes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Panier"),
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: getPanier(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List data = snapshot.data as List;
              return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: data.length,
                  itemBuilder: (BuildContext _context, int i) {
                    return InkWell(
                        child: ListTile(
                            title: Column(
                      children: [
                        ElevatedButton(
                            onPressed: suppPanier,
                            child: const Text('Supprimer'))
                      ],
                    )));
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }

  void suppPanier() {
    // à changer pcq c'est en dur
    //   FirebaseFirestore.instance
    //       .collection('users')
    //       .doc('xnO8BxdHn3KeLUaPKeeQ')
    //       .delete({
    //     'panier': FieldValue.arrayUnion([widget.clothe.id])
    //   }).then((value) => {
    //             ScaffoldMessenger.of(context).showSnackBar(
    //                 SnackBar(content: Text('article supprimé du panier')))
    //           });
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
