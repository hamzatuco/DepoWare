// ignore_for_file: file_names, library_private_types_in_public_api, prefer_const_constructors

import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:prodajaodjece/Pages/HomePage.dart';




class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);



  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash>
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
                height: 300,
                  width:300 ,
                  child: Lottie.network('https://assets10.lottiefiles.com/packages/lf20_kdjli5ii.json',
                  repeat: false)
              ),
          Text('USPJEŠAN UNOS',
              style: GoogleFonts.bebasNeue(
                  fontSize: 45, fontWeight: FontWeight.bold,color: Colors.redAccent)),






      ],
          ),
        ));
  }
}