import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'model.g.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.

@JsonSerializable()
class UserInfo {
  String id;
  String updatedAt;
  String username;
  String firstName;
  String lastName;
  String twitterUsername;
  String portfolioUrl;
  String bio;
  String location;
  int totalLikes;
  int totalPhotos;
  int totalCollections;
  bool followedByUser;
  int downloads;
  int uploadsRemaining;
  String instagramUsername;
  String email;
  Links links;

  UserInfo(
      this.id,
      this.updatedAt,
      this.username,
      this.firstName,
      this.lastName,
      this.twitterUsername,
      this.portfolioUrl,
      this.bio,
      this.location,
      this.totalLikes,
      this.totalPhotos,
      this.totalCollections,
      this.followedByUser,
      this.downloads,
      this.uploadsRemaining,
      this.instagramUsername,
      this.email,
      this.links);

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
