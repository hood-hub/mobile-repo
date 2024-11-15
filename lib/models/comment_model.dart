// lib/models/comment_model.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'user_model.dart';

part 'comment_model.freezed.dart';
part 'comment_model.g.dart';

@freezed
class CommentModel with _$CommentModel {
  factory CommentModel({
    @JsonKey(name: '_id') required String id,
    required String body,
    required UserModel userId,
    required String postId,
    required bool isDeleted,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _CommentModel;

  factory CommentModel.fromJson(Map<String, dynamic> json) => _$CommentModelFromJson(json);
}
