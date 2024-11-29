// message_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

@freezed
class MessageSender with _$MessageSender {
  const factory MessageSender({
    @JsonKey(name: '_id') required String id,
    required String username,
    required String profilePicture,
  }) = _MessageSender;

  factory MessageSender.fromJson(Map<String, dynamic> json) =>
      _$MessageSenderFromJson(json);
}

@freezed
class Message with _$Message {
  const factory Message({
    @JsonKey(name: '_id') required String id,
    required String content,
    required List<String> media,
    required MessageSender sender,
    String? group,
    required bool isDeleted,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
}

@freezed
class MessagesResponse with _$MessagesResponse {
  const factory MessagesResponse({
    required int page,
    required int totalPages,
    required int count,
    required List<Message> messages,
  }) = _MessagesResponse;

  factory MessagesResponse.fromJson(Map<String, dynamic> json) =>
      _$MessagesResponseFromJson(json);
}