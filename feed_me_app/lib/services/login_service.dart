import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'global_service.dart';

final String pathUrl = "login";

Future<Map<String, dynamic>> login(String email, String password) async {
  try{
    final response = await http.post(baseUrl + pathUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'email': email, 'password': password}));

    final responseJson = jsonDecode(response.body);

    Map<String, dynamic> result = {
      "loggedIn": true,
      "userId": responseJson['userId'],
      "token": responseJson['token']
    };

    return result;
  }catch(error){
    print(error);
    return Map();
  }
}
