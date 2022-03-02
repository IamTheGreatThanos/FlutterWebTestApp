import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_web_app/utils/const.dart';

class AuthProvider {
  String API_URL = AppConstants.mainURL;

  Future<Map<String, dynamic>> login(String login, String password) async {
    final response = await http.post(
      Uri.parse(API_URL + 'api/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body:
          jsonEncode(<String, String>{'username': login, 'password': password}),
    );

    // print(response.body);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      Map<String, dynamic> result = {'status': 'ok', 'data': data};
      return result;
    } else {
      return {'status': 'error'};
    }
  }

  Future<Map<String, dynamic>> register(
      String login, String password, String email) async {
    final response = await http.post(
      Uri.parse(API_URL + 'api/registration'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        "username": login,
        "password": password,
        "email": email
      }),
    );

    // print(response.body);

    if (response.statusCode == 201) {
      Map<String, dynamic> data = jsonDecode(response.body);
      Map<String, dynamic> result = {'status': 'ok', 'data': data};
      return result;
    } else {
      return {'status': 'error'};
    }
  }
}
