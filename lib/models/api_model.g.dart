// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

APIModel _$APIModelFromJson(Map<String, dynamic> json) => APIModel(
      name: json['API'] as String,
      description: json['Description'] as String,
      auth: json['Auth'] as String,
      category: json['Category'] as String,
      isCors: json['Cors'] as String,
      isHttps: json['HTTPS'] as bool,
      url: json['Link'] as String,
    );

Map<String, dynamic> _$APIModelToJson(APIModel instance) => <String, dynamic>{
      'API': instance.name,
      'Description': instance.description,
      'Auth': instance.auth,
      'HTTPS': instance.isHttps,
      'Cors': instance.isCors,
      'Link': instance.url,
      'Category': instance.category,
    };
