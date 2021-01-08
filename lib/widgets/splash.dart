import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:drawing_animation/drawing_animation.dart';
import 'package:flutter/material.dart';

import '../screens/main_home-page.dart';

class SplashWidget extends StatelessWidget {
  final Function toogle;
  final bool isLight;
  const SplashWidget({
    Key key,
    this.toogle,
    this.isLight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height / 2.4),
          color: Colors.white,
          child: TextLiquidFill(
              text: 'Botany Essential',
              waveColor: Color(0xffADFF00),
              loadDuration: Duration(seconds: 3),
              boxBackgroundColor: Colors.orangeAccent,
              textStyle: TextStyle(
                  fontFamily: "Alegreya", fontSize: 40, color: Colors.amber)),
        ),
        Container(
          child: AnimatedDrawing.svg(
            "assets/images/splash.svg",
            run: true,
            duration: Duration(seconds: 3),
            onFinish: () => Navigator.pushReplacementNamed(
                context, MainHomePage.routeName,
                arguments: [toogle, isLight]),
          ),
        )
      ],
    );
  }
}
