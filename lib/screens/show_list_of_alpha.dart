import '../constant.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/botmodel.dart';
import '../widgets/singel_Iist_item.dart';
import 'package:flutter/material.dart';

class ListAccordingToaAlpha extends StatelessWidget {
  static const routeName = "list-according-to-alpha";

  @override
  Widget build(BuildContext context) {
    final allbotList =
        ModalRoute.of(context).settings.arguments as List<Botmodel>;

    String alpha = allbotList.first.term[0].toLowerCase();

    return Scaffold(
      appBar: AppBar(
        title: Text("${allbotList.first.term[0]} -List"),
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: Hive.box<Botmodel>(kbotBox).listenable(),
          builder: (BuildContext context, Box<Botmodel> value, Widget child) {
            var alphaList = value.values
                .where((bot) => bot.term.toLowerCase().startsWith(alpha))
                .toList();
            return SingelListTile(allBotData: alphaList);
          },
        ),
      ),
    );
  }
}
