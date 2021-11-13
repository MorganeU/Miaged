import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// DEUXIEME PAGE : CLOTHING LIST -----------------------------------------------

class ClothingList extends StatefulWidget {
  const ClothingList({Key? key}) : super(key: key);

  @override
  _ClothingListState createState() => _ClothingListState();
}

class _ClothingListState extends State<ClothingList> {
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> GetData() async {
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
          title: const Text("Liste de vêtements"),
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: GetData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List data = snapshot.data as List;
              return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: data.length,
                  itemBuilder: (BuildContext _context, int i) {
                    return InkWell(
                        onTap: () => {},
                        child: ListTile(
                            title: Column(
                          children: [
                            Text(data[i]['titre']),
                            Text(data[i]['taille']),
                            Text(data[i]['prix'].toString()),
                            Image.network(data[i]['img'],
                                height: 100, width: 100, fit: BoxFit.cover)
                          ],
                        )));
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
