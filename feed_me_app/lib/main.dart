import 'package:feed_me_app/ui/home_page.dart';
import 'package:feed_me_app/ui/matchs_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      home: MatchsPage(),
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        primaryColor: Color.fromARGB(255, 255, 171, 124),
      ),
      debugShowCheckedModeBanner: false));
}

//orange Color.fromARGB(255, 255, 171, 124);
//green Color.fromARGB(255, 119, 195, 72);
//red Color.fromARGB(255, 252, 78, 78);
//purple Color.fromARGB(255, 153, 77, 156);
