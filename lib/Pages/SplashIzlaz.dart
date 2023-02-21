// ignore_for_file: file_names, library_private_types_in_public_api, prefer_const_constructors

import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:prodajaodjece/Pages/HomePage.dart';




class SplashIzlaz extends StatefulWidget {
  const SplashIzlaz({Key? key}) : super(key: key);



  @override
  _SplashIzlazState createState() => _SplashIzlazState();
}

class _SplashIzlazState extends State<SplashIzlaz>
    with SingleTickerProviderStateMixin {


  @override
  void initState() {


    super.initState();



    Timer(
        Duration(seconds: 3),
            () =>
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => HomePage())));


  }

  @override
  Widget build(BuildContext context)  {
    return Scaffold(



        body: Center(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              SizedBox(
                height: 250,
                  width:250 ,
                  child: Lottie.network('https://assets8.lottiefiles.com/packages/lf20_wc1axoqt.json',
                  repeat: false)
              ),
              SizedBox(
                height: 50,
              ),
          Text('USPJEŠAN UNOS',
              style: GoogleFonts.bebasNeue(
                  fontSize: 45, fontWeight: FontWeight.bold,color: Colors.green)),






      ],
          ),
        ));
  }
}