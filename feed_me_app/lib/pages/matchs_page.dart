import 'package:feed_me_app/entities/user_match.dart';
import 'package:feed_me_app/models/user_model.dart';
import 'package:feed_me_app/services/users_service.dart';
import 'package:feed_me_app/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import '../services/matchs_service.dart';
import '../services/users_service.dart';
import 'food_page.dart';

class MatchsPage extends StatefulWidget {
  @override
  _MatchsPageState createState() => _MatchsPageState();
}

class _MatchsPageState extends State<MatchsPage> {
  List<UserMatch> _matchs = [];

  int _userId;
  String _token;
  UserMatch _lastRemoved;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _refresh() async {
    setState(() {
      getMatchs(_userId, _token).then((data) {
        _matchs = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildContainer();
  }

  Widget buildContainer() {
    _userId = UserModel.of(context).userData.id;
    _token = UserModel.of(context).userToken;

    return Container(
        child: FutureBuilder(
            future: getMatchs(_userId, _token),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                _matchs = snapshot.data;
                return buildList();
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }

  Widget buildList() {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(20.0, 20.0, 5.0, 20.0),
          child: Row(
            children: <Widget>[
              Text("Minhas escolhas",
                  style: TextStyle(
                      fontSize: 24.0, color: Color.fromARGB(255, 153, 77, 156)))
            ],
          ),
        ),
        Expanded(
          child: RefreshIndicator(
              onRefresh: _refresh,
              child: ListView.separated(
                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                  itemCount: _matchs.length,
                  itemBuilder: buildItem,
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Color.fromARGB(255, 220, 220, 220),
                      height: 1,
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    );
                  })),
        )
      ],
    );
  }

  Widget buildItem(BuildContext context, int index) {
    return InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => FoodPage(_matchs[index].foodId)));
        },
        child: Dismissible(
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
            contentPadding: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
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
              deleteMatch(_lastRemoved.id, _token);

              final snack = SnackBar(
                content: Text("Match com \"${_lastRemoved.name}\" removido!"),
                action: SnackBarAction(
                    label: "Desfazer",
                    onPressed: () {
                      setState(() {
                        postMatch(_userId, _lastRemoved, _token).then((id) => {
                              getMatchs(_userId, _token)
                                  .then((data) => _matchs = data)
                            });
                      });
                    }),
                duration: Duration(seconds: 5),
              );

              Scaffold.of(context).removeCurrentSnackBar();
              Scaffold.of(context).showSnackBar(snack);
            });
          },
        ));
  }
}
