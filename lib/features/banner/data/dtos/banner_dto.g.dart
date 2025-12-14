// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BannerDto _$BannerDtoFromJson(Map<String, dynamic> json) => _BannerDto(
  id: json['id'] as String?,
  img: json['img'] as String?,
  status: json['status'] as String?,
  createdAt: json['created_at'] as String?,
  updatedAt: json['updated_at'] as String?,
  title: json['title'] as String?,
  description: json['description'] as String?,
);

Map<String, dynamic> _$BannerDtoToJson(_BannerDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'img': instance.img,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'title': instance.title,
      'description': instance.description,
    };
