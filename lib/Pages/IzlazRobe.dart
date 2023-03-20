//unos kod artikla, search, precica, tolowercase
// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prodajaodjece/Pages/SplashIzlaz.dart';

import '../firebase_options.dart';

class IzlazRobe extends StatefulWidget {
  const IzlazRobe({Key? key}) : super(key: key);

  @override
  State<IzlazRobe> createState() => _IzlazRobeState();
}

class _IzlazRobeState extends State<IzlazRobe> {
  final kupacController = TextEditingController();
  final cijenaprodajnaController = TextEditingController();
  final searchController = TextEditingController();
  final markaController = TextEditingController();
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  List<String> searchResult = [];
  bool isItemSelected = false;
  void searchFromFirebase(String query) async {
    final result = await FirebaseFirestore.instance
        .collection('search')
        .where('string_id_array', arrayContains: query)
        .get();

    setState(() {
      searchResult = result.docs.map((e) => e.data()).cast<String>().toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
      ),
      body: Center(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Text('PRODAJA',
                    style: GoogleFonts.bebasNeue(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightGreen,
                    )),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 7.0, horizontal: 25.0),
              child: TextField(
                controller: kupacController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.lightGreen, width: 3.0),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  prefixIcon:
                      const Icon(Icons.person, color: Colors.lightGreen),
                  hintText: 'Kupac',
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Text('Odaberite artikal',
                    style: GoogleFonts.robotoSlab(
                      fontSize: 15,
                      color: Colors.lightGreen,
                    )),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, bottom: 10),

                /*    child: StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('ulaz').snapshots(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }
        if (!snapshot.hasData) {
            return DropdownButtonFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                    ),
                    prefixIcon: const Icon(Icons.shopping_cart,
                        color: Colors.lightGreen),
                ),
                iconDisabledColor: Colors.lightGreen,
                dropdownColor: Colors.lightGreen,
                items: const [],
                onChanged: null,
            );
        }
        return DropdownButtonFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                ),
                prefixIcon: const Icon(Icons.shopping_cart,
                    color: Colors.lightGreen),
            ),
            value: dropdownValue,
            iconDisabledColor: Colors.lightGreen,
            dropdownColor: Colors.lightGreen,
            items: snapshot.data!.docs.map((doc) {
                return DropdownMenuItem(
                    value: doc['artikal'],
                    child: Text(doc['artikal']),
                );
            }).toList(),
            onChanged: (value) {
                setState(() {
                    dropdownValue = value.toString();
                    artikalController.text = value.toString();
                });
            },
        );
    },
),*/

                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.lightGreen,
                        width: 3.0,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: Colors.lightGreen,
                    ),
                    hintText: 'Pretražite artikal',
                  ),

                  //logika
                  onChanged: (value) async {
                    setState(() {
                      if (value.length >= 1) {
                        // Update the search results based on the entered text
                        _filterArtikliByQuery(value).then((result) {
                          searchResult = result;
                        });
                      } else {
                        searchResult =
                            []; // Clear the search results when the user deletes characters
                      }
                    });
                  },
                ),
              ),
            ),
            // ...
            if (!isItemSelected && searchResult.isNotEmpty)
              SingleChildScrollView(
                child: SizedBox(
                  height: 300, // Replace with your desired height
                  child: ListView.builder(
                    itemCount: searchResult.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(searchResult[index]),
                        onTap: () {
                          // Perform an action when an item is selected
                          print(searchResult[index]);
                          searchController.text = searchResult[index];
                          setState(() {
                            isItemSelected = true;
                          });
                        },
                      );
                    },
                  ),
                ),
              ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 7.0, horizontal: 25.0),
              child: TextField(
                controller: markaController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.lightGreen, width: 3.0),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  prefixIcon: const Icon(
                    Icons.shopping_bag_rounded,
                    color: Colors.lightGreen,
                  ),
                  hintText: 'Marka',
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 7.0, horizontal: 25.0),
              child: TextField(
                controller: cijenaprodajnaController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.lightGreen, width: 3.0),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  prefixIcon: const Icon(
                    Icons.attach_money_rounded,
                    color: Colors.lightGreen,
                  ),
                  hintText: 'Unesite cijenu',
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          prodajRobu(
            searchController.text.trim(),
            markaController.text.trim(),
            kupacController.text.trim(),
            int.parse(cijenaprodajnaController.text.trim()),
          );
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SplashIzlaz()));
        },
        label: const Text('Kupi'),
        icon: const Icon(Icons.attach_money_rounded),
        backgroundColor: Colors.lightGreen,
      ),
    );
  }

  Future prodajRobu(
      String artikal, String marka, String kupac, int cijena) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await FirebaseFirestore.instance.collection('izlaz').add({
      'artikal': artikal,
      'marka': marka,
      'kupac': kupac,
      'cijena': cijena,
    });
  }

  Future<List<String>> _filterArtikliByQuery(String query) async {
    // Fetch data from Firebase
    final izlaz = await FirebaseFirestore.instance.collection('izlaz').get();

    // Extract artikal values from the fetched data
    final artikli = izlaz.docs.map((doc) => doc['artikal'] as String).toList();

    // Group the artikli by their name and count the number of occurrences
    final artikalCounts = <String, int>{};
    for (final artikal in artikli) {
      artikalCounts[artikal] = (artikalCounts[artikal] ?? 0) + 1;
    }

    // Filter the data source based on the entered text, but only include
    // one instance of each artikal name
    final filteredArtikli = artikalCounts.keys
        .where((artikal) =>
            artikal.toLowerCase().contains(query.trim().toLowerCase()))
        .toList();

    return filteredArtikli;
  }
}
