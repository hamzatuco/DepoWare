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

        body: SingleChildScrollView (
            child: Column(
              children:  [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),

                    child: Text(
                        'TRANSAKCIJE',
                        style: GoogleFonts.bebasNeue(fontSize: 35,fontWeight: FontWeight.bold,color: Colors.deepPurple,)),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    color: Colors.deepPurple.shade50,
                    width: double.infinity,
                    height: 248.0,

                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    color: Colors.deepPurple.shade50,
                    width: double.infinity,
                    height: 248.0,

                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    color: Colors.deepPurple.shade50,
                    width: double.infinity,
                    height: 248.0,

                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    color: Colors.deepPurple.shade50,
                    width: double.infinity,
                    height: 248.0,

                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    color: Colors.deepPurple.shade50,
                    width: double.infinity,
                    height: 248.0,

                  ),
                ),



              ],

            )
        )
    );

  }
}
