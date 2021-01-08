import '../constant.dart';
import '../helper/helper_function.dart';
import '../screens/show_list_of_alpha.dart';
import 'package:flutter/material.dart';

class Griditem extends StatelessWidget {
  final String title;

  const Griditem({
    Key key,
    this.title,
  }) : super(key: key);

  showAlphaListPage(String alpha, BuildContext context) async {
    final arglist = HelperFunction.findWithAlpha(alpha);
    await Navigator.pushNamed(context, ListAccordingToaAlpha.routeName,
        arguments: arglist);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showAlphaListPage(title, context),
      splashColor: Colors.amber,
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                title.toUpperCase(),
                style: ktermTextStyle,
              ),
              Text(
                "${HelperFunction.findWithAlpha(title).length} words ",
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).accentColor,
                Theme.of(context).primaryColor
              ]),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
