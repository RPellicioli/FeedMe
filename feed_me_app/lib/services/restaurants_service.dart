import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/restaurant.dart';
import '../models/schedule.dart';
import 'global_service.dart';

final String pathUrl = "restaurants";

Future<List<Schedule>> getSchedules(int id) async {
  final response = await http.get(
      baseUrl + pathUrl + "/${id.toString()}/schedule",
      headers: {HttpHeaders.authorizationHeader: token});
  final responseJson = jsonDecode(response.body);

  return (responseJson as List).map((i) {
    return Schedule.fromJson(i);
  }).toList();
}

Future<int> postRestaurant(Restaurant restaurant) async {
  final response = await http.post(baseUrl + pathUrl,
      headers: {HttpHeaders.authorizationHeader: token},
      body: jsonEncode(restaurant));

  final responseJson = jsonDecode(response.body);

  return responseJson['id'];
}

Future<String> updateRestaurant(int id, Restaurant restaurant) async {
  await http.put(baseUrl + pathUrl + "/${id.toString()}",
      headers: {HttpHeaders.authorizationHeader: token},
      body: jsonEncode(restaurant));

  return "Atualizado";
}
