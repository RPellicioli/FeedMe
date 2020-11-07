import 'package:feed_me_app/pages/matchs_page.dart';
import 'package:feed_me_app/services/users_service.dart';
import 'package:feed_me_app/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:feed_me_app/models/user_model.dart';

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
            appBar: createAppBar(context),
            body: FindPage(),
            drawer: CustomDrawer(_pageController)),
        Scaffold(
            appBar: createAppBarMatchs(context, _pageController),
            body: MatchsPage(),
            drawer: CustomDrawer(_pageController))
      ],
    );
  }

  Widget createAppBar(BuildContext context) {
    return AppBar(
      title: Text("FeedMe",
          style: TextStyle(
              fontFamily: 'Righteous', fontSize: 18.0, color: Colors.white)),
      backgroundColor: Color(0xFFf45d27),
      centerTitle: true,
    );
  }

  Widget createAppBarMatchs(BuildContext context, PageController pageController) {
    return AppBar(
        title: Text("FeedMe",
            style: TextStyle(
                fontFamily: 'Righteous', fontSize: 18.0, color: Colors.white)),
        backgroundColor: Color(0xFFf45d27),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever,
                color: Colors.white),
            onPressed: () async {
              showAlertDialog(context, pageController);
            },
          )
        ]);
  }

  showAlertDialog(BuildContext context, PageController pageController) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancelar"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );

    Widget continueButton = FlatButton(
      child: Text("Sim"),
      onPressed:  () async {
        await deleteAllMatchs(UserModel.of(context).userData.id, UserModel.of(context).userToken);
        pageController.jumpToPage(2);
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Deletar lista"),
      content: Text("Você realmente deseja apagar suas escolhas?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
