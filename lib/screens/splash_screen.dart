// ignore_for_file: prefer_const_constructors_in_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VxBox()
          .square(120)
          .roundedFull
          .neumorphic(color: Vx.black, elevation: 50)
          .bgImage(const DecorationImage(
              image: AssetImage('assets/images/splashicon.png')))
          .makeCentered(),
    );
  }
}
