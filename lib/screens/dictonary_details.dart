import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';

import '../constant.dart';
import '../models/botmodel.dart';
import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DictItemScreen extends StatelessWidget {
  static const routeName = "/dict-details-screen";

  Future<void> togglefavorite(Botmodel botin) async {
    final botbox = Hive.box<Botmodel>(kbotBox);

    final bot = botbox.get(botin.term);
    if (bot.isFavorite) {
      bot.isFavorite = false;
    } else {
      bot.isFavorite = true;
    }
    await botbox.put(bot.term, bot);
  }

  @override
  Widget build(BuildContext context) {
    var dict = ModalRoute.of(context).settings.arguments as Botmodel;
    Size size = MediaQuery.of(context).size;
    if (dict == null) {
      dict = Botmodel(
          term: "No content",
          meaning: "Please Search for your keyword",
          innerLink: [],
          isFavorite: false);
    }
    print(dict.date);

    return Scaffold(
      backgroundColor: Theme.of(context)
          .primaryColor, //Color(0x8974d600), //Colors.green.shade800,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Botmodel>(kbotBox).listenable(),
        builder: (BuildContext context, Box<Botmodel> value, Widget child) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: <Widget>[
                      Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Hero(
                            tag: "${dict.id}",
                            child: Container(
                              child: FaIcon(
                                FontAwesomeIcons.tree,
                                color: Colors.green.shade700,
                                size: 100,
                              ),
                            ),
                          ),
                          Hero(
                            tag: "${dict.term}",
                            child: FittedBox(
                              child: Text(
                                dict.term,
                                style: ktermTextStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        color: Colors.black54,
                        child: IconButton(
                            icon: dict.isFavorite
                                ? Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 30,
                                  )
                                : Icon(Icons.star_border,
                                    color: Colors.amber, size: 30),
                            onPressed: () async {
                              final botobj = value.get(dict.term);
                              botobj.isFavorite = !botobj.isFavorite;
                              await value.put(botobj.term, botobj);
                            }),
                      ),
                    ],
                  ),
                ),
                ListView(
                  primary: false,
                  shrinkWrap: true,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      constraints: BoxConstraints(minHeight: size.height * 0.9),
                      child: Column(
                        children: <Widget>[
                          dict.innerLink == null
                              ? Container()
                              : Container(
                                  // color: Colors.blueGrey,
                                  // width: double.infinity,
                                  padding: const EdgeInsets.all(8.0),
                                  margin: const EdgeInsets.only(top: 8.0),
                                  child: Wrap(
                                    children: dict.innerLink
                                        .toSet()
                                        .map(
                                          (link) => Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 6),
                                            child: GFButton(
                                              size: GFSize.MEDIUM,
                                              shape: GFButtonShape.pills,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              onPressed: () {
                                                final arg =
                                                    Hive.box<Botmodel>(kbotBox)
                                                        .get(link);
                                                Navigator.pushNamed(context,
                                                    DictItemScreen.routeName,
                                                    arguments: arg);
                                              },
                                              child: Hero(
                                                tag: "$link",
                                                child: Text(link),
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Meaning',
                                  style: kMeaningStyle,
                                  textAlign: TextAlign.start,
                                ),
                                Divider(
                                  thickness: 1,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  dict.meaning,
                                  style: kMeaningStyle,
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
