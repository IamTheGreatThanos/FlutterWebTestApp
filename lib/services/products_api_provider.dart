import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_web_app/utils/const.dart';

class ProductsProvider {
  String API_URL = AppConstants.mainURL;

  Future<Map<String, dynamic>> register(
      String login, String password, String email) async {
    final response = await http.post(
      Uri.parse(API_URL + 'api/auth/register'),
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

    print(response.body);

    if (response.statusCode == 201) {
      Map<String, dynamic> result = jsonDecode(response.body);
      return result;
    } else {
      return {'status': 'Error'};
    }
  }

  Future<Map<String, dynamic>> getRecommendations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    final response = await http.get(
      Uri.parse(API_URL + 'api/recommendation/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': "Token $token"
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(utf8.decode(response.body.codeUnits));
      Map<String, dynamic> result = {'status': 'ok', 'data': data};
      return result;
    } else {
      return {'status': 'error'};
    }
  }

  Future<Map<String, dynamic>> getTops() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    final response = await http.get(
      Uri.parse(API_URL + 'api/tops/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': "Token $token"
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(utf8.decode(response.body.codeUnits));
      Map<String, dynamic> result = {'status': 'ok', 'data': data};
      return result;
    } else {
      return {'status': 'error'};
    }
  }
}
