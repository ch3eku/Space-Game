import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game/game/bullet.dart';
import 'package:flutter_game/game/game.dart';
import 'package:flutter_game/game/game_size.dart';

// class Enemy extends SpriteComponent with GameSize, HasGameRef<SpaceGame> {
class Enemy extends SpriteComponent
    with GameSize, HasGameRef<SpaceGame>, HasHitboxes, Collidable {
  Enemy({Sprite? sprite, Vector2? size, Vector2? position})
      : super(sprite: sprite, size: size, position: position) {
    angle = pi;
  }
  double speed = 200;

  Random random = Random();
  Vector2 getRandomVector2() {
    return (Vector2.random(random) - Vector2.random(random)) * 500;
  }

  @override
  void onMount() {
    super.onMount();
    addHitbox(HitboxCircle(normalizedRadius: .7));
  }

  // @override
  // void render(Canvas canvas) {
  //   super.render(canvas);
  //   renderHitboxes(canvas);
  // }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    if (other is Bullet) {
      gameRef.remove(this);
      gameRef.player.playerScore += 1;
      gameRef.playerScore.text = 'Score : ${gameRef.player.playerScore}';
      final particalComponent = ParticleComponent(Particle.generate(
          count: 20,
          lifespan: .5,
          generator: (i) => AcceleratedParticle(
              acceleration: getRandomVector2(),
              speed: getRandomVector2(),
              position: position,
              child: CircleParticle(
                radius: 1.0,
                paint: Paint()..color = Colors.white,
              ))));
      gameRef.add(particalComponent);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += Vector2(0, 1) * speed * dt;
    if (position.y > gameSize.y) {
      remove(this);
    }
  }
}
