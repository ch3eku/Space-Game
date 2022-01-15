// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_game/game/game.dart';
import './pause_menu.dart';

class PauseButton extends StatelessWidget {
  static const String ID = 'PauseButton';
  final SpaceGame gameRef;

  PauseButton({Key? key, required this.gameRef}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child: IconButton(
            onPressed: () {
              gameRef.pauseEngine();
              gameRef.overlays.remove(PauseButton.ID);
              gameRef.overlays.add(PauseMenu.ID);
            },
            icon: Icon(Icons.pause)));
  }
}
