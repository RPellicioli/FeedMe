import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:feed_me_app/entities/food.dart';
import 'package:http/http.dart' as http;

import 'global_service.dart';
import 'package:geolocator/geolocator.dart';

final String pathUrl = "foods";

Future<Food> getRandomFood(
    token, Position currentPosition, double km, {List<int> foodIds}) async {

  String listParams = "";

  if(foodIds != null){
    foodIds.forEach((id) {
      listParams += "&foodIds=" + id.toString();
    });
  }

  String url = baseUrl +
      pathUrl +
      "/random?km=${km.toString()}&lat=${currentPosition.latitude.toString()}&lon=${currentPosition.longitude.toString()}" +
      listParams;
  
  final response = await http.get(url,
      headers: {HttpHeaders.authorizationHeader: 'Bearer ' + token});
  final responseJson = jsonDecode(response.body);

  return Food.fromJson(responseJson);
}

Future<Food> getFood(int id, String token, Position currentPosition) async {
  final response = await http.get(baseUrl + pathUrl + "/${id.toString()}" +
      "?lat=${currentPosition.latitude.toString()}&lon=${currentPosition.longitude.toString()}",
      headers: {HttpHeaders.authorizationHeader: 'Bearer ' + token});
  final responseJson = jsonDecode(response.body);

  return Food.fromJson(responseJson);
}

Future<void> deleteMatch(int id, String token) async {
  await http.delete(baseUrl + pathUrl + "/${id.toString()}",
      headers: {HttpHeaders.authorizationHeader: 'Bearer ' + token});
}

Future<int> postFood(Food food, String token) async {
  final response = await http.post(baseUrl + pathUrl,
      headers: {HttpHeaders.authorizationHeader: 'Bearer ' + token},
      body: jsonEncode(food));

  final responseJson = jsonDecode(response.body);

  return responseJson['id'];
}

Future<String> updateFood(int id, Food food, String token) async {
  await http.put(baseUrl + pathUrl + "/${id.toString()}",
      headers: {HttpHeaders.authorizationHeader: 'Bearer ' + token},
      body: jsonEncode(food));

  return "Atualizado";
}

Future<String> uploadImageFood(File file, String token) async {
  final response = await http.post(baseUrl + pathUrl + "/upload",
      headers: {HttpHeaders.authorizationHeader: 'Bearer ' + token},
      body: jsonEncode(file));

  return response.body;
}
