import './screens/splash_screen.dart';

import './screens/alpha_list.dart';
import './screens/history_screen.dart';
import './screens/main_home-page.dart';
import './screens/main_screen.dart';
import './screens/show_list_of_alpha.dart';
import './screens/favorite_page.dart';
import './constant.dart';
import './models/botmodel.dart';
import './screens/dictonary_details.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import './screens/homepage.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Botmodel>(BotmodelAdapter());
  await Hive.openBox<Botmodel>(kbotBox);
  await Hive.openBox(kHiveBox);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLight = true;

  void toggleTheme() {
    setState(() {
      isLight = !isLight;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Botany Essential',
      theme: isLight ? kLightTheme : ThemeData.dark(),
      home: getMetaData()
          ? MainScreen()
          : SplashScreen(
              theme: isLight,
              toogle: toggleTheme,
            ),
      routes: {
        Homepage.routeName: (context) => Homepage(),
        SplashScreen.routeName: (context) => SplashScreen(),
        ALphaListScreen.routeName: (context) => ALphaListScreen(),
        FavoritePage.routeName: (context) => FavoritePage(),
        ListAccordingToaAlpha.routeName: (context) => ListAccordingToaAlpha(),
        MainScreen.routeName: (context) => MainScreen(),
        DictItemScreen.routeName: (context) => DictItemScreen(),
        HistoryPage.routeName: (context) => HistoryPage(),
        MainHomePage.routeName: (context) => MainHomePage(),
      },
    );
  }

  bool getMetaData() {
    return Hive.box(kHiveBox).get("isLoaded") == null;
  }
}
