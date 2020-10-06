import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:feed_me_app/models/restaurant.dart';
import 'package:feed_me_app/models/user_match.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';

final int userId = 2;
final String baseUrl = "http://10.0.2.2:3000/users";
final String token =
    "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxLCJuYW1lIjoiUmljYXJkbyBQZWxsaWNpb2xpIiwiZW1haWwiOiJwZWxsaWNpb2xpX3JAaG90bWFpbC5jb20iLCJwYXNzd29yZCI6IjEyMzQ1IiwiYWRtaW4iOjEsImNyZWF0ZWQiOiIyMDIwLTA2LTA5VDE2OjU5OjQxLjAwMFoiLCJ1cGRhdGVkIjoiMjAyMC0wNi0wOVQxNjo1OTo0MS4wMDBaIn0sImlhdCI6MTU5ODU1ODU5OX0.WQ26G_rGBnIS0DCXhpx0o5hhbTZ7GIde5zxi7NYZrgA";

Future<List<UserMatch>> getMatchs() async {
  final response = await http.get(baseUrl + "/${userId.toString()}/matchs",
      headers: {HttpHeaders.authorizationHeader: token});
  final responseJson = jsonDecode(response.body);

  return (responseJson as List).map((i) {
    return UserMatch.fromJson(i);
  }).toList();
}

Future<Restaurant> getRestaurant() async {
  final response = await http.get(baseUrl + "/${userId.toString()}/restaurant",
      headers: {HttpHeaders.authorizationHeader: token});
  final responseJson = jsonDecode(response.body);

  return Restaurant.fromJson(responseJson);
}

Future<void> deleteAllMatchs() async {
  await http.delete(baseUrl + "/${userId.toString()}/matchs",
      headers: {HttpHeaders.authorizationHeader: token});
}

Future<int> postUser(User user) async {
  final response = await http.post(baseUrl,
      headers: {HttpHeaders.authorizationHeader: token},
      body: jsonEncode(user));

  final responseJson = jsonDecode(response.body);

  return responseJson['id'];
}

Future<String> updateUser(int id, User user) async {
  final response = await http.put(baseUrl + "/${id.toString()}",
      headers: {HttpHeaders.authorizationHeader: token},
      body: jsonEncode(user));

  return response.body;
}
