import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/user_match.dart';
import 'global_service.dart';

final String pathUrl = "matchs";

Future<void> deleteMatch(int id) async {
  await http.delete(baseUrl + pathUrl + "/${id.toString()}",
      headers: {HttpHeaders.authorizationHeader: token});
}

Future<int> postMatch(UserMatch userMatch) async {
  final response = await http.post(baseUrl + pathUrl,
      headers: {HttpHeaders.authorizationHeader: token},
      body: jsonEncode(
          <String, dynamic>{'userId': userId, 'foodId': userMatch.foodId}));

  final responseJson = jsonDecode(response.body);

  return responseJson['id'];
}
