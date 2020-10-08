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
            appBar: AppBar(
              title: Text("FeedMe"),
              backgroundColor: Color.fromARGB(255, 255, 171, 124),
              centerTitle: true,
            ),
            body: FindPage(),
            drawer: CustomDrawer(_pageController)),
      ],
    );
  }
}
