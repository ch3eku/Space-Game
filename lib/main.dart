// ignore_for_file: use_key_in_widget_constructors

import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game/screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // This opens the app in fullscreen mode.
  await Flame.device.fullScreen();

  runApp(MaterialApp(
    theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Bungee Outline',
        scaffoldBackgroundColor: Colors.black),
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
}
