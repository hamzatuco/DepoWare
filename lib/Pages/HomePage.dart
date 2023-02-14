// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'UlazRobe.dart';
import 'IzlazRobe.dart';
import 'Transakcije.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_core/firebase_core.dart';


Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const HomePage());
}


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center (
 child: SingleChildScrollView(


        child: Column(

          children:  [

              Padding(
                padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
                child: SizedBox(
                    height: 250,
                    width:250 ,
                    child: Lottie.network('https://assets7.lottiefiles.com/packages/lf20_5ngs2ksb.json')),
              ),


              FittedBox(
                 fit: BoxFit.scaleDown,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 15, 25,0 ),
                  child: Text('Zdravo, izaberite neku\nod opcija',
                  textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                          fontSize: 29, fontWeight: FontWeight.bold)),
                ),
              ),



             const SizedBox(
              height: 50,
            ),

            SizedBox(
              height: 50, //height of button
              width:200, //width of button
              child: ElevatedButton(

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrangeAccent,

                  textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontStyle: FontStyle.normal),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  const UlazRobe())) ;
                },

                child: Text('Ulaz robe',
                textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.roboto(
                        fontSize: 17, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height:51, //height of button
              width:200, //width of button
              child: ElevatedButton(

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrangeAccent,

                  textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontStyle: FontStyle.normal),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const IzlazRobe())) ;
                },

                child: Text('Izlaz robe',
                textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.roboto(
                        fontSize: 17, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height:51, //height of button
              width:200, //width of button
              child: ElevatedButton(

                style: ElevatedButton.styleFrom(
                   backgroundColor: Colors.deepOrangeAccent,

                  textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontStyle: FontStyle.normal),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Transakcije())) ;
                },

                child: Text('Transakcije',
                textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.roboto(
                        fontSize: 17, fontWeight: FontWeight.bold)),
              ),
            ),

            const SizedBox(
                height: 25
            ),





          ],
        ),
      ),),
    );
  }
}
