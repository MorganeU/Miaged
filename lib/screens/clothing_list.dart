import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:miaged/screens/clothing_detail.dart';

// DEUXIEME PAGE : CLOTHING LIST -----------------------------------------------

class ClothingList extends StatefulWidget {
  const ClothingList({Key? key}) : super(key: key);
  @override
  _ClothingListState createState() => _ClothingListState();
}

class _ClothingListState extends State<ClothingList> {
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
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List data = snapshot.data as List;
              return ListView.builder(
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
