// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_game/game/game.dart';
import 'package:flutter_game/widgets/overlays/pause_button.dart';
import 'package:velocity_x/velocity_x.dart';

class PauseMenu extends StatelessWidget {
  static const String ID = 'PauseMenu';
  final SpaceGame gameRef;

  PauseMenu({Key? key, required this.gameRef}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: VxBox(
      child: [
        'Paused'.text.xl6.widest.semiBold.uppercase.make(),
        50.heightBox,
        MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 10,
          color: Colors.grey.withOpacity(0.1),
          height: 60,
          onPressed: () {
            gameRef.resumeEngine();
            gameRef.overlays.remove(PauseMenu.ID);
            gameRef.overlays.add(PauseButton.ID);
          },
          child: 'Resume'.text.white.widest.xl2.make(),
        ),
        50.heightBox,
        MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 10,
          color: Colors.grey.withOpacity(0.1),
          height: 60,
          onPressed: () {
            gameRef.overlays.remove(PauseMenu.ID);
            gameRef.overlays.add(PauseButton.ID);
            gameRef.reSet();
            gameRef.resumeEngine();
          },
          child: 'Reset'.text.white.widest.xl2.make(),
        ),
        50.heightBox,
        MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 10,
          color: Colors.grey.withOpacity(0.1),
          height: 60,
          onPressed: () {
            gameRef.overlays.remove(PauseMenu.ID);
            Navigator.pop(context);
          },
          child: 'Exit'.text.white.widest.xl2.make(),
        )
      ].column(),
    ).makeCentered());
  }
}
