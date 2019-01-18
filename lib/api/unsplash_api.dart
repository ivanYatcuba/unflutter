import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:unflutter/api/model.dart';

class UnpslashApi {
  final String unsplashBaseUrl = "https://api.unsplash.com";

  Future<UserInfo> fetchUserInfo(String token) async {
    final response = await http.get("$unsplashBaseUrl/me",
        headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      return UserInfo.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user info');
    }
  }
}
