import 'package:feed_me_app/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'models/user_model.dart';

void main() async {
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget _page;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: ScopedModelDescendant<UserModel>(builder: (context, child, model) {
        return MaterialApp(
            title: "FeedMe",
            theme: ThemeData(
                fontFamily: 'Mulish',
                primarySwatch: Colors.deepOrange,
                primaryColor: Color(0xFFf45d27)),
            debugShowCheckedModeBanner: false,
            home: LoginPage());
      }),
    );
  }
}


//orange Color(0xFFf45d27);
//green Color.fromARGB(255, 119, 195, 72);
//red Color.fromARGB(255, 252, 78, 78);
//purple Color.fromARGB(255, 153, 77, 156);
