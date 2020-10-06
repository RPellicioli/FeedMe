import 'package:feed_me_app/models/user_match.dart';
import 'package:feed_me_app/services/users_service.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import '../services/matchs_service.dart';
import '../services/users_service.dart';

class MatchsPage extends StatefulWidget {
  @override
  _MatchsPageState createState() => _MatchsPageState();
}

class _MatchsPageState extends State<MatchsPage> {
  List<UserMatch> _matchs = [];

  UserMatch _lastRemoved;

  @override
  void initState() {
    super.initState();

    setState(() {
      getMatchs().then((data) => _matchs = data);
    });
  }

  Future<void> _refresh() async {
    setState(() {
      getMatchs().then((data) => _matchs = data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("FeedMe", style: TextStyle(color: Colors.white)),
          backgroundColor: Color.fromARGB(255, 255, 171, 124),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
              child: Row(
                children: <Widget>[
                  Text("Seus matchs",
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Color.fromARGB(255, 153, 77, 156)))
                ],
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                  onRefresh: _refresh,
                  child: ListView.builder(
                      padding: EdgeInsets.fromLTRB(0.0, 20.0, 20.0, 20.0),
                      itemCount: _matchs.length,
                      itemBuilder: buildItem)),
            )
          ],
        ));
  }

  Widget buildItem(BuildContext context, int index) {
    return Dismissible(
      key: Key(_matchs[index].id.toString()),
      background: Container(
        color: Color.fromARGB(255, 252, 78, 78),
        child: Align(
          alignment: Alignment(-0.9, 0.0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      direction: DismissDirection.startToEnd,
      child: ListTile(
        contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
        leading: CircleAvatar(
          radius: 30.0,
          backgroundImage: NetworkImage(_matchs[index].image),
          backgroundColor: Colors.transparent,
        ),
        title: Text(_matchs[index].name),
      ),
      onDismissed: (direction) {
        setState(() {
          _lastRemoved = _matchs[index];

          _matchs.removeAt(index);
          deleteMatch(_matchs[index].id);

          final snack = SnackBar(
            content: Text("Match com \"${_lastRemoved.name}\" removido!"),
            action: SnackBarAction(
                label: "Desfazer",
                onPressed: () {
                  setState(() {
                    postMatch(_matchs[index]).then(
                        (id) => {getMatchs().then((data) => _matchs = data)});
                  });
                }),
            duration: Duration(seconds: 5),
          );

          Scaffold.of(context).removeCurrentSnackBar();
          Scaffold.of(context).showSnackBar(snack);
        });
      },
    );
  }
}
