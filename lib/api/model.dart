import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'model.g.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.


/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.


/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.

@JsonSerializable()
class UserInfo {
  String id;
  String updated_at;
  String username;
  String name;
  String first_name;
  String last_name;
  String twitter_username;
  String portfolio_url;
  String bio;
  String location;
  Links links;
  ProfileImage profile_image;
  String instagram_username;
  int total_collections;
  int total_likes;
  int total_photos;
  bool accepted_tos;
  bool followed_by_user;
  List<String> photos;
  String badge;
  int downloads;
  Tags tags;
  int followers_count;
  int following_count;
  bool allow_messages;
  int numeric_id;
  String uid;
  int uploads_remaining;
  bool unlimited_uploads;
  String email;

  UserInfo({
    this.id,
    this.updated_at,
    this.username,
    this.name,
    this.first_name,
    this.last_name,
    this.twitter_username,
    this.portfolio_url,
    this.bio,
    this.location,
    this.links,
    this.profile_image,
    this.instagram_username,
    this.total_collections,
    this.total_likes,
    this.total_photos,
    this.accepted_tos,
    this.followed_by_user,
    this.photos,
    this.badge,
    this.downloads,
    this.tags,
    this.followers_count,
    this.following_count,
    this.allow_messages,
    this.numeric_id,
    this.uid,
    this.uploads_remaining,
    this.unlimited_uploads,
    this.email,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}

@JsonSerializable()
class Links {
  String self;
  String html;
  String photos;
  String likes;
  String portfolio;

  Links({this.self, this.html, this.photos, this.likes, this.portfolio});

  factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);

  Map<String, dynamic> toJson() => _$LinksToJson(this);
}

@JsonSerializable()
class ProfileImage {
  String small;
  String medium;
  String large;

  ProfileImage({this.small, this.medium, this.large});

  factory ProfileImage.fromJson(Map<String, dynamic> json) =>
      _$ProfileImageFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileImageToJson(this);
}

@JsonSerializable()
class Tags {
  List<String> custom;
  List<String> aggregated;

  Tags({this.custom, this.aggregated});

  factory Tags.fromJson(Map<String, dynamic> json) => _$TagsFromJson(json);

  Map<String, dynamic> toJson() => _$TagsToJson(this);
}

@JsonSerializable()
class Photo {
  String id;
  String created_at;
  String updated_at;
  int width;
  int height;
  String color;
  int downloads;
  int likes;
  bool liked_by_user;
  String description;
  Urls urls;

  Photo({this.id,
    this.created_at,
    this.updated_at,
    this.width,
    this.height,
    this.color,
    this.downloads,
    this.likes,
    this.liked_by_user,
    this.description,
    this.urls});

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoToJson(this);
}

@JsonSerializable()
class Urls {
  String raw;
  String full;
  String regular;
  String small;
  String thumb;

  Urls({this.raw, this.full, this.regular, this.small, this.thumb});

  factory Urls.fromJson(Map<String, dynamic> json) => _$UrlsFromJson(json);

  Map<String, dynamic> toJson() => _$UrlsToJson(this);
}

class PhotoList {
  List<Photo> photos = [];
  int total;
  int perPage;
  int currentPage;

  PhotoList({this.photos, this.total, this.perPage, this.currentPage});

  factory PhotoList.fromJsonList(List<dynamic> json) {
    return PhotoList(
        photos: json.map((val) => Photo.fromJson(val)).toList(growable: true));
  }
}