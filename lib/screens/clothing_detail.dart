import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:miaged/globals.dart' as globals;

// TROISIEME PAGE : CLOTHING DETAIL --------------------------------------------

class ClothingDetail extends StatefulWidget {
  final clothe;
  const ClothingDetail({Key? key, required this.clothe}) : super(key: key);
  @override
  _ClothingDetailState createState() => _ClothingDetailState();
}

class _ClothingDetailState extends State<ClothingDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Détail"),
        backgroundColor: const Color.fromRGBO(127, 129, 205, 1),
      ),
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: Center(
        child: Column(children: [
          Text(widget.clothe['titre']),
          Text("Taille : " + widget.clothe['taille']),
          Text("Marque : " + widget.clothe['marque']),
          Text("Prix : " + widget.clothe['prix'].toString() + " €"),
          Image.network(widget.clothe['img'],
              height: 100, width: 100, fit: BoxFit.cover),
          ElevatedButton(
              onPressed: ajoutPanier,
              child: const Text('Ajouter au panier'),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromRGBO(247, 173, 43, 1)),
                  elevation: MaterialStateProperty.all<double>(2),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.yellow.shade800),
                  )))),
        ]),
      ),
    );
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
                  SnackBar(content: Text('article ajouté au panier')))
            });
  }
}


// class ClothingDetail extends StatelessWidget {
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Détail"),
//       ),
//       body: const Center(
//         child: Text('liste'),
//       ),
//       backgroundColor: Colors.lightGreen[100],
//     );
//   }
// }

// class FonctionDetail extends StatefulWidget {
//   const FonctionDetail({Key? key}) : super(key: key);
//   @override
//   FonctionDetailState createState() {
//     return FonctionDetailState();
//   }
// }

// class FonctionDetailState extends State<FonctionDetail> {
//   final _formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     // Build a Form widget using the _formKey created above.
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [],
//       ),
//     );
//   }
// }
