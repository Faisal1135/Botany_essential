import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import '../constant.dart';
import '../helper/helper_function.dart';
import '../models/botmodel.dart';
import '../screens/dictonary_details.dart';

class Searchbar extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    //
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final searchlist = Hive.box<Botmodel>(kbotBox)
        .values
        .where((bot) => bot.term.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return searchlist.isEmpty
        ? Center(child: Text("No content Found"))
        : ListView.builder(
            itemCount: searchlist.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                  onTap: () async {
                    await HelperFunction.addToHistory(searchlist[index].term);
                    Navigator.pushNamed(context, DictItemScreen.routeName,
                        arguments: searchlist[index]);
                  },
                  leading: Hero(
                    transitionOnUserGestures: true,
                    tag: "${searchlist[index].id}",
                    child: CircleAvatar(
                      child: FaIcon(
                        FontAwesomeIcons.tree,
                        color: Colors.green,
                      ),
                      radius: 20,
                      backgroundColor: Colors.amber,
                    ),
                  ),
                  title: Text(searchlist[index].term));
            },
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // implement buildSuggestions
    final searchlist = Hive.box<Botmodel>(kbotBox)
        .values
        .where((bot) => bot.term.toLowerCase().startsWith(query.toLowerCase()))
        .toList();

    return query.isEmpty
        ? Container()
        : ListView.builder(
            itemCount: searchlist.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onTap: () async {
                  await HelperFunction.addToHistory(searchlist[index].term);
                  Navigator.pushNamed(context, DictItemScreen.routeName,
                      arguments: searchlist[index]);
                },
                leading: Hero(
                  transitionOnUserGestures: true,
                  tag: "${searchlist[index].id}",
                  child: CircleAvatar(
                    child: FaIcon(
                      FontAwesomeIcons.tree,
                      color: Colors.green,
                    ),
                    radius: 20,
                    backgroundColor: Colors.amber,
                  ),
                ),
                title: RichText(
                  text: TextSpan(
                    text: searchlist[index].term.substring(0, query.length),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: "Alegreya"),
                    children: [
                      TextSpan(
                        text: searchlist[index].term.substring(query.length),
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ),
              );
            },
          );
  }
}
