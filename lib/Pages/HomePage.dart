import 'package:flutter/material.dart';
import 'package:prodajaodjece/Pages/SplashAdd.dart';
import 'UlazRobe.dart';
import 'IzlazRobe.dart';
import 'Transakcije.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_core/firebase_core.dart';


Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(HomePage());
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
      appBar: AppBar(

      ),
      body: Center(



        child: Column(

          children:  [

              Padding(
                padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
                child: Container(
                    height: 250,
                    width:300 ,
                    child: Lottie.asset('odjeca.json')),
              ),


              Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 25,0 ),
                child: const Text(
                    'Zdravo, izaberite neku \nod operacija',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 31
                  ),
                ),
              ),



            SizedBox(
              height: 50,
            ),

            SizedBox(
              height:51, //height of button
              width:200, //width of button
              child: ElevatedButton(

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,

                  textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontStyle: FontStyle.normal),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  UlazRobe())) ;
                },

                child: const Text('Ulaz robe'),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height:51, //height of button
              width:200, //width of button
              child: ElevatedButton(

                child: Text('Izlaz robe'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightBlue,

                  textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontStyle: FontStyle.normal),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const IzlazRobe())) ;
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height:51, //height of button
              width:200, //width of button
              child: ElevatedButton(

                child: Text('Transakcije'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightBlue,

                  textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontStyle: FontStyle.normal),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Transakcije())) ;
                },
              ),
            ),

            const SizedBox(
                height: 25
            ),



            SizedBox(
              height:51, //height of button
              width:200, //width of button
              child: ElevatedButton(

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,

                  textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontStyle: FontStyle.normal),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  Splash())) ;
                },

                child: const Text('Ulaz robe'),
              ),
            ),



          ],
        ),
      ),
    );
  }
}
