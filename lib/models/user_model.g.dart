// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      groups: (json['groups'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      id: json['_id'] as String,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      isVerified: json['isVerified'] as bool?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      v: (json['v'] as num?)?.toInt() ?? 0,
      address: json['address'] as String?,
      username: json['username'] as String?,
      geoAddress: json['geoAddress'] == null
          ? null
          : GeoAddress.fromJson(json['geoAddress'] as Map<String, dynamic>),
      stringAddress: json['stringAddress'] as String?,
      profilePicture: json['profilePicture'] as String?,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'groups': instance.groups,
      '_id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'isVerified': instance.isVerified,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'v': instance.v,
      'address': instance.address,
      'username': instance.username,
      'geoAddress': instance.geoAddress,
      'stringAddress': instance.stringAddress,
      'profilePicture': instance.profilePicture,
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
