import 'package:flutter/material.dart';
import 'package:miaged/screens/clothing_list.dart';
import 'package:miaged/screens/shopping_bag.dart';
import 'package:miaged/screens/user_profile.dart';

// DEUXIEME PAGE : CLOTHING LIST -----------------------------------------------

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const ClothingList(),
    const ShoppingBag(),
    const UserProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'acheter'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag), label: 'panier'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined), label: 'profil')
        ],
        backgroundColor: const Color.fromRGBO(0, 29, 102, 1),
        selectedItemColor: const Color.fromRGBO(255, 197, 74, 1),
        unselectedItemColor: const Color.fromRGBO(127, 129, 205, 1),
        elevation: 10,
        selectedLabelStyle:
            const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
      ),
      body: _widgetOptions[_selectedIndex],
    );
  }

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}









// class FonctionClothing extends StatefulWidget {
//   const FonctionClothing({Key? key}) : super(key: key);
//   @override
//   FonctionClothingState createState() {
//     return FonctionClothingState();
//   }
// }

// class FonctionClothingState extends State<FonctionClothing> {
//   final _formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     // Build a Form widget using the _formKey created above.
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           // Détails articles ----------------------------------
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 16.0),
//             child: ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pushNamed('/detail');
//               },
//               child: const Text('détails'),
//             ),
//           ),
//           // Profil de l'utilisateur ---------------------------
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 16.0),
//             child: ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pushNamed('/profile');
//               },
//               child: const Text('Profil'),
//             ),
//           ),
//           // Panier -------------------------------------------
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 16.0),
//             child: ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pushNamed('/bag');
//               },
//               child: const Text('Panier'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
