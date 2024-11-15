// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'postmodel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PostModel _$PostModelFromJson(Map<String, dynamic> json) {
  return _PostModel.fromJson(json);
}

/// @nodoc
mixin _$PostModel {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: '_id')
  set id(String value) => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  set text(String value) => throw _privateConstructorUsedError;
  List<String> get media => throw _privateConstructorUsedError;
  set media(List<String> value) => throw _privateConstructorUsedError;
  int get noOfLikes => throw _privateConstructorUsedError;
  set noOfLikes(int value) =>
      throw _privateConstructorUsedError; // required int noOfUnlikes,
  int get noOfComments =>
      throw _privateConstructorUsedError; // required int noOfUnlikes,
  set noOfComments(int value) => throw _privateConstructorUsedError;
  String? get stringAddress => throw _privateConstructorUsedError;
  set stringAddress(String? value) => throw _privateConstructorUsedError;
  GeoAddress? get geoAddress => throw _privateConstructorUsedError;
  set geoAddress(GeoAddress? value) => throw _privateConstructorUsedError;
  UserModelSmall? get userId => throw _privateConstructorUsedError;
  set userId(UserModelSmall? value) => throw _privateConstructorUsedError;
  bool get isDeleted => throw _privateConstructorUsedError;
  set isDeleted(bool value) => throw _privateConstructorUsedError;
  @JsonKey(name: 'createdAt')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'createdAt')
  set createdAt(DateTime value) => throw _privateConstructorUsedError;
  @JsonKey(name: 'updatedAt')
  DateTime get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updatedAt')
  set updatedAt(DateTime value) => throw _privateConstructorUsedError;
  @JsonKey(name: '__v')
  int get version => throw _privateConstructorUsedError;
  @JsonKey(name: '__v')
  set version(int value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostModelCopyWith<PostModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostModelCopyWith<$Res> {
  factory $PostModelCopyWith(PostModel value, $Res Function(PostModel) then) =
      _$PostModelCopyWithImpl<$Res, PostModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String text,
      List<String> media,
      int noOfLikes,
      int noOfComments,
      String? stringAddress,
      GeoAddress? geoAddress,
      UserModelSmall? userId,
      bool isDeleted,
      @JsonKey(name: 'createdAt') DateTime createdAt,
      @JsonKey(name: 'updatedAt') DateTime updatedAt,
      @JsonKey(name: '__v') int version});

  $GeoAddressCopyWith<$Res>? get geoAddress;
  $UserModelSmallCopyWith<$Res>? get userId;
}

