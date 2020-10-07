import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:feed_me_app/models/restaurant.dart';
import 'package:feed_me_app/models/user_match.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';
import 'global_service.dart';

final String pathUrl = "users";

Future<User> getUser() async {
  final response = await http.get(baseUrl + pathUrl + "/${userId.toString()}",
      headers: {HttpHeaders.authorizationHeader: token});
  final responseJson = jsonDecode(response.body);

  return User.fromJson(responseJson);
}

Future<List<UserMatch>> getMatchs() async {
  final response = await http.get(
      baseUrl + pathUrl + "/${userId.toString()}/matchs",
      headers: {HttpHeaders.authorizationHeader: token});
  final responseJson = jsonDecode(response.body);

  return (responseJson as List).map((i) {
    return UserMatch.fromJson(i);
  }).toList();
}

Future<Restaurant> getRestaurant() async {
  final response = await http.get(
      baseUrl + pathUrl + "/${userId.toString()}/restaurant",
      headers: {HttpHeaders.authorizationHeader: token});
  final responseJson = jsonDecode(response.body);

  return Restaurant.fromJson(responseJson);
}

Future<void> deleteAllMatchs() async {
  await http.delete(baseUrl + pathUrl + "/${userId.toString()}/matchs",
      headers: {HttpHeaders.authorizationHeader: token});
}

Future<int> postUser(User user) async {
  final response = await http.post(baseUrl + pathUrl,
      headers: {HttpHeaders.authorizationHeader: token},
      body: jsonEncode(user));

  final responseJson = jsonDecode(response.body);

  return responseJson['id'];
}

Future<String> updateUser(int id, User user) async {
  final response = await http.put(baseUrl + pathUrl + "/${id.toString()}",
      headers: {HttpHeaders.authorizationHeader: token},
      body: jsonEncode(user));

  return response.body;
}
