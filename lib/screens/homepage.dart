import '../widgets/my_drawer.dart';
import '../widgets/singel_Iist_item.dart';
import '../constant.dart';
import '../models/botmodel.dart';
import '../screens/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Homepage extends StatefulWidget {
  static const routeName = "/homepage";
  const Homepage({Key key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Botany essential'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: Searchbar(),
                );
              },
            ),
          ],
        ),
        drawer: AppDrawer(),
        body: ValueListenableBuilder(
          valueListenable: Hive.box<Botmodel>(kbotBox).listenable(),
          builder: (BuildContext context, Box<Botmodel> value, Widget child) {
            List<Botmodel> allBotData = value.values.toList();
            return SingelListTile(allBotData: allBotData);
          },
        ),
      ),
    );
  }
}
