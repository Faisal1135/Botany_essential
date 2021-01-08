import '../screens/dictonary_details.dart';
import '../widgets/my_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constant.dart';
import '../models/botmodel.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoritePage extends StatelessWidget {
  static const routeName = "/favorite-page";
  const FavoritePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Botmodel>(kbotBox).listenable(),
        builder: (BuildContext context, Box<Botmodel> value, Widget child) {
          final allBotList =
              value.values.where((bot) => bot.isFavorite == true).toList();
          return CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 200,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    "Bookmarks",
                    style: ktermTextStyle,
                  ),
                  background: Container(
                      child: Icon(
                    Icons.bookmark,
                    size: 100,
                    color: Colors.amber,
                  )),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: allBotList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          onTap: () => Navigator.pushNamed(
                              context, DictItemScreen.routeName,
                              arguments: allBotList[index]),
                          leading: CircleAvatar(
                            backgroundColor: Colors.blueGrey,
                            radius: 30,
                            child: Hero(
                              tag: "${allBotList[index].id}",
                              child: FaIcon(
                                FontAwesomeIcons.tree,
                                color: Colors.green,
                                size: 30,
                              ),
                            ),
                          ),
                          title: Text(allBotList[index].term),
                          subtitle: Text(
                            allBotList[index].meaning,
                            maxLines: 4,
                          ),
                          trailing: IconButton(
                            icon: allBotList[index].isFavorite
                                ? Icon(Icons.star, color: Colors.amber)
                                : Icon(Icons.star_border, color: Colors.amber),
                            onPressed: () async {
                              var item = value.get(allBotList[index].term);
                              item.isFavorite = !item.isFavorite;
                              await value.put(allBotList[index].term, item);
                            },
                          ),
                        );
                      },
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
