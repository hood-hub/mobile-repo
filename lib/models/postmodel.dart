import 'package:freezed_annotation/freezed_annotation.dart';
part 'postmodel.freezed.dart';
part 'postmodel.g.dart';

@unfreezed
class PostModel with _$PostModel {
  factory PostModel({
    @JsonKey(name: '_id') required String id,
    required String text,
    required List<String> media,
    required int noOfLikes,
   // required int noOfUnlikes,
    required int noOfComments,
    String? stringAddress,
    GeoAddress? geoAddress,
    UserModelSmall? userId,
    required bool isDeleted,
    @JsonKey(name: 'createdAt') required DateTime createdAt,
    @JsonKey(name: 'updatedAt') required DateTime updatedAt,
    @JsonKey(name: '__v') required int version,
  }) = _PostModel;

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
}

@unfreezed
class GeoAddress with _$GeoAddress {
  factory GeoAddress({
    required String type,
    required List<double> coordinates,
    @JsonKey(name: '_id') required String id,
  }) = _GeoAddress;

  factory GeoAddress.fromJson(Map<String, dynamic> json) =>
      _$GeoAddressFromJson(json);
}

@freezed
class UserModelSmall with _$UserModelSmall {
  const factory UserModelSmall({
    @JsonKey(name: '_id') required String id,
     String? username,
    String? profilePicture,
  }) = _UserModelSmall;

  factory UserModelSmall.fromJson(Map<String, dynamic> json) => _$UserModelSmallFromJson(json);
}

