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
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getData(
      String categorie) async {
    QuerySnapshot<Map<String, dynamic>> res =
        await FirebaseFirestore.instance.collection('clothes').get();
    var clothes = res.docs;
    List<QueryDocumentSnapshot<Map<String, dynamic>>> filteredClothes = [];
    // ignore: avoid_function_literals_in_foreach_calls
    clothes.forEach((clothe) => {
          if (categorie == 'Tous' || categorie == clothe['categorie'])
            {filteredClothes.add(clothe)}
        });
    return filteredClothes;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
            appBar: AppBar(
              title: const Text("MIAGED"),
              automaticallyImplyLeading: false,
              centerTitle: true,
              backgroundColor: const Color.fromRGBO(127, 129, 205, 1),
              elevation: 7,
              titleTextStyle: const TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.w600,
              ),
              bottom: const TabBar(
                tabs: [
                  Tab(text: 'Tous'),
                  Tab(text: 'Hauts'),
                  Tab(text: 'Bas'),
                  Tab(text: 'Accessoires'),
                ],
                indicatorColor: Color.fromRGBO(255, 197, 74, 1),
                isScrollable: true,
              ),
            ),
            backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
            body: TabBarView(children: [
              filter('Tous'),
              filter('tshirts'),
              filter('pantalons'),
              filter('accessoires'),
            ])));
  }

  filter(categorie) {
    return FutureBuilder(
      future: getData(categorie),
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
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
