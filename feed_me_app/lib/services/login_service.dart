import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'global_service.dart';

final String pathUrl = "login";

Future<Map<String, dynamic>> login(String email, String password) async {
  final response = await http.post(baseUrl + pathUrl,
      body: jsonEncode(<String, String>{'email': email, 'password': password}));

  final responseJson = jsonDecode(response.body);

  Map<String, dynamic> result = {
    "loggedIn": true,
    "userId": responseJson['userId'],
    "token": responseJson['token']
  };
  return result;
}
