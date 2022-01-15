// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_game/screens/game_play.dart';
import 'package:velocity_x/velocity_x.dart';

class MainMenu extends StatelessWidget {
  MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
          barrierColor: Colors.black,
            context: context,
            builder: (context) {
              return Dialog(
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: [
                'Do You Want To Exit?'.text.xl2.widest.semiBold.make(),
                20.heightBox,
                [
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 10,
                    color: Colors.grey.withOpacity(0.3),
                    height: 60,
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: 'No'.text.white.widest.xl2.make(),
                  ),
                  20.widthBox,
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 10,
                    color: Colors.grey.withOpacity(0.3),
                    height: 60,
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: 'Yes'.text.white.widest.xl2.make(),
                  )
                ].row()
              ].column(alignment: MainAxisAlignment.center)
              );
            });
      },
      child: Scaffold(
          body: VxBox(
        child: [
          VxBox()
              .square(95)
              .roundedFull
              .neumorphic(color: Vx.black, elevation: 40)
              .bgImage(DecorationImage(
                  image: AssetImage('assets/images/ship_L.png')))
              .make(),
          50.heightBox,
          'Space Game'.text.xl6.widest.semiBold.make(),
          50.heightBox,
          MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 10,
            color: Colors.grey.withOpacity(0.1),
            height: 60,
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => GamePlay()));
            },
            child: 'Start'.text.white.widest.xl2.make(),
          )
        ].column(),
      ).makeCentered()),
    );
  }
}
