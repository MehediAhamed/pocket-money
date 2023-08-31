import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocketmoney/HomePage.dart';

class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: Color(0xFF0A0000),
      splash: Center(
        child: Column(
          children: [Text(
            'Pocket Money',
            style: TextStyle(
              fontSize: 30,
              fontFamily: "Kablammo",
              fontWeight: FontWeight.bold,
              color: Colors.white,

            ),
          ),
            Text(
              'Your Personal Expense Tracker',
                style: TextStyle(
                fontSize: 15,
                color: Colors.white,

              ),
            ),
        ]
        ),
      ),
      nextScreen: MyHomePage(title: 'Flutter Demo Home Page'),
      splashTransition: SplashTransition.scaleTransition,
      duration: 1000,
    );
  }
}
