import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game/game/bullet.dart';
import 'package:flutter_game/game/enemy_manager.dart';
import 'package:flutter_game/game/game_size.dart';
import 'package:flutter_game/game/player.dart';
import 'package:flutter_game/widgets/overlays/pause_button.dart';
import 'package:flutter_game/widgets/overlays/pause_menu.dart';

class SpaceGame extends FlameGame
    with PanDetector, TapDetector, HasCollidables {
  late Player player;
  late EnemyManager _enemyManager;
  Offset? _pointerStartPosition;
  Random random = Random();
  Vector2 getRandomVector2() {
    return (Vector2.random(random) - Vector2.random(random)) * 500;
  }

  bool _isLoaded = false;
  bool isGameOver = false;
  late TextComponent playerScore;
  late TextComponent playerHealth;

  @override
  Future<void>? onLoad() async {
    super.onLoad();
    if (!_isLoaded) {
      ParallaxComponent _backGround = await ParallaxComponent.load([
        ParallaxImageData('background1.png'),
        ParallaxImageData('background2.png'),
      ],
          repeat: ImageRepeat.repeat,
          baseVelocity: Vector2(0, -50),
          velocityMultiplierDelta: Vector2(0, 1.5));

      add(_backGround);

      final sprite = await Sprite.load('ship_L.png');
      final size = Vector2(64, 64);
      final position = Vector2(canvasSize.toSize().width / 2,
          canvasSize.toSize().height - canvasSize.toSize().height / 8);

      // screen coordinates
      player = Player(sprite: sprite, size: size, position: position);

      player.anchor = Anchor.center;
      add(player); // Adds the component

      _enemyManager = EnemyManager();
      add(_enemyManager);

      playerScore = TextComponent(text: 'Score : 0', position: Vector2(10, 10));
      add(playerScore);

      playerHealth =
          TextComponent(text: 'Health : 100%', position: Vector2(10, 50));
      add(playerHealth);

      camera.defaultShakeDuration = 0.1;
      camera.defaultShakeIntensity = 30.0;
      _isLoaded = true;
    }
  }

  @override
  void onTapDown(TapDownInfo info) async {
    final sprite = await Sprite.load('star_tiny.png');
    final size = Vector2(64, 64);
    final position = player.position.clone();
    super.onTapDown(info);
    Bullet bullet = Bullet(sprite: sprite, size: size, position: position);
    bullet.anchor = Anchor.center;
    add(bullet);
  }

  @override
  void onPanStart(DragStartInfo info) {
    _pointerStartPosition = info.raw.localPosition;
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    final _pointerCurrentPosition = info.raw.localPosition;
    var delta = _pointerCurrentPosition - _pointerStartPosition!;
    player.setMoveDirection(Vector2(delta.dx, delta.dy));
  }

  @override
  void onPanEnd(DragEndInfo info) {
    _pointerStartPosition = null;
    player.setMoveDirection(Vector2.zero());
  }

  @override
  void onPanCancel() {
    _pointerStartPosition = null;
    player.setMoveDirection(Vector2.zero());
  }

  @override
  void prepareComponent(Component component) {
    super.prepareComponent(component);
    if (component is GameSize) {
      component.onResize(size);
    }
  }

  @override
  void onGameResize(Vector2 canvasSize) {
    super.onGameResize(canvasSize);
    children.whereType<GameSize>().forEach((element) {
      element.onResize(size);
    });
  }

  @override
  void lifecycleStateChange(AppLifecycleState state) {
    super.lifecycleStateChange(state);
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:

      case AppLifecycleState.paused:

      case AppLifecycleState.detached:
        if (!isGameOver) {
          pauseEngine();
          overlays.remove(PauseButton.ID);
          overlays.add(PauseMenu.ID);
        }
        break;
      default:
    }
  }
}
