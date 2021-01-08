import '../helper/helper_function.dart';
import '../models/botmodel.dart';
import '../screens/dictonary_details.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SingelListTile extends StatelessWidget {
  const SingelListTile({
    Key key,
    @required this.allBotData,
    this.primary,
  }) : super(key: key);

  final List<Botmodel> allBotData;
  final bool primary;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      primary: primary == null,
      shrinkWrap: primary != null,
      itemCount: allBotData.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          onTap: () => Navigator.pushNamed(context, DictItemScreen.routeName,
              arguments: allBotData[index]),
          leading: CircleAvatar(
            backgroundColor: const Color(0xff00e278),
            radius: 30,
            child: Hero(
              tag: "${allBotData[index].id}",
              child: FaIcon(
                FontAwesomeIcons.tree,
                color: Color(0xffADFF00),
                size: 30,
              ),
            ),
          ),
          title: Text(allBotData[index].term),
          subtitle: Text(
            allBotData[index].meaning,
            maxLines: 4,
          ),
          trailing: IconButton(
            icon: allBotData[index].isFavorite
                ? Icon(Icons.star, color: Colors.amber)
                : Icon(Icons.star_border, color: Colors.amber),
            onPressed: () async {
              await HelperFunction.togglefavorite(allBotData[index].term);
            },
          ),
        );
      },
    );
  }
}
