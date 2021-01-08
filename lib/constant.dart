import './screens/search_bar.dart';
import 'package:flutter/material.dart';

const String kbotBox = "botany-box";
const String kHiveBox = "meta-data";
final ktermTextStyle = TextStyle(
    // color: Colors.white,
    fontSize: 29,
    fontWeight: FontWeight.w700,
    fontFamily: "ZillaSlab");

final kMeaningStyle = TextStyle(
  fontFamily: "ZillaSlab",
  // color: Colors.white,
  fontSize: 17,
  fontStyle: FontStyle.italic,
);

SliverAppBar ksliverAppBar(BuildContext context) {
  return SliverAppBar(
    title: Text('Botany essential'),
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          showSearch(
            context: context,
            delegate: Searchbar(),
          );
        },
      ),
    ],
  );
}

const List<String> kalphaList = [
  'a',
  'b',
  'c',
  'd',
  'e',
  'f',
  'g',
  'h',
  'i',
  'j',
  'k',
  'l',
  'm',
  'n',
  'o',
  'p',
  'q',
  'r',
  's',
  't',
  'u',
  'v',
  'w',
  'x',
  'y',
  'z'
];

final kLightTheme = ThemeData(
  canvasColor: Colors.lightGreen.shade100, //Colors.lightGreen.shade100,
  textTheme: ThemeData.light()
      .textTheme
      .copyWith(bodyText2: TextStyle(fontFamily: "Alegreya")),
  primaryColor: Colors.green, //Color(0xff028900), //Color(0xffd4344c), //,
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

// TextStyle(
// color: Colors.white,
// fontSize: 15,
// fontStyle: FontStyle.italic,
// );
