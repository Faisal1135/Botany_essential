import 'package:botany_essential/riverpod/providers.dart';
import 'package:flutter_riverpod/all.dart';

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
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final isLight = watch(themeProvider).state;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Botany Essential',
      theme: isLight ? kLightTheme : ThemeData.dark(),
      home: getMetaData() ? MainScreen() : SplashScreen(),
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
