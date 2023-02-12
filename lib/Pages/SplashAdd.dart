import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:prodajaodjece/Pages/HomePage.dart';




class Splash extends StatefulWidget {
  Splash({Key? key}) : super(key: key);



  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;


  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    _animation = new Tween<double>(begin: 0, end: 1).animate(
        new CurvedAnimation(
            parent: _animationController, curve: Curves.easeInOutCirc));

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

              Container(
                height: 300,
                  width:300 ,
                  child: Lottie.asset('checkmark.json',
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