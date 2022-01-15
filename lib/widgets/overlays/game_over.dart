// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_game/game/game.dart';
import 'package:velocity_x/velocity_x.dart';

class GameOverMenu extends StatelessWidget {
  static const String ID = 'GameOverMenu';
  final SpaceGame gameRef;

  GameOverMenu({Key? key, required this.gameRef}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: VxBox(
      child: [
        'Game Over'.text.xl6.widest.semiBold.uppercase.make(),
        50.heightBox,
        MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 10,
          color: Colors.grey.withOpacity(0.1),
          height: 60,
          onPressed: () {},
          child: 'Play Again'.text.white.widest.xl2.make(),
        ),
        50.heightBox,
        MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 10,
          color: Colors.grey.withOpacity(0.1),
          height: 60,
          onPressed: () {
            gameRef.overlays.remove(GameOverMenu.ID);
            Navigator.pop(context);
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => MainMenu()));
          },
          child: 'Exit'.text.white.widest.xl2.make(),
        )
      ].column(),
    ).makeCentered());
  }
}
