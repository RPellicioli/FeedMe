import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:feed_me_app/entities/user_match.dart';
import 'package:http/http.dart' as http;

import 'global_service.dart';

final String pathUrl = "matchs";

Future<void> deleteMatch(int id, String token) async {
  await http.delete(baseUrl + pathUrl + "/${id.toString()}",
      headers: {HttpHeaders.authorizationHeader: 'Bearer ' + token});
}

Future<int> postMatch(int userId, int foodId, String token) async {
  final response = await http.post(baseUrl + pathUrl,
      headers: {HttpHeaders.authorizationHeader: 'Bearer ' + token},
      body: {'userId': userId.toString(), 'foodId': foodId.toString()});

  final responseJson = jsonDecode(response.body);

  return responseJson['id'];
}
