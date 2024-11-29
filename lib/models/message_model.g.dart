// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageSenderImpl _$$MessageSenderImplFromJson(Map<String, dynamic> json) =>
    _$MessageSenderImpl(
      id: json['_id'] as String,
      username: json['username'] as String,
      profilePicture: json['profilePicture'] as String,
    );

Map<String, dynamic> _$$MessageSenderImplToJson(_$MessageSenderImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'username': instance.username,
      'profilePicture': instance.profilePicture,
    };

_$MessageImpl _$$MessageImplFromJson(Map<String, dynamic> json) =>
    _$MessageImpl(
      id: json['_id'] as String,
      content: json['content'] as String,
      media: (json['media'] as List<dynamic>).map((e) => e as String).toList(),
      sender: MessageSender.fromJson(json['sender'] as Map<String, dynamic>),
      group: json['group'] as String?,
      isDeleted: json['isDeleted'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$MessageImplToJson(_$MessageImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'content': instance.content,
      'media': instance.media,
      'sender': instance.sender,
      'group': instance.group,
      'isDeleted': instance.isDeleted,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

_$MessagesResponseImpl _$$MessagesResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$MessagesResponseImpl(
      page: (json['page'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      count: (json['count'] as num).toInt(),
      messages: (json['messages'] as List<dynamic>)
          .map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$MessagesResponseImplToJson(
        _$MessagesResponseImpl instance) =>
    <String, dynamic>{
      'page': instance.page,
      'totalPages': instance.totalPages,
      'count': instance.count,
      'messages': instance.messages,
    };
