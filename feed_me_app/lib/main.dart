import 'package:feed_me_app/pages/matchs_page.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'models/user_model.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: ScopedModelDescendant<UserModel>(builder: (context, child, model) {
        return MaterialApp(
            title: "FeedMe",
            theme: ThemeData(
                primarySwatch: Colors.deepOrange,
                primaryColor: Color.fromARGB(255, 255, 171, 124)),
            debugShowCheckedModeBanner: false,
            home: MatchsPage());
      }),
    );
  }
}

//orange Color.fromARGB(255, 255, 171, 124);
//green Color.fromARGB(255, 119, 195, 72);
//red Color.fromARGB(255, 252, 78, 78);
//purple Color.fromARGB(255, 153, 77, 156);
