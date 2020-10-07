import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:feed_me_app/models/food.dart';
import 'package:http/http.dart' as http;

import 'global_service.dart';

final String pathUrl = "foods";

Future<Food> getRandomFood(double lat, double lon, List<int> listIds) async {
  final response = await http.get(
      baseUrl + pathUrl + "?lat=${lat.toString()}&lon=${lon.toString()}",
      headers: {HttpHeaders.authorizationHeader: token});
  final responseJson = jsonDecode(response.body);

  return Food.fromJson(responseJson);
}

Future<Food> getFood(int id) async {
  final response = await http.get(baseUrl + pathUrl + "/${id.toString()}",
      headers: {HttpHeaders.authorizationHeader: token});
  final responseJson = jsonDecode(response.body);

  return Food.fromJson(responseJson);
}

Future<void> deleteMatch(int id) async {
  await http.delete(baseUrl + pathUrl + "/${id.toString()}",
      headers: {HttpHeaders.authorizationHeader: token});
}

Future<int> postFood(Food food) async {
  final response = await http.post(baseUrl + pathUrl,
      headers: {HttpHeaders.authorizationHeader: token},
      body: jsonEncode(food));

  final responseJson = jsonDecode(response.body);

  return responseJson['id'];
}

Future<String> updateFood(int id, Food food) async {
  await http.put(baseUrl + pathUrl + "/${id.toString()}",
      headers: {HttpHeaders.authorizationHeader: token},
      body: jsonEncode(food));

  return "Atualizado";
}

Future<String> uploadImageFood(File file) async {
  final response = await http.post(baseUrl + pathUrl + "/upload",
      headers: {HttpHeaders.authorizationHeader: token},
      body: jsonEncode(file));

  return response.body;
}
