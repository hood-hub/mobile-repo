// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MessageSender _$MessageSenderFromJson(Map<String, dynamic> json) {
  return _MessageSender.fromJson(json);
}

/// @nodoc
mixin _$MessageSender {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get profilePicture => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageSenderCopyWith<MessageSender> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageSenderCopyWith<$Res> {
  factory $MessageSenderCopyWith(
          MessageSender value, $Res Function(MessageSender) then) =
      _$MessageSenderCopyWithImpl<$Res, MessageSender>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String username,
      String profilePicture});
}

/// @nodoc
class _$MessageSenderCopyWithImpl<$Res, $Val extends MessageSender>
    implements $MessageSenderCopyWith<$Res> {
  _$MessageSenderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? profilePicture = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      profilePicture: null == profilePicture
          ? _value.profilePicture
          : profilePicture // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MessageSenderImplCopyWith<$Res>
    implements $MessageSenderCopyWith<$Res> {
  factory _$$MessageSenderImplCopyWith(
          _$MessageSenderImpl value, $Res Function(_$MessageSenderImpl) then) =
      __$$MessageSenderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String username,
      String profilePicture});
}

/// @nodoc
class __$$MessageSenderImplCopyWithImpl<$Res>
    extends _$MessageSenderCopyWithImpl<$Res, _$MessageSenderImpl>
    implements _$$MessageSenderImplCopyWith<$Res> {
  __$$MessageSenderImplCopyWithImpl(
      _$MessageSenderImpl _value, $Res Function(_$MessageSenderImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? profilePicture = null,
  }) {
    return _then(_$MessageSenderImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      profilePicture: null == profilePicture
          ? _value.profilePicture
          : profilePicture // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageSenderImpl implements _MessageSender {
  const _$MessageSenderImpl(
      {@JsonKey(name: '_id') required this.id,
      required this.username,
      required this.profilePicture});

  factory _$MessageSenderImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageSenderImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String username;
  @override
  final String profilePicture;

  @override
  String toString() {
    return 'MessageSender(id: $id, username: $username, profilePicture: $profilePicture)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageSenderImpl &&
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
  _$$MessageSenderImplCopyWith<_$MessageSenderImpl> get copyWith =>
      __$$MessageSenderImplCopyWithImpl<_$MessageSenderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageSenderImplToJson(
      this,
    );
  }
}

abstract class _MessageSender implements MessageSender {
  const factory _MessageSender(
      {@JsonKey(name: '_id') required final String id,
      required final String username,
      required final String profilePicture}) = _$MessageSenderImpl;

  factory _MessageSender.fromJson(Map<String, dynamic> json) =
      _$MessageSenderImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get username;
  @override
  String get profilePicture;
  @override
  @JsonKey(ignore: true)
  _$$MessageSenderImplCopyWith<_$MessageSenderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Message _$MessageFromJson(Map<String, dynamic> json) {
  return _Message.fromJson(json);
}

/// @nodoc
mixin _$Message {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  List<String> get media => throw _privateConstructorUsedError;
  MessageSender get sender => throw _privateConstructorUsedError;
  String? get group => throw _privateConstructorUsedError;
  bool get isDeleted => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageCopyWith<Message> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageCopyWith<$Res> {
  factory $MessageCopyWith(Message value, $Res Function(Message) then) =
      _$MessageCopyWithImpl<$Res, Message>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String content,
      List<String> media,
      MessageSender sender,
      String? group,
      bool isDeleted,
      DateTime createdAt,
      DateTime updatedAt});

  $MessageSenderCopyWith<$Res> get sender;
}

/// @nodoc
class _$MessageCopyWithImpl<$Res, $Val extends Message>
    implements $MessageCopyWith<$Res> {
  _$MessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? media = null,
    Object? sender = null,
    Object? group = freezed,
    Object? isDeleted = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      media: null == media
          ? _value.media
          : media // ignore: cast_nullable_to_non_nullable
              as List<String>,
      sender: null == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as MessageSender,
      group: freezed == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as String?,
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
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MessageSenderCopyWith<$Res> get sender {
    return $MessageSenderCopyWith<$Res>(_value.sender, (value) {
      return _then(_value.copyWith(sender: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MessageImplCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory _$$MessageImplCopyWith(
          _$MessageImpl value, $Res Function(_$MessageImpl) then) =
      __$$MessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String content,
      List<String> media,
      MessageSender sender,
      String? group,
      bool isDeleted,
      DateTime createdAt,
      DateTime updatedAt});

  @override
  $MessageSenderCopyWith<$Res> get sender;
}

/// @nodoc
class __$$MessageImplCopyWithImpl<$Res>
    extends _$MessageCopyWithImpl<$Res, _$MessageImpl>
    implements _$$MessageImplCopyWith<$Res> {
  __$$MessageImplCopyWithImpl(
      _$MessageImpl _value, $Res Function(_$MessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? media = null,
    Object? sender = null,
    Object? group = freezed,
    Object? isDeleted = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$MessageImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      media: null == media
          ? _value._media
          : media // ignore: cast_nullable_to_non_nullable
              as List<String>,
      sender: null == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as MessageSender,
      group: freezed == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as String?,
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageImpl implements _Message {
  const _$MessageImpl(
      {@JsonKey(name: '_id') required this.id,
      required this.content,
      required final List<String> media,
      required this.sender,
      this.group,
      required this.isDeleted,
      required this.createdAt,
      required this.updatedAt})
      : _media = media;

  factory _$MessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String content;
  final List<String> _media;
  @override
  List<String> get media {
    if (_media is EqualUnmodifiableListView) return _media;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_media);
  }

  @override
  final MessageSender sender;
  @override
  final String? group;
  @override
  final bool isDeleted;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Message(id: $id, content: $content, media: $media, sender: $sender, group: $group, isDeleted: $isDeleted, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality().equals(other._media, _media) &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.group, group) || other.group == group) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      content,
      const DeepCollectionEquality().hash(_media),
      sender,
      group,
      isDeleted,
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageImplCopyWith<_$MessageImpl> get copyWith =>
      __$$MessageImplCopyWithImpl<_$MessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageImplToJson(
      this,
    );
  }
}

abstract class _Message implements Message {
  const factory _Message(
      {@JsonKey(name: '_id') required final String id,
      required final String content,
      required final List<String> media,
      required final MessageSender sender,
      final String? group,
      required final bool isDeleted,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$MessageImpl;

  factory _Message.fromJson(Map<String, dynamic> json) = _$MessageImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get content;
  @override
  List<String> get media;
  @override
  MessageSender get sender;
  @override
  String? get group;
  @override
  bool get isDeleted;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$MessageImplCopyWith<_$MessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MessagesResponse _$MessagesResponseFromJson(Map<String, dynamic> json) {
  return _MessagesResponse.fromJson(json);
}

/// @nodoc
mixin _$MessagesResponse {
  int get page => throw _privateConstructorUsedError;
  int get totalPages => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  List<Message> get messages => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessagesResponseCopyWith<MessagesResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessagesResponseCopyWith<$Res> {
  factory $MessagesResponseCopyWith(
          MessagesResponse value, $Res Function(MessagesResponse) then) =
      _$MessagesResponseCopyWithImpl<$Res, MessagesResponse>;
  @useResult
  $Res call({int page, int totalPages, int count, List<Message> messages});
}

/// @nodoc
class _$MessagesResponseCopyWithImpl<$Res, $Val extends MessagesResponse>
    implements $MessagesResponseCopyWith<$Res> {
  _$MessagesResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? totalPages = null,
    Object? count = null,
    Object? messages = null,
  }) {
    return _then(_value.copyWith(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<Message>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MessagesResponseImplCopyWith<$Res>
    implements $MessagesResponseCopyWith<$Res> {
  factory _$$MessagesResponseImplCopyWith(_$MessagesResponseImpl value,
          $Res Function(_$MessagesResponseImpl) then) =
      __$$MessagesResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int page, int totalPages, int count, List<Message> messages});
}

/// @nodoc
class __$$MessagesResponseImplCopyWithImpl<$Res>
    extends _$MessagesResponseCopyWithImpl<$Res, _$MessagesResponseImpl>
    implements _$$MessagesResponseImplCopyWith<$Res> {
  __$$MessagesResponseImplCopyWithImpl(_$MessagesResponseImpl _value,
      $Res Function(_$MessagesResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? totalPages = null,
    Object? count = null,
    Object? messages = null,
  }) {
    return _then(_$MessagesResponseImpl(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      messages: null == messages
          ? _value._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<Message>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessagesResponseImpl implements _MessagesResponse {
  const _$MessagesResponseImpl(
      {required this.page,
      required this.totalPages,
      required this.count,
      required final List<Message> messages})
      : _messages = messages;

  factory _$MessagesResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessagesResponseImplFromJson(json);

  @override
  final int page;
  @override
  final int totalPages;
  @override
  final int count;
  final List<Message> _messages;
  @override
  List<Message> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  String toString() {
    return 'MessagesResponse(page: $page, totalPages: $totalPages, count: $count, messages: $messages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessagesResponseImpl &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            (identical(other.count, count) || other.count == count) &&
            const DeepCollectionEquality().equals(other._messages, _messages));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, page, totalPages, count,
      const DeepCollectionEquality().hash(_messages));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MessagesResponseImplCopyWith<_$MessagesResponseImpl> get copyWith =>
      __$$MessagesResponseImplCopyWithImpl<_$MessagesResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessagesResponseImplToJson(
      this,
    );
  }
}

abstract class _MessagesResponse implements MessagesResponse {
  const factory _MessagesResponse(
      {required final int page,
      required final int totalPages,
      required final int count,
      required final List<Message> messages}) = _$MessagesResponseImpl;

  factory _MessagesResponse.fromJson(Map<String, dynamic> json) =
      _$MessagesResponseImpl.fromJson;

  @override
  int get page;
  @override
  int get totalPages;
  @override
  int get count;
  @override
  List<Message> get messages;
  @override
  @JsonKey(ignore: true)
  _$$MessagesResponseImplCopyWith<_$MessagesResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
