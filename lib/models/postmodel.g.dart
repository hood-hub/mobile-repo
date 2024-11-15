// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'postmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostModelImpl _$$PostModelImplFromJson(Map<String, dynamic> json) =>
    _$PostModelImpl(
      id: json['_id'] as String,
      text: json['text'] as String,
      media: (json['media'] as List<dynamic>).map((e) => e as String).toList(),
      noOfLikes: (json['noOfLikes'] as num).toInt(),
      noOfComments: (json['noOfComments'] as num).toInt(),
      stringAddress: json['stringAddress'] as String?,
      geoAddress: json['geoAddress'] == null
          ? null
          : GeoAddress.fromJson(json['geoAddress'] as Map<String, dynamic>),
      userId: json['userId'] == null
          ? null
          : UserModelSmall.fromJson(json['userId'] as Map<String, dynamic>),
      isDeleted: json['isDeleted'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      version: (json['__v'] as num).toInt(),
    );

Map<String, dynamic> _$$PostModelImplToJson(_$PostModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'text': instance.text,
      'media': instance.media,
      'noOfLikes': instance.noOfLikes,
      'noOfComments': instance.noOfComments,
      'stringAddress': instance.stringAddress,
      'geoAddress': instance.geoAddress,
      'userId': instance.userId,
      'isDeleted': instance.isDeleted,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      '__v': instance.version,
    };

_$GeoAddressImpl _$$GeoAddressImplFromJson(Map<String, dynamic> json) =>
    _$GeoAddressImpl(
      type: json['type'] as String,
      coordinates: (json['coordinates'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      id: json['_id'] as String,
    );

Map<String, dynamic> _$$GeoAddressImplToJson(_$GeoAddressImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'coordinates': instance.coordinates,
      '_id': instance.id,
    };

_$UserModelSmallImpl _$$UserModelSmallImplFromJson(Map<String, dynamic> json) =>
    _$UserModelSmallImpl(
      id: json['_id'] as String,
      username: json['username'] as String?,
      profilePicture: json['profilePicture'] as String?,
    );

Map<String, dynamic> _$$UserModelSmallImplToJson(
        _$UserModelSmallImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'username': instance.username,
      'profilePicture': instance.profilePicture,
    };
