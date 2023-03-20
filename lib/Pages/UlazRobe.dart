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
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 7.0, horizontal: 25.0),
              child: TextField(
                controller: artikalController,
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
                  prefixIcon:
                      const Icon(Icons.shopping_cart, color: Colors.redAccent),
                  hintText: 'Artikal',
                  hintStyle: GoogleFonts.archivo(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 7.0, horizontal: 25.0),
              child: TextField(
                controller: markaController,
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
                    Icons.shopping_bag_rounded,
                    color: Colors.redAccent,
                  ),
                  hintText: 'Marka',
                  hintStyle: GoogleFonts.archivo(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
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
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 7.0, horizontal: 25.0),
              child: TextField(
                controller: nabavljacController,
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
                  prefixIcon: const Icon(Icons.person, color: Colors.redAccent),
                  hintText: 'Nabavljac',
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
}
