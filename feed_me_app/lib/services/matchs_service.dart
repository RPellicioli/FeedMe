import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

final String baseUrl = "http://10.0.2.2:3000/matchs";
final String token =
    "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxLCJuYW1lIjoiUmljYXJkbyBQZWxsaWNpb2xpIiwiZW1haWwiOiJwZWxsaWNpb2xpX3JAaG90bWFpbC5jb20iLCJwYXNzd29yZCI6IjEyMzQ1IiwiYWRtaW4iOjEsImNyZWF0ZWQiOiIyMDIwLTA2LTA5VDE2OjU5OjQxLjAwMFoiLCJ1cGRhdGVkIjoiMjAyMC0wNi0wOVQxNjo1OTo0MS4wMDBaIn0sImlhdCI6MTU5ODU1ODU5OX0.WQ26G_rGBnIS0DCXhpx0o5hhbTZ7GIde5zxi7NYZrgA";

final String table = "match";
final String idColumn = "id";
final String userIdColumn = "userId";
final String foodIdColumn = "foodId";

Future<Match> getMatchs() async {
  final response = await http
      .get(baseUrl, headers: {HttpHeaders.authorizationHeader: token});
  final responseJson = jsonDecode(response.body);

  return Match.fromMap(responseJson);
}

class Match {
  int id;
  int userId;
  int foodId;

  Match();

  Match.fromMap(Map map) {
    id = map[idColumn];
    userId = map[userIdColumn];
    foodId = map[foodIdColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {userIdColumn: userId, foodIdColumn: foodId};

    if (id != null) {
      map[idColumn] = id;
    }

    return map;
  }
}
