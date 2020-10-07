import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'global_service.dart';

final String pathUrl = "login";

Future<void> login(String email, String password) async {
  final response = await http.post(baseUrl + pathUrl,
      headers: {HttpHeaders.authorizationHeader: token},
      body: jsonEncode(<String, String>{'email': email, 'password': password}));

  final responseJson = jsonDecode(response.body);

  loggedIn = true;
  userId = responseJson['userId'];
  token = responseJson['token'];
}

void logout() {
  userId = null;
  token = null;
  loggedIn = false;
}
