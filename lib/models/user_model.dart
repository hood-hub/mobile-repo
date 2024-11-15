// lib/models/user_model.dart

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    @Default([]) List<String>? groups,
    @JsonKey(name: '_id') required String id,
    String? firstName,
    String? lastName,
    String? email,
    bool? isVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
    @Default(0) int? v,
    String? address,
    String? username,
    GeoAddress? geoAddress,
    String? stringAddress,
    String? profilePicture,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}

@freezed
class GeoAddress with _$GeoAddress {
  const factory GeoAddress({
    required String type,
    required List<double> coordinates,
    @JsonKey(name: '_id') required String id,
  }) = _GeoAddress;

  factory GeoAddress.fromJson(Map<String, dynamic> json) => _$GeoAddressFromJson(json);
}

