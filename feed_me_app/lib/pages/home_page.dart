import 'package:feed_me_app/pages/matchs_page.dart';
import 'package:feed_me_app/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

import 'find_page.dart';

class HomePage extends StatelessWidget {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
            appBar: createAppBar(),
            body: FindPage(),
            drawer: CustomDrawer(_pageController)),
        Scaffold(
            appBar: createAppBar(),
            body: MatchsPage(),
            drawer: CustomDrawer(_pageController))
      ],
    );
  }

  Widget createAppBar() {
    return AppBar(
      title: Text("FeedMe",
          style: TextStyle(
              fontFamily: 'Righteous',
              fontSize: 18.0,
              color: Colors.white)),
      backgroundColor: Color(0xFFf45d27),
      centerTitle: true,
    );
  }
}