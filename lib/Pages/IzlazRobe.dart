//login
// ignore_for_file: file_names, depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:depoware/Pages/SplashIzlaz.dart';

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

  List<String> kupacResult = [];
  bool isKupacSelected = false;
  void searchFromIzlaz(String query) async {
    final result = await FirebaseFirestore.instance
        .collection('izlaz')
        .where('kupac', isEqualTo: query)
        .get();

    setState(() {
      kupacResult = result.docs.map((e) => e.data()).cast<String>().toList();
    });
  }

  List<String> markaResult = [];
  bool isMarkaSelected = false;
  void searchMarka(String query) async {
    final result = await FirebaseFirestore.instance
        .collection('izlaz')
        .where('marka', isEqualTo: query)
        .get();

    setState(() {
      markaResult = result.docs.map((e) => e.data()).cast<String>().toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text('PRODAJA',
                    style: GoogleFonts.poppins(
                      fontSize: 35,
                      fontWeight: FontWeight.w800,
                      color: Colors.red,
                    )),
              ),
            ),
////////////////////////////////////////////////////////7
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, bottom: 10),
                child: isKupacSelected
                    ? Stack(
                        children: [
                          TextFormField(
                            controller: kupacController,
                            style: GoogleFonts.archivo(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            enabled: false,
                            decoration: InputDecoration(
                              hintText: kupacController.text,
                              prefixIcon:
                                  const Icon(Icons.person, color: Colors.red),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 3.0,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            bottom: 0,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isKupacSelected = false;
                                });
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child:
                                    Icon(Icons.edit_rounded, color: Colors.red),
                              ),
                            ),
                          ),
                        ],
                      )
                    : TextField(
                        controller: kupacController,
                        style: GoogleFonts.archivo(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 3.0,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.red,
                          ),
                          hintText: 'Kupac',
                          hintStyle: GoogleFonts.archivo(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),

                        //klik
                        onChanged: (value) async {
                          setState(() {
                            if (value.isNotEmpty) {
                              // Update the search results based on the entered text
                              _filterKupciByQuery(value).then((result) {
                                kupacResult = result;
                              });
                            } else {
                              kupacResult =
                                  []; // Clear the search results when the user deletes characters
                            }
                          });
                        },
                      ),
              ),
            ),

            if (!isKupacSelected && kupacResult.isNotEmpty)
              SingleChildScrollView(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 25, right: 25, bottom: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 1.5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: SizedBox(
                        height: 200,
                        child: ListView.builder(
                          itemCount: kupacResult.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 50,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.red, width: 1.0),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: ListTile(
                                title: Text(
                                  kupacResult[index],
                                  style: GoogleFonts.archivo(fontSize: 16),
                                ),
                                onTap: () {
                                  kupacController.text = kupacResult[index];
                                  setState(() {
                                    isKupacSelected = true;
                                  });
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ////////////////////////////////////////////////////////////////////////////////
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 20, 0, 15),
                child: Text('Odaberite artikal',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    )),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, bottom: 10),

//mnogo posla oko ovog searcha
//dizajn
                child: isItemSelected
                    ? Stack(
                        children: [
                          TextFormField(
                            controller: searchController,
                            style: GoogleFonts.archivo(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            enabled: false,
                            decoration: InputDecoration(
                              hintText: searchController.text,
                              prefixIcon: const Icon(Icons.search_rounded,
                                  color: Colors.red),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 3.0,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            bottom: 0,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isItemSelected = false;
                                });
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child:
                                    Icon(Icons.edit_rounded, color: Colors.red),
                              ),
                            ),
                          ),
                        ],
                      )
                    : TextField(
                        controller: searchController,
                        style: GoogleFonts.archivo(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.red,
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
                            color: Colors.red,
                          ),
                          hintText: 'Pretražite artikal',
                          hintStyle: GoogleFonts.archivo(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),

                        //klik
                        onChanged: (value) async {
                          setState(() {
                            if (value.isNotEmpty) {
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

//logika
            if (!isItemSelected && searchResult.isNotEmpty)
              SingleChildScrollView(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 25, right: 25, bottom: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 1.5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: SizedBox(
                        height: 200,
                        child: ListView.builder(
                          itemCount: searchResult.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 50,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.red, width: 1.0),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: ListTile(
                                title: Text(
                                  searchResult[index],
                                  style: GoogleFonts.archivo(fontSize: 16),
                                ),
                                onTap: () {
                                  searchController.text = searchResult[index];
                                  setState(() {
                                    isItemSelected = true;
                                  });
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),

            ///////////////////////////////////////////////

            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, bottom: 10),
                child: isMarkaSelected
                    ? Stack(
                        children: [
                          TextFormField(
                            controller: markaController,
                            style: GoogleFonts.archivo(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            enabled: false,
                            decoration: InputDecoration(
                              hintText: markaController.text,
                              prefixIcon: const Icon(Icons.attach_money,
                                  color: Colors.red),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 3.0,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            bottom: 0,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isMarkaSelected = false;
                                });
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child:
                                    Icon(Icons.edit_rounded, color: Colors.red),
                              ),
                            ),
                          ),
                        ],
                      )
                    : TextField(
                        controller: markaController,
                        style: GoogleFonts.archivo(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 3.0,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          prefixIcon: const Icon(
                            Icons.shopping_bag_outlined,
                            color: Colors.red,
                          ),
                          hintText: 'Marka',
                          hintStyle: GoogleFonts.archivo(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),

                        //klik
                        onChanged: (value) async {
                          setState(() {
                            if (value.isNotEmpty) {
                              _filterMarkeByQuery(value).then((result) {
                                markaResult = result;
                              });
                            } else {
                              markaResult = [];
                            }
                          });
                        },
                      ),
              ),
            ),

            if (!isMarkaSelected && markaResult.isNotEmpty)
              SingleChildScrollView(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 25, right: 25, bottom: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 1.5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: SizedBox(
                        height: 200,
                        child: ListView.builder(
                          itemCount: markaResult.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 50,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.red, width: 1.0),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: ListTile(
                                title: Text(
                                  markaResult[index],
                                  style: GoogleFonts.archivo(fontSize: 16),
                                ),
                                onTap: () {
                                  markaController.text = markaResult[index];
                                  setState(() {
                                    isMarkaSelected = true;
                                  });
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ////////////////////////////////////////////////////////////////////////////////
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 7.0, horizontal: 25.0),
              child: TextField(
                controller: cijenaprodajnaController,
                style: GoogleFonts.archivo(
                  fontSize: 16,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red, width: 3.0),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  prefixIcon: const Icon(
                    Icons.attach_money_rounded,
                    color: Colors.red,
                  ),
                  hintText: 'Unesite cijenu',
                  hintStyle: GoogleFonts.archivo(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
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
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SplashIzlaz()));
        },
        label: const Text('Izlaz'),
        icon: const Icon(Icons.attach_money_rounded),
        backgroundColor: Colors.red,
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
      'datumDodavanja': DateTime.now(),
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

  Future<List<String>> _filterKupciByQuery(String query) async {
    // Fetch data from Firebase
    final izlaz = await FirebaseFirestore.instance.collection('izlaz').get();

    // Extract artikal values from the fetched data
    final kupci = izlaz.docs.map((doc) => doc['kupac'] as String).toList();

    // Group the artikli by their name and count the number of occurrences
    final kupacCounts = <String, int>{};
    for (final kupci in kupci) {
      kupacCounts[kupci] = (kupacCounts[kupci] ?? 0) + 1;
    }

    // Filter the data source based on the entered text, but only include
    // one instance of each artikal name
    final filteredKupci = kupacCounts.keys
        .where((artikal) =>
            artikal.toLowerCase().contains(query.trim().toLowerCase()))
        .toList();

    return filteredKupci;
  }

  Future<List<String>> _filterMarkeByQuery(String query) async {
    // Fetch data from Firebase
    final izlaz = await FirebaseFirestore.instance.collection('izlaz').get();

    // Extract artikal values from the fetched data
    final marke = izlaz.docs.map((doc) => doc['marka'] as String).toList();

    // Group the artikli by their name and count the number of occurrences
    final markeCounts = <String, int>{};
    for (final marka in marke) {
      markeCounts[marka] = (markeCounts[marke] ?? 0) + 1;
    }

    // Filter the data source based on the entered text, but only include
    // one instance of each artikal name
    final filteredMarke = markeCounts.keys
        .where((artikal) =>
            artikal.toLowerCase().contains(query.trim().toLowerCase()))
        .toList();

    return filteredMarke;
  }
}
