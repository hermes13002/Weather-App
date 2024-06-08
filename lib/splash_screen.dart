import 'dart:async';

import 'package:excweatherapp/homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    _startFadeIn();
  }

  void _startFadeIn() {
    Timer(const Duration(seconds: 3), () {
      setState(() {
        _opacity = 1.0;
      });
    });

    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
            colors: <Color>[
              Color.fromARGB(255, 4, 176, 255),
              Color.fromARGB(255, 11, 205, 253),
              Color.fromARGB(255, 81, 243, 255),
              Color.fromARGB(255, 184, 229, 243),

            ],
            tileMode: TileMode.mirror,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 20, right: 12, left: 12, bottom: 0),
          child: AnimatedOpacity(
            opacity: _opacity,
            duration: const Duration(seconds: 3),
            child: Column(
              children: [
                const SizedBox(height: 100,),
                Image.asset('assets/image/sunny_cloud.png'),
                const SizedBox(height: 50,),
                Text("Weather App", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 40, color: Colors.white),),
              ],
            ),
          ),
        )
      )
    );
  }
}