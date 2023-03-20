// ignore_for_file: file_names
//shrink wrap
//future builder
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Transakcije extends StatefulWidget {
  const Transakcije({Key? key}) : super(key: key);

  @override
  State<Transakcije> createState() => _TransakcijeState();
}

class _TransakcijeState extends State<Transakcije> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text('TRANSAKCIJE',
                    style: GoogleFonts.poppins(
                      fontSize: 35,
                      fontWeight: FontWeight.w800,
                      color: Colors.deepPurple,
                    )),
              ),
            ),
          ],
        )));
  }
}
