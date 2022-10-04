import 'package:json_annotation/json_annotation.dart';

part 'api_model.g.dart';

@JsonSerializable()
class APIModel {

  @JsonKey(name: 'API')
  final String name;

  @JsonKey(name: 'Description')
  final String description;

  @JsonKey(name: 'Auth')
  final String auth;

  @JsonKey(name: 'HTTPS')
  final bool isHttps;

  @JsonKey(name: 'Cors')
  final String isCors;

  @JsonKey(name: 'Link')
  final String url;

  @JsonKey(name: 'Category')
  final String category;

  const APIModel({required this.name, required this.description, required this.auth, required this.category, required this.isCors, required this.isHttps, required this.url});

  factory APIModel.fromJson(Map<String, dynamic> json) => _$APIModelFromJson(json);

  Map<String, dynamic> toJson() => _$APIModelToJson(this);

}