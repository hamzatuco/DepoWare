// ignore_for_file: file_names, prefer_const_constructors
//snackbar

import 'SplashAdd.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../firebase_options.dart';

void main() async {
  runApp(const UlazRobe());
}

class UlazRobe extends StatefulWidget {
  const UlazRobe({Key? key}) : super(key: key);

  @override
  State<UlazRobe> createState() => _UlazRobeState();
}

class _UlazRobeState extends State<UlazRobe> {
  final artikalController = TextEditingController();
  final markaController = TextEditingController();
  final nabavnacijenaController = TextEditingController();
  final nabavljacController = TextEditingController();

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

  List<String> nabavljacResult = [];
  bool isNabavljacSelected = false;
  void searchFromulaz(String query) async {
    final result = await FirebaseFirestore.instance
        .collection('ulaz')
        .where('nabavljac', isEqualTo: query)
        .get();

    setState(() {
      nabavljacResult =
          result.docs.map((e) => e.data()).cast<String>().toList();
    });
  }

  List<String> markaResult = [];
  bool isMarkaSelected = false;
  void searchMarka(String query) async {
    final result = await FirebaseFirestore.instance
        .collection('ulaz')
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
                child: Text('ULAZ ROBE',
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
                padding:
                    const EdgeInsets.symmetric(vertical: 7.0, horizontal: 25.0),
                child: isNabavljacSelected
                    ? Stack(
                        children: [
                          TextFormField(
                            controller: nabavljacController,
                            style: GoogleFonts.archivo(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            enabled: false,
                            decoration: InputDecoration(
                              hintText: nabavljacController.text,
                              prefixIcon: const Icon(Icons.person,
                                  color: Colors.redAccent),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.redAccent,
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
                                  isNabavljacSelected = false;
                                });
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Icon(Icons.edit_rounded,
                                    color: Colors.redAccent),
                              ),
                            ),
                          ),
                        ],
                      )
                    : TextField(
                        controller: nabavljacController,
                        style: GoogleFonts.archivo(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.redAccent,
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
                            color: Colors.redAccent,
                          ),
                          hintText: 'Nabavljac',
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
                                nabavljacResult = result;
                              });
                            } else {
                              nabavljacResult =
                                  []; // Clear the search results when the user deletes characters
                            }
                          });
                        },
                      ),
              ),
            ),

            if (!isNabavljacSelected && nabavljacResult.isNotEmpty)
              SingleChildScrollView(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 7.0, horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.redAccent, width: 1.5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: SizedBox(
                        height: 200,
                        child: ListView.builder(
                          itemCount: nabavljacResult.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.redAccent, width: 1.0),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: ListTile(
                                title: Text(
                                  nabavljacResult[index],
                                  style: GoogleFonts.archivo(fontSize: 16),
                                ),
                                onTap: () {
                                  nabavljacController.text =
                                      nabavljacResult[index];
                                  setState(() {
                                    isNabavljacSelected = true;
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
            ///////////////////////////////////////////////

            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 7.0, horizontal: 25.0),
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
                                  color: Colors.redAccent),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.redAccent,
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
                                child: Icon(Icons.edit_rounded,
                                    color: Colors.redAccent),
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
                              color: Colors.redAccent,
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
                            color: Colors.redAccent,
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 7.0, horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.redAccent, width: 1.5),
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
                                border: Border.all(
                                    color: Colors.redAccent, width: 1.0),
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
            ///
            ////////////////////////////////////////////////////////////////////////////////

            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 7.0, horizontal: 25.0),

//mnogo posla oko ovog searcha
//dizajn
                child: isItemSelected
                    ? Stack(
                        children: [
                          TextFormField(
                            controller: artikalController,
                            style: GoogleFonts.archivo(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            enabled: false,
                            decoration: InputDecoration(
                              hintText: artikalController.text,
                              prefixIcon: const Icon(Icons.search_rounded,
                                  color: Colors.redAccent),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.redAccent,
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
                                child: Icon(Icons.edit_rounded,
                                    color: Colors.redAccent),
                              ),
                            ),
                          ),
                        ],
                      )
                    : TextField(
                        controller: artikalController,
                        style: GoogleFonts.archivo(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.redAccent,
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
                            color: Colors.redAccent,
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 7.0, horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.redAccent, width: 1.5),
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
                                border: Border.all(
                                    color: Colors.redAccent, width: 1.0),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: ListTile(
                                title: Text(
                                  searchResult[index],
                                  style: GoogleFonts.archivo(fontSize: 16),
                                ),
                                onTap: () {
                                  artikalController.text = searchResult[index];
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

            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 7.0, horizontal: 25.0),
              child: TextField(
                controller: nabavnacijenaController,
                style: GoogleFonts.archivo(
                  fontSize: 16,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.redAccent, width: 3.0),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  prefixIcon: const Icon(
                    Icons.attach_money_rounded,
                    color: Colors.redAccent,
                  ),
                  hintText: 'Nabavna cijena',
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
          dodajRobu(
            artikalController.text.trim(),
            markaController.text.trim(),
            nabavljacController.text.trim(),
            int.parse(nabavnacijenaController.text.trim()),
          );
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Splash()));
        },
        label: const Text('Unesi robu'),
        icon: const Icon(Icons.save_alt_rounded),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  Future dodajRobu(
      String artikal, String marka, String nabavljac, int nabavnaCijena) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseFirestore.instance.collection('ulaz').add({
      'artikal': artikal,
      'marka': marka,
      'nabavljac': nabavljac,
      'nabavnaCijena': nabavnaCijena,
    });
  }

  Future<List<String>> _filterArtikliByQuery(String query) async {
    // Fetch data from Firebase
    final ulaz = await FirebaseFirestore.instance.collection('ulaz').get();

    // Extract artikal values from the fetched data
    final artikli = ulaz.docs.map((doc) => doc['artikal'] as String).toList();

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
    final ulaz = await FirebaseFirestore.instance.collection('ulaz').get();

    // Extract artikal values from the fetched data
    final kupci = ulaz.docs.map((doc) => doc['nabavljac'] as String).toList();

    // Group the artikli by their name and count the number of occurrences
    final nabavljacCounts = <String, int>{};
    for (final kupci in kupci) {
      nabavljacCounts[kupci] = (nabavljacCounts[kupci] ?? 0) + 1;
    }

    // Filter the data source based on the entered text, but only include
    // one instance of each artikal name
    final filteredKupci = nabavljacCounts.keys
        .where((artikal) =>
            artikal.toLowerCase().contains(query.trim().toLowerCase()))
        .toList();

    return filteredKupci;
  }

  Future<List<String>> _filterMarkeByQuery(String query) async {
    // Fetch data from Firebase
    final ulaz = await FirebaseFirestore.instance.collection('ulaz').get();

    // Extract artikal values from the fetched data
    final marke = ulaz.docs.map((doc) => doc['marka'] as String).toList();

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
