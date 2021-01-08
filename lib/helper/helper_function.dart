import 'package:hive/hive.dart';
import '../models/botmodel.dart';

import '../constant.dart';

class HelperFunction {
  static Future<void> togglefavorite(String term) async {
    final botbox = Hive.box<Botmodel>(kbotBox);

    var bot = botbox.get(term);
    bot.isFavorite = !bot.isFavorite;
    await botbox.put(term, bot);
  }

  static List<Botmodel> findWithAlpha(String alpha) {
    final allList = Hive.box<Botmodel>(kbotBox).values.toList();
    final startsWithAlpha = allList
        .where((bot) => bot.term.toLowerCase().startsWith(alpha.toLowerCase()))
        .toList();
    return startsWithAlpha;
  }

  static Future<void> addToHistory(String term) async {
    final botbox = Hive.box<Botmodel>(kbotBox);
    var botitem = botbox.get(term);
    botitem.isHistory = true;
    botitem.date = DateTime.now();
    await botbox.put(term, botitem);
  }
}
