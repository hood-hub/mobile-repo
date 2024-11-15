// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  List<String>? get groups => throw _privateConstructorUsedError;
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String? get firstName => throw _privateConstructorUsedError;
  String? get lastName => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  bool? get isVerified => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  int? get v => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  GeoAddress? get geoAddress => throw _privateConstructorUsedError;
  String? get stringAddress => throw _privateConstructorUsedError;
  String? get profilePicture => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {List<String>? groups,
      @JsonKey(name: '_id') String id,
      String? firstName,
      String? lastName,
      String? email,
      bool? isVerified,
      DateTime? createdAt,
      DateTime? updatedAt,
      int? v,
      String? address,
      String? username,
      GeoAddress? geoAddress,
      String? stringAddress,
      String? profilePicture});

  $GeoAddressCopyWith<$Res>? get geoAddress;
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groups = freezed,
    Object? id = null,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? email = freezed,
    Object? isVerified = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? v = freezed,
    Object? address = freezed,
    Object? username = freezed,
    Object? geoAddress = freezed,
    Object? stringAddress = freezed,
    Object? profilePicture = freezed,
  }) {
    return _then(_value.copyWith(
      groups: freezed == groups
          ? _value.groups
          : groups // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      isVerified: freezed == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      v: freezed == v
          ? _value.v
          : v // ignore: cast_nullable_to_non_nullable
              as int?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      geoAddress: freezed == geoAddress
          ? _value.geoAddress
          : geoAddress // ignore: cast_nullable_to_non_nullable
              as GeoAddress?,
      stringAddress: freezed == stringAddress
          ? _value.stringAddress
          : stringAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      profilePicture: freezed == profilePicture
          ? _value.profilePicture
          : profilePicture // ignore: cast_nullable_to_non_nullable
              as String?,
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
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
          _$UserModelImpl value, $Res Function(_$UserModelImpl) then) =
      __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String>? groups,
      @JsonKey(name: '_id') String id,
      String? firstName,
      String? lastName,
      String? email,
      bool? isVerified,
      DateTime? createdAt,
      DateTime? updatedAt,
      int? v,
      String? address,
      String? username,
      GeoAddress? geoAddress,
      String? stringAddress,
      String? profilePicture});

  @override
  $GeoAddressCopyWith<$Res>? get geoAddress;
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
      _$UserModelImpl _value, $Res Function(_$UserModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groups = freezed,
    Object? id = null,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? email = freezed,
    Object? isVerified = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? v = freezed,
    Object? address = freezed,
    Object? username = freezed,
    Object? geoAddress = freezed,
    Object? stringAddress = freezed,
    Object? profilePicture = freezed,
  }) {
    return _then(_$UserModelImpl(
      groups: freezed == groups
          ? _value._groups
          : groups // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      isVerified: freezed == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      v: freezed == v
          ? _value.v
          : v // ignore: cast_nullable_to_non_nullable
              as int?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      geoAddress: freezed == geoAddress
          ? _value.geoAddress
          : geoAddress // ignore: cast_nullable_to_non_nullable
              as GeoAddress?,
      stringAddress: freezed == stringAddress
          ? _value.stringAddress
          : stringAddress // ignore: cast_nullable_to_non_nullable
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
class _$UserModelImpl implements _UserModel {
  const _$UserModelImpl(
      {final List<String>? groups = const [],
      @JsonKey(name: '_id') required this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.isVerified,
      this.createdAt,
      this.updatedAt,
      this.v = 0,
      this.address,
      this.username,
      this.geoAddress,
      this.stringAddress,
      this.profilePicture})
      : _groups = groups;

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  final List<String>? _groups;
  @override
  @JsonKey()
  List<String>? get groups {
    final value = _groups;
    if (value == null) return null;
    if (_groups is EqualUnmodifiableListView) return _groups;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String? email;
  @override
  final bool? isVerified;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  @JsonKey()
  final int? v;
  @override
  final String? address;
  @override
  final String? username;
  @override
  final GeoAddress? geoAddress;
  @override
  final String? stringAddress;
  @override
  final String? profilePicture;

  @override
  String toString() {
    return 'UserModel(groups: $groups, id: $id, firstName: $firstName, lastName: $lastName, email: $email, isVerified: $isVerified, createdAt: $createdAt, updatedAt: $updatedAt, v: $v, address: $address, username: $username, geoAddress: $geoAddress, stringAddress: $stringAddress, profilePicture: $profilePicture)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            const DeepCollectionEquality().equals(other._groups, _groups) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.v, v) || other.v == v) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.geoAddress, geoAddress) ||
                other.geoAddress == geoAddress) &&
            (identical(other.stringAddress, stringAddress) ||
                other.stringAddress == stringAddress) &&
            (identical(other.profilePicture, profilePicture) ||
                other.profilePicture == profilePicture));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_groups),
      id,
      firstName,
      lastName,
      email,
      isVerified,
      createdAt,
      updatedAt,
      v,
      address,
      username,
      geoAddress,
      stringAddress,
      profilePicture);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(
      this,
    );
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel(
      {final List<String>? groups,
      @JsonKey(name: '_id') required final String id,
      final String? firstName,
      final String? lastName,
      final String? email,
      final bool? isVerified,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final int? v,
      final String? address,
      final String? username,
      final GeoAddress? geoAddress,
      final String? stringAddress,
      final String? profilePicture}) = _$UserModelImpl;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  List<String>? get groups;
  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String? get firstName;
  @override
  String? get lastName;
  @override
  String? get email;
  @override
  bool? get isVerified;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  int? get v;
  @override
  String? get address;
  @override
  String? get username;
  @override
  GeoAddress? get geoAddress;
  @override
  String? get stringAddress;
  @override
  String? get profilePicture;
  @override
  @JsonKey(ignore: true)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GeoAddress _$GeoAddressFromJson(Map<String, dynamic> json) {
  return _GeoAddress.fromJson(json);
}

/// @nodoc
mixin _$GeoAddress {
  String get type => throw _privateConstructorUsedError;
  List<double> get coordinates => throw _privateConstructorUsedError;
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;

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
          ? _value._coordinates
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
  const _$GeoAddressImpl(
      {required this.type,
      required final List<double> coordinates,
      @JsonKey(name: '_id') required this.id})
      : _coordinates = coordinates;

  factory _$GeoAddressImpl.fromJson(Map<String, dynamic> json) =>
      _$$GeoAddressImplFromJson(json);

  @override
  final String type;
  final List<double> _coordinates;
  @override
  List<double> get coordinates {
    if (_coordinates is EqualUnmodifiableListView) return _coordinates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_coordinates);
  }

  @override
  @JsonKey(name: '_id')
  final String id;

  @override
  String toString() {
    return 'GeoAddress(type: $type, coordinates: $coordinates, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GeoAddressImpl &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality()
                .equals(other._coordinates, _coordinates) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, type, const DeepCollectionEquality().hash(_coordinates), id);

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
  const factory _GeoAddress(
      {required final String type,
      required final List<double> coordinates,
      @JsonKey(name: '_id') required final String id}) = _$GeoAddressImpl;

  factory _GeoAddress.fromJson(Map<String, dynamic> json) =
      _$GeoAddressImpl.fromJson;

  @override
  String get type;
  @override
  List<double> get coordinates;
  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  @JsonKey(ignore: true)
  _$$GeoAddressImplCopyWith<_$GeoAddressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
