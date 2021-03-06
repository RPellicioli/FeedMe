import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:feed_me_app/entities/restaurant.dart';
import 'package:feed_me_app/entities/schedule.dart';
import 'package:http/http.dart' as http;

import 'global_service.dart';

final String pathUrl = "restaurants";

Future<List<Schedule>> getSchedules(int id, String token) async {
  final response = await http.get(
      baseUrl + pathUrl + "/${id.toString()}/schedule",
      headers: {HttpHeaders.authorizationHeader: 'Bearer ' + token});
  final responseJson = jsonDecode(response.body);

  return (responseJson as List).map((i) {
    return Schedule.fromJson(i);
  }).toList();
}

Future<int> postRestaurant(Restaurant restaurant, String token) async {
  final response = await http.post(baseUrl + pathUrl,
      headers: {HttpHeaders.authorizationHeader: 'Bearer ' + token},
      body: jsonEncode(restaurant));

  final responseJson = jsonDecode(response.body);

  return responseJson['id'];
}

Future<String> updateRestaurant(int id, Restaurant restaurant, String token) async {
  await http.put(baseUrl + pathUrl + "/${id.toString()}",
      headers: {HttpHeaders.authorizationHeader: 'Bearer ' + token},
      body: jsonEncode(restaurant));

  return "Atualizado";
}
