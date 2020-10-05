import 'package:feed_me_app/services/matchs_service.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class MatchsPage extends StatefulWidget {
  @override
  _MatchsPageState createState() => _MatchsPageState();
}

class _MatchsPageState extends State<MatchsPage> {
  List _matchs = [];

  @override
  void initState() {
    super.initState();

    setState(() {
      getMatchs().then((value) => debugPrint(value.toString()));
      startList();
    });
  }

  void startList() {
    _matchs.add({"id": 0, "title": "Vatapá", "image": ""});
    _matchs.add({"id": 1, "title": "Bacon", "image": ""});
    _matchs.add({"id": 2, "title": "Camarão", "image": ""});
  }

  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      startList();
    });

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("FeedMe"),
          backgroundColor: Colors.deepOrange,
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              child: Row(
                children: <Widget>[
                  Text("Seus matchs",
                      style:
                          TextStyle(fontSize: 18.0, color: Colors.deepPurple))
                ],
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                  onRefresh: _refresh,
                  child: ListView.builder(
                      padding: EdgeInsets.only(top: 6.0),
                      itemCount: _matchs.length,
                      itemBuilder: buildItem)),
            )
          ],
        ));
  }

  Widget buildItem(BuildContext context, int index) {
    return Dismissible(
      key: Key(_matchs[index]["id"]),
      background: Container(
        color: Colors.red,
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
        leading: CircleAvatar(
          radius: 30.0,
          backgroundImage: NetworkImage(_matchs[index]["image"]),
          backgroundColor: Colors.transparent,
        ),
        title: Text(_matchs[index]["title"]),
      ),
      onDismissed: (direction) {
        setState(() {
          _matchs.removeAt(index);
        });
      },
    );
  }
}
