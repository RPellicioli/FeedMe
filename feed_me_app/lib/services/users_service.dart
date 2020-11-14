import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:feed_me_app/entities/restaurant.dart';
import 'package:feed_me_app/entities/user.dart';
import 'package:feed_me_app/entities/user_match.dart';
import 'package:http/http.dart' as http;

import 'global_service.dart';

final String pathUrl = "users";

Future<User> getUser(int id, String userToken) async {
  final response = await http.get(baseUrl + pathUrl + "/${id.toString()}",
      headers: {HttpHeaders.authorizationHeader: "Bearer " + userToken});
  final responseJson = jsonDecode(response.body);

  return User.fromJson(responseJson);
}

Future<List<UserMatch>> getMatchs(int userId, String token) async {
  try {
    final response = await http.get(
        baseUrl + pathUrl + "/${userId.toString()}/matchs",
        headers: {HttpHeaders.authorizationHeader: "Bearer " + token});
    final responseJson = jsonDecode(response.body);

    return (responseJson as List).map((i) {
      return UserMatch.fromJson(i);
    }).toList();
  } catch (error) {
    print(error);
    return List();
  }
}

Future<Restaurant> getRestaurant(int userId, String token) async {
  final response = await http.get(
      baseUrl + pathUrl + "/${userId.toString()}/restaurant",
      headers: {HttpHeaders.authorizationHeader: 'Bearer ' + token});
  final responseJson = jsonDecode(response.body);

  return Restaurant.fromJson(responseJson);
}

Future<void> deleteAllMatchs(int userId, String token) async {
  await http.delete(baseUrl + pathUrl + "/${userId.toString()}/matchs",
      headers: {HttpHeaders.authorizationHeader: 'Bearer ' + token});
}

Future<int> postUser(User user) async {
  final response = await http.post(baseUrl + pathUrl,
      body: {
        'name': user.name,
        'email': user.email,
        'password': user.password,
        'admin': '0'
      });

  final responseJson = jsonDecode(response.body);
  print(responseJson);

  return responseJson['id'];
}

Future<String> updateUser(int userId, User user, String token) async {
  final response = await http.put(baseUrl + pathUrl + "/${userId.toString()}",
      headers: {HttpHeaders.authorizationHeader: 'Bearer ' + token},
      body: jsonEncode(user));

  return response.body;
}
