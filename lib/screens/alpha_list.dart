import '../widgets/my_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/alpha_grid.dart';
import 'package:flutter/material.dart';
import '../constant.dart';

class ALphaListScreen extends StatelessWidget {
  static const routeName = "/alpha-list-page";
  const ALphaListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: AppDrawer(),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: size.height * 0.3,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
                title: const Text(
                  "Alphabetic Order",
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                      fontFamily: "ZillaSlab",
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
                background: Container(
                  color: Colors.amber,
                  padding: EdgeInsets.only(
                      top: size.height * 0.3 / 5, left: size.width / 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FaIcon(
                        FontAwesomeIcons.tree,
                        color: Colors.green.shade600,
                        size: 100,
                      ),
                      FaIcon(
                        FontAwesomeIcons.tree,
                        color: Colors.green.shade600,
                        size: 100,
                      ),
                      FaIcon(
                        FontAwesomeIcons.tree,
                        color: Colors.green.shade600,
                        size: 100,
                      ),
                    ],
                  ),
                )),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            GridView(
              shrinkWrap: true,
              primary: false,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              padding: const EdgeInsets.all(16),
              children: kalphaList
                  .map(
                    (alpha) => Griditem(
                      title: alpha,
                    ),
                  )
                  .toList(),
            ),
          ]))
          // SliverAnimatedList(itemBuilder: null)
        ],
      ),
    );
  }
}
