import '../widgets/splash.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  final Function toogle;
  final bool theme;
  static const routeName = "/splash-screen";

  const SplashScreen({Key key, this.toogle, this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: SplashWidget(toogle: toogle, isLight: theme),
    );
  }
}
