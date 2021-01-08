import 'dart:math';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../constant.dart';
import '../models/botmodel.dart';
import '../screens/dictonary_details.dart';
import '../screens/history_screen.dart';
import '../screens/search_bar.dart';
import '../widgets/my_drawer.dart';

class MainHomePage extends StatelessWidget {
  static const routeName = 'Main Home Page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 1,
        title: Center(
          child: Text(
            "Botany Essential",
            style: ktermTextStyle,
          ),
        ),
      ),
      drawer: AppDrawer(),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Botmodel>(kbotBox).listenable(),
        builder: (BuildContext context, Box<Botmodel> value, Widget child) {
          final randInt = Random.secure().nextInt(value.length);
          final randWord = value.getAt(randInt);
          var historyItem = value.values
              .where((bot) => bot.isHistory == true)
              .toList()
                ..sort((a, b) => a.date.compareTo(b.date));
          historyItem = historyItem.reversed.toList();

          List<Botmodel> getHistory() {
            if (historyItem.length == 0) {
              return List<Botmodel>();
            }
            if (historyItem.length < 5) {
              return historyItem.sublist(0, historyItem.length);
            }
            return historyItem.sublist(0, 5);
          }

          return ListView(
            children: <Widget>[
              InkWell(
                onTap: () =>
                    showSearch(context: context, delegate: Searchbar()),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.search,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Search for a Word',
                            style: kMeaningStyle.copyWith(
                                color: Theme.of(context).primaryColor),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () =>
                    Navigator.pushNamed(context, HistoryPage.routeName),
                child: Container(
                  // color: Colors.lightGreen.shade400,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.history,
                        color: Colors.lime.shade900,
                      ),
                      SizedBox(width: 10),
                      Hero(
                        tag: "history",
                        child: Text(
                          'History',
                          style: Theme.of(context).textTheme.headline5.copyWith(
                                fontFamily: "ZillaSlab",
                                fontSize: 20,
                              ),
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                // color: Color(0xffE8EBF1)),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                child: Column(
                  children: getHistory()
                      .map(
                        (val) => InkWell(
                          onTap: () async => await Navigator.pushNamed(
                              context, DictItemScreen.routeName,
                              arguments: value.get(val.term)),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      val.term,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4
                                          .copyWith(
                                            fontStyle: FontStyle.italic,
                                            fontFamily: "ZillaSlab",
                                            fontSize: 17,
                                          ),
                                    ),
                                    Spacer(),
                                    Icon(Icons.star_border, color: Colors.amber)
                                  ],
                                ),
                                Divider()
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              Container(
                // color: Colors.lightGreen.shade400,
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.book,
                      color: Colors.lime.shade900,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Word of the Day',
                      style: Theme.of(context).textTheme.headline5.copyWith(
                            fontFamily: "ZillaSlab",
                            fontSize: 20,
                          ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              GFCard(
                color: Theme.of(context).primaryColor,
                boxFit: BoxFit.cover,
                image: Image.asset('assets/images/plant2.jpg'),
                title: GFListTile(
                  title: FittedBox(
                    child: Text(randWord.term,
                        overflow: TextOverflow.ellipsis, style: ktermTextStyle),
                  ),
                  icon: GFIconButton(
                    onPressed: () async => await Navigator.pushNamed(
                        context, DictItemScreen.routeName,
                        arguments: randWord),
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                      color: Colors.amber,
                    ),
                    type: GFButtonType.transparent,
                  ),
                ),
                content: Text(
                  randWord.meaning,
                  style: kMeaningStyle,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
