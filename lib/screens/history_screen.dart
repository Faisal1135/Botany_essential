import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../widgets/my_drawer.dart';
import '../models/botmodel.dart';
import '../widgets/singel_Iist_item.dart';
import '../constant.dart';

class HistoryPage extends StatelessWidget {
  static const routeName = "/history-page";
  const HistoryPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Botmodel>(kbotBox).listenable(),
        builder: (BuildContext context, Box<Botmodel> value, Widget child) {
          List<Botmodel> gethistory() {
            var histlist =
                value.values.where((bot) => bot.isHistory == true).toList();
            histlist.sort((a, b) => a.date.compareTo(b.date));
            var sortedHistory = histlist.reversed.toList();
            return sortedHistory;
          }

          return CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 200,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Hero(
                    tag: "history",
                    child: Text(
                      "Your History",
                      style: ktermTextStyle,
                    ),
                  ),
                  background: Container(
                    child: Icon(
                      Icons.history,
                      size: 70,
                      color: Colors.amber,
                    ),
                    color: Colors.green,
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      child: SingelListTile(
                        allBotData: gethistory(),
                        primary: true,
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
