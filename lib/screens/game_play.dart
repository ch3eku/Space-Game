// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game/game/game.dart';
import 'package:flutter_game/widgets/overlays/game_over.dart';
import 'package:flutter_game/widgets/overlays/pause_button.dart';
import 'package:flutter_game/widgets/overlays/pause_menu.dart';

class GamePlay extends StatelessWidget {
  final SpaceGame _spaceGame = SpaceGame();
  GamePlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
          onWillPop: () async => false,
          child: GameWidget(
            game: _spaceGame,
            initialActiveOverlays: [PauseButton.ID],
            overlayBuilderMap: {
              PauseButton.ID: (BuildContext context, SpaceGame gameRef) =>
                  PauseButton(gameRef: gameRef),
              PauseMenu.ID: (BuildContext context, SpaceGame gameRef) =>
                  PauseMenu(gameRef: gameRef),
              GameOverMenu.ID: (BuildContext context, SpaceGame gameRef) =>
                  GameOverMenu(gameRef: gameRef)
            },
          )),
    );
  }
}
