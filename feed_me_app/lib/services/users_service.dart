import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:feed_me_app/models/restaurant.dart';
import 'package:feed_me_app/models/user_match.dart';
import 'package:http/http.dart' as http;

final String baseUrl = "http://10.0.2.2:3000/users";
final String token =
    "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxLCJuYW1lIjoiUmljYXJkbyBQZWxsaWNpb2xpIiwiZW1haWwiOiJwZWxsaWNpb2xpX3JAaG90bWFpbC5jb20iLCJwYXNzd29yZCI6IjEyMzQ1IiwiYWRtaW4iOjEsImNyZWF0ZWQiOiIyMDIwLTA2LTA5VDE2OjU5OjQxLjAwMFoiLCJ1cGRhdGVkIjoiMjAyMC0wNi0wOVQxNjo1OTo0MS4wMDBaIn0sImlhdCI6MTU5ODU1ODU5OX0.WQ26G_rGBnIS0DCXhpx0o5hhbTZ7GIde5zxi7NYZrgA";

Future<UserMatch> getMatchs() async {
  final response = await http.get(baseUrl + "/1/matchs",
      headers: {HttpHeaders.authorizationHeader: token});
  final responseJson = jsonDecode(response.body);

  return UserMatch.fromMap(responseJson);
}

Future<Restaurant> getRestaurant() async {
  final response = await http.get(baseUrl + "/1/restaurant",
      headers: {HttpHeaders.authorizationHeader: token});
  final responseJson = jsonDecode(response.body);

  return Restaurant.fromMap(responseJson);
}
