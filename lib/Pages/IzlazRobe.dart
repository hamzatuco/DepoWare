//unos kod artikla, search, precica, tolowercase
// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../firebase_options.dart';

class IzlazRobe extends StatefulWidget {
  const IzlazRobe({Key? key}) : super(key: key);

  @override
  State<IzlazRobe> createState() => _IzlazRobeState();
}


class _IzlazRobeState extends State<IzlazRobe> {
  final kupacController = TextEditingController();
  final cijenaprodajnaController = TextEditingController();
  final artikalController = TextEditingController();
  final markaController = TextEditingController();
@override
 void initState() {
    super.initState();
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
      );
  }


List<String> docIDs = [];
String dropdownValue = "";


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
            artikalController.text.trim(),
            markaController.text.trim(),
            kupacController.text.trim(),
            int.parse(cijenaprodajnaController.text.trim()),
          );
        },
        label: const Text('Kupi'),
        icon: const Icon(Icons.attach_money_rounded),
        backgroundColor: Colors.lightGreen,
      ),
    );
  }
  Future prodajRobu(String artikal, String marka, String kupac,
      int cijena) async {
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
}