/// @nodoc
class _$PostModelCopyWithImpl<$Res, $Val extends PostModel>
    implements $PostModelCopyWith<$Res> {
  _$PostModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? media = null,
    Object? noOfLikes = null,
    Object? noOfComments = null,
    Object? stringAddress = freezed,
    Object? geoAddress = freezed,
    Object? userId = freezed,
    Object? isDeleted = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? version = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      media: null == media
          ? _value.media
          : media // ignore: cast_nullable_to_non_nullable
              as List<String>,
      noOfLikes: null == noOfLikes
          ? _value.noOfLikes
          : noOfLikes // ignore: cast_nullable_to_non_nullable
              as int,
      noOfComments: null == noOfComments
          ? _value.noOfComments
          : noOfComments // ignore: cast_nullable_to_non_nullable
              as int,
      stringAddress: freezed == stringAddress
          ? _value.stringAddress
          : stringAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      geoAddress: freezed == geoAddress
          ? _value.geoAddress
          : geoAddress // ignore: cast_nullable_to_non_nullable
              as GeoAddress?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as UserModelSmall?,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GeoAddressCopyWith<$Res>? get geoAddress {
    if (_value.geoAddress == null) {
      return null;
    }

    return $GeoAddressCopyWith<$Res>(_value.geoAddress!, (value) {
      return _then(_value.copyWith(geoAddress: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UserModelSmallCopyWith<$Res>? get userId {
    if (_value.userId == null) {
      return null;
    }

    return $UserModelSmallCopyWith<$Res>(_value.userId!, (value) {
      return _then(_value.copyWith(userId: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PostModelImplCopyWith<$Res>
    implements $PostModelCopyWith<$Res> {
  factory _$$PostModelImplCopyWith(
          _$PostModelImpl value, $Res Function(_$PostModelImpl) then) =
      __$$PostModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String text,
      List<String> media,
      int noOfLikes,
      int noOfComments,
      String? stringAddress,
      GeoAddress? geoAddress,
      UserModelSmall? userId,
      bool isDeleted,
      @JsonKey(name: 'createdAt') DateTime createdAt,
      @JsonKey(name: 'updatedAt') DateTime updatedAt,
      @JsonKey(name: '__v') int version});

  @override
  $GeoAddressCopyWith<$Res>? get geoAddress;
  @override
  $UserModelSmallCopyWith<$Res>? get userId;
}

/// @nodoc
class __$$PostModelImplCopyWithImpl<$Res>
    extends _$PostModelCopyWithImpl<$Res, _$PostModelImpl>
    implements _$$PostModelImplCopyWith<$Res> {
  __$$PostModelImplCopyWithImpl(
      _$PostModelImpl _value, $Res Function(_$PostModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? media = null,
    Object? noOfLikes = null,
    Object? noOfComments = null,
    Object? stringAddress = freezed,
    Object? geoAddress = freezed,
    Object? userId = freezed,
    Object? isDeleted = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? version = null,
  }) {
    return _then(_$PostModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      media: null == media
          ? _value.media
          : media // ignore: cast_nullable_to_non_nullable
              as List<String>,
      noOfLikes: null == noOfLikes
          ? _value.noOfLikes
          : noOfLikes // ignore: cast_nullable_to_non_nullable
              as int,
      noOfComments: null == noOfComments
          ? _value.noOfComments
          : noOfComments // ignore: cast_nullable_to_non_nullable
              as int,
      stringAddress: freezed == stringAddress
          ? _value.stringAddress
          : stringAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      geoAddress: freezed == geoAddress
          ? _value.geoAddress
          : geoAddress // ignore: cast_nullable_to_non_nullable
              as GeoAddress?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as UserModelSmall?,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PostModelImpl implements _PostModel {
  _$PostModelImpl(
      {@JsonKey(name: '_id') required this.id,
      required this.text,
      required this.media,
      required this.noOfLikes,
      required this.noOfComments,
      this.stringAddress,
      this.geoAddress,
      this.userId,
      required this.isDeleted,
      @JsonKey(name: 'createdAt') required this.createdAt,
      @JsonKey(name: 'updatedAt') required this.updatedAt,
      @JsonKey(name: '__v') required this.version});

  factory _$PostModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostModelImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  String id;
  @override
  String text;
  @override
  List<String> media;
  @override
  int noOfLikes;
// required int noOfUnlikes,
  @override
  int noOfComments;
  @override
  String? stringAddress;
  @override
  GeoAddress? geoAddress;
  @override
  UserModelSmall? userId;
  @override
  bool isDeleted;
  @override
  @JsonKey(name: 'createdAt')
  DateTime createdAt;
  @override
  @JsonKey(name: 'updatedAt')
  DateTime updatedAt;
  @override
  @JsonKey(name: '__v')
  int version;

  @override
  String toString() {
    return 'PostModel(id: $id, text: $text, media: $media, noOfLikes: $noOfLikes, noOfComments: $noOfComments, stringAddress: $stringAddress, geoAddress: $geoAddress, userId: $userId, isDeleted: $isDeleted, createdAt: $createdAt, updatedAt: $updatedAt, version: $version)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PostModelImplCopyWith<_$PostModelImpl> get copyWith =>
      __$$PostModelImplCopyWithImpl<_$PostModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostModelImplToJson(
      this,
    );
  }
}

abstract class _PostModel implements PostModel {
  factory _PostModel(
      {@JsonKey(name: '_id') required String id,
      required String text,
      required List<String> media,
      required int noOfLikes,
      required int noOfComments,
      String? stringAddress,
      GeoAddress? geoAddress,
      UserModelSmall? userId,
      required bool isDeleted,
      @JsonKey(name: 'createdAt') required DateTime createdAt,
      @JsonKey(name: 'updatedAt') required DateTime updatedAt,
      @JsonKey(name: '__v') required int version}) = _$PostModelImpl;

  factory _PostModel.fromJson(Map<String, dynamic> json) =
      _$PostModelImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @JsonKey(name: '_id')
  set id(String value);
  @override
  String get text;
  set text(String value);
  @override
  List<String> get media;
  set media(List<String> value);
  @override
  int get noOfLikes;
  set noOfLikes(int value);
  @override // required int noOfUnlikes,
  int get noOfComments; // required int noOfUnlikes,
  set noOfComments(int value);
  @override
  String? get stringAddress;
  set stringAddress(String? value);
  @override
  GeoAddress? get geoAddress;
  set geoAddress(GeoAddress? value);
  @override
  UserModelSmall? get userId;
  set userId(UserModelSmall? value);
  @override
  bool get isDeleted;
  set isDeleted(bool value);
  @override
  @JsonKey(name: 'createdAt')
  DateTime get createdAt;
  @JsonKey(name: 'createdAt')
  set createdAt(DateTime value);
  @override
  @JsonKey(name: 'updatedAt')
  DateTime get updatedAt;
  @JsonKey(name: 'updatedAt')
  set updatedAt(DateTime value);
  @override
  @JsonKey(name: '__v')
  int get version;
  @JsonKey(name: '__v')
  set version(int value);
  @override
  @JsonKey(ignore: true)
  _$$PostModelImplCopyWith<_$PostModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GeoAddress _$GeoAddressFromJson(Map<String, dynamic> json) {
  return _GeoAddress.fromJson(json);
}

/// @nodoc
mixin _$GeoAddress {
  String get type => throw _privateConstructorUsedError;
  set type(String value) => throw _privateConstructorUsedError;
  List<double> get coordinates => throw _privateConstructorUsedError;
  set coordinates(List<double> value) => throw _privateConstructorUsedError;
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: '_id')
  set id(String value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GeoAddressCopyWith<GeoAddress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeoAddressCopyWith<$Res> {
  factory $GeoAddressCopyWith(
          GeoAddress value, $Res Function(GeoAddress) then) =
      _$GeoAddressCopyWithImpl<$Res, GeoAddress>;
  @useResult
  $Res call(
      {String type, List<double> coordinates, @JsonKey(name: '_id') String id});
}

/// @nodoc
class _$GeoAddressCopyWithImpl<$Res, $Val extends GeoAddress>
    implements $GeoAddressCopyWith<$Res> {
  _$GeoAddressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? coordinates = null,
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      coordinates: null == coordinates
          ? _value.coordinates
          : coordinates // ignore: cast_nullable_to_non_nullable
              as List<double>,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GeoAddressImplCopyWith<$Res>
    implements $GeoAddressCopyWith<$Res> {
  factory _$$GeoAddressImplCopyWith(
          _$GeoAddressImpl value, $Res Function(_$GeoAddressImpl) then) =
      __$$GeoAddressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String type, List<double> coordinates, @JsonKey(name: '_id') String id});
}

/// @nodoc
class __$$GeoAddressImplCopyWithImpl<$Res>
    extends _$GeoAddressCopyWithImpl<$Res, _$GeoAddressImpl>
    implements _$$GeoAddressImplCopyWith<$Res> {
  __$$GeoAddressImplCopyWithImpl(
      _$GeoAddressImpl _value, $Res Function(_$GeoAddressImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? coordinates = null,
    Object? id = null,
  }) {
    return _then(_$GeoAddressImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      coordinates: null == coordinates
          ? _value.coordinates
          : coordinates // ignore: cast_nullable_to_non_nullable
              as List<double>,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GeoAddressImpl implements _GeoAddress {
  _$GeoAddressImpl(
      {required this.type,
      required this.coordinates,
      @JsonKey(name: '_id') required this.id});

  factory _$GeoAddressImpl.fromJson(Map<String, dynamic> json) =>
      _$$GeoAddressImplFromJson(json);

  @override
  String type;
  @override
  List<double> coordinates;
  @override
  @JsonKey(name: '_id')
  String id;

  @override
  String toString() {
    return 'GeoAddress(type: $type, coordinates: $coordinates, id: $id)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GeoAddressImplCopyWith<_$GeoAddressImpl> get copyWith =>
      __$$GeoAddressImplCopyWithImpl<_$GeoAddressImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GeoAddressImplToJson(
      this,
    );
  }
}

abstract class _GeoAddress implements GeoAddress {
  factory _GeoAddress(
      {required String type,
      required List<double> coordinates,
      @JsonKey(name: '_id') required String id}) = _$GeoAddressImpl;

  factory _GeoAddress.fromJson(Map<String, dynamic> json) =
      _$GeoAddressImpl.fromJson;

  @override
  String get type;
  set type(String value);
  @override
  List<double> get coordinates;
  set coordinates(List<double> value);
  @override
  @JsonKey(name: '_id')
  String get id;
  @JsonKey(name: '_id')
  set id(String value);
  @override
  @JsonKey(ignore: true)
  _$$GeoAddressImplCopyWith<_$GeoAddressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserModelSmall _$UserModelSmallFromJson(Map<String, dynamic> json) {
  return _UserModelSmall.fromJson(json);
}

/// @nodoc
mixin _$UserModelSmall {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  String? get profilePicture => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserModelSmallCopyWith<UserModelSmall> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelSmallCopyWith<$Res> {
  factory $UserModelSmallCopyWith(
          UserModelSmall value, $Res Function(UserModelSmall) then) =
      _$UserModelSmallCopyWithImpl<$Res, UserModelSmall>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String? username,
      String? profilePicture});
}

/// @nodoc
class _$UserModelSmallCopyWithImpl<$Res, $Val extends UserModelSmall>
    implements $UserModelSmallCopyWith<$Res> {
  _$UserModelSmallCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = freezed,
    Object? profilePicture = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      profilePicture: freezed == profilePicture
          ? _value.profilePicture
          : profilePicture // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserModelSmallImplCopyWith<$Res>
    implements $UserModelSmallCopyWith<$Res> {
  factory _$$UserModelSmallImplCopyWith(_$UserModelSmallImpl value,
          $Res Function(_$UserModelSmallImpl) then) =
      __$$UserModelSmallImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String? username,
      String? profilePicture});
}

/// @nodoc
class __$$UserModelSmallImplCopyWithImpl<$Res>
    extends _$UserModelSmallCopyWithImpl<$Res, _$UserModelSmallImpl>
    implements _$$UserModelSmallImplCopyWith<$Res> {
  __$$UserModelSmallImplCopyWithImpl(
      _$UserModelSmallImpl _value, $Res Function(_$UserModelSmallImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = freezed,
    Object? profilePicture = freezed,
  }) {
    return _then(_$UserModelSmallImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      profilePicture: freezed == profilePicture
          ? _value.profilePicture
          : profilePicture // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelSmallImpl implements _UserModelSmall {
  const _$UserModelSmallImpl(
      {@JsonKey(name: '_id') required this.id,
      this.username,
      this.profilePicture});

  factory _$UserModelSmallImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelSmallImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String? username;
  @override
  final String? profilePicture;

  @override
  String toString() {
    return 'UserModelSmall(id: $id, username: $username, profilePicture: $profilePicture)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelSmallImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.profilePicture, profilePicture) ||
                other.profilePicture == profilePicture));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, username, profilePicture);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelSmallImplCopyWith<_$UserModelSmallImpl> get copyWith =>
      __$$UserModelSmallImplCopyWithImpl<_$UserModelSmallImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelSmallImplToJson(
      this,
    );
  }
}

abstract class _UserModelSmall implements UserModelSmall {
  const factory _UserModelSmall(
      {@JsonKey(name: '_id') required final String id,
      final String? username,
      final String? profilePicture}) = _$UserModelSmallImpl;

  factory _UserModelSmall.fromJson(Map<String, dynamic> json) =
      _$UserModelSmallImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String? get username;
  @override
  String? get profilePicture;
  @override
  @JsonKey(ignore: true)
  _$$UserModelSmallImplCopyWith<_$UserModelSmallImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
