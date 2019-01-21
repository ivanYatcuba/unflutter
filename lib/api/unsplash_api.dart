import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:unflutter/api/model.dart';

class UnpslashApi {
  final String unsplashBaseUrl = "https://api.unsplash.com";

  Future<UserInfo> fetchUserInfo(String token) async {
    final response = await http.get(
        "$unsplashBaseUrl/me", headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      return UserInfo.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user info');
    }
  }

  Future<Photo> fetchRandomPhoto(String token) async {
    final response = await http.get("$unsplashBaseUrl/photos/random",
        headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      return Photo.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load random photo');
    }
  }

  Future<PhotoList> fetchPhotoList(String token, int page) async {
    final response = await http.get(
        "$unsplashBaseUrl/photos?page=" + page.toString(),
        headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      int total = int.parse(response.headers["x-total"]);
      int perPage = int.parse(response.headers["x-per-page"]);
      PhotoList list = PhotoList.fromJsonList(json.decode(response.body));
      list.total = total;
      list.perPage = perPage;
      list.currentPage = page;
      return list;
    } else {
      throw Exception('Failed to load photo list ');
    }
  }
}
