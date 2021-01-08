import 'package:botany_essential/riverpod/providers.dart';
import 'package:flutter_riverpod/all.dart';

import '../screens/homepage.dart';
import '../screens/main_home-page.dart';
import 'package:flutter/material.dart';
import '../screens/alpha_list.dart';
import '../screens/history_screen.dart';
import '../screens/favorite_page.dart';

class AppDrawer extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final isLight = watch(themeProvider).state;
    return Drawer(
      child: ListView(
        children: <Widget>[
          _createHeader(),
          SwitchListTile(
            value: !isLight,
            secondary: Icon(Icons.lightbulb),
            onChanged: (_) {
              context.read(themeProvider).state = !isLight;
            },
            title: Text('Dark Theme'),
          ),
          _createDrawerItem(
            icon: Icons.home,
            text: "Home",
            onTap: () =>
                Navigator.pushReplacementNamed(context, MainHomePage.routeName),
          ),
          _createDrawerItem(
            icon: Icons.library_books,
            text: "Full Dicotary",
            onTap: () =>
                Navigator.pushReplacementNamed(context, Homepage.routeName),
          ),
          _createDrawerItem(
            icon: Icons.text_format,
            text: "Alphabetic order",
            onTap: () => Navigator.pushReplacementNamed(
                context, ALphaListScreen.routeName),
          ),
          _createDrawerItem(
            icon: Icons.bookmark,
            text: "Favorite",
            onTap: () =>
                Navigator.pushReplacementNamed(context, FavoritePage.routeName),
          ),
          _createDrawerItem(
            icon: Icons.history,
            text: "History",
            onTap: () =>
                Navigator.pushReplacementNamed(context, HistoryPage.routeName),
          ),
        ],
      ),
    );
  }

  _createHeader() {
    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill, image: AssetImage('assets/images/plant2.jpg'))),
      child: Stack(
        children: <Widget>[
          Positioned(
              bottom: 10.0,
              right: 16.0,
              child: Text("Botany \nEssential",
                  style: TextStyle(
                      color: Colors.green.shade700,
                      fontSize: 30.0,
                      fontFamily: "ZillaSlab",
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w700))),
        ],
      ),
    );
  }

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(
            icon,
            color: Colors.green,
          ),
          SizedBox(
            width: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: "ZillaSlab",
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
