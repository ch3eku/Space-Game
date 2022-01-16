// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game/game/enemy.dart';
import 'package:flutter_game/game/game.dart';
import 'package:flutter_game/game/game_size.dart';

class Player extends SpriteComponent
    with GameSize, HasGameRef<SpaceGame>, HasHitboxes, Collidable {
  Player({Sprite? sprite, Vector2? size, Vector2? position})
      : super(sprite: sprite, size: size, position: position);

  final Vector2 _moveDirection = Vector2.zero();
  double speed = 300;
  Random random = Random();
  Vector2 getRandomVector2() {
    return (Vector2.random(random) - Vector2(0.5, -1)) * 200;
  }

  int playerScore = 0;
  int playerHealth = 100;

  @override
  void update(double dt) {
    super.update(dt);
    position += _moveDirection.normalized() * speed * dt;
    position.clamp(Vector2.zero() + size / 2, gameSize - size / 2);

    final particalComponent = ParticleComponent(Particle.generate(
        count: 10,
        lifespan: 0.1,
        generator: (i) => AcceleratedParticle(
            acceleration: getRandomVector2(),
            speed: getRandomVector2(),
            position: position.clone() - Vector2(0, -10),
            child: CircleParticle(
              radius: 1,
              paint: Paint()..color = Colors.white,
            ))));
    gameRef.add(particalComponent);
  }

  @override
  void onMount() {
    super.onMount();
    final shape = HitboxCircle(normalizedRadius: .7);
    addHitbox(shape);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    if (other is Enemy) {
      gameRef.remove(other);
      gameRef.camera.shake();
      playerHealth -= 10;
    }
  }

  // @override
  // void render(Canvas canvas) {
  //   super.render(canvas);
  //   renderHitboxes(canvas);
  // }

  void setMoveDirection(Vector2 newMoveDirection) {
    _moveDirection.x = newMoveDirection.x;
  }

  void reSet() {
    playerScore = 0;
    gameRef.playerScoreText.text = 'Score : $playerScore';
    playerHealth = 100;
    gameRef.playerHealthText.text = 'Health : $playerHealth%';
    position = gameRef.player.position;
  }
}
