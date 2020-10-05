import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;

final String baseUrl = "http://10.0.2.2:3000/matchs";
final String token =
    "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxLCJuYW1lIjoiUmljYXJkbyBQZWxsaWNpb2xpIiwiZW1haWwiOiJwZWxsaWNpb2xpX3JAaG90bWFpbC5jb20iLCJwYXNzd29yZCI6IjEyMzQ1IiwiYWRtaW4iOjEsImNyZWF0ZWQiOiIyMDIwLTA2LTA5VDE2OjU5OjQxLjAwMFoiLCJ1cGRhdGVkIjoiMjAyMC0wNi0wOVQxNjo1OTo0MS4wMDBaIn0sImlhdCI6MTU5ODU1ODU5OX0.WQ26G_rGBnIS0DCXhpx0o5hhbTZ7GIde5zxi7NYZrgA";

Future<void> deleteMatch(int id) async {
  await http.delete(baseUrl + "/${id.toString()}",
      headers: {HttpHeaders.authorizationHeader: token});
}
