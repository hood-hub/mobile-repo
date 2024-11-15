import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_time_ago/get_time_ago.dart';

import '../../../models/comment_model.dart';
import '../../../providers/home_provider.dart';
import '../../../utils/snackbar_utils.dart';
import '../../theme/theme.dart';
import '../../widgets/social_post.dart';


class SocialPostPage extends ConsumerStatefulWidget {
  final SocialPost post;

  const SocialPostPage({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  ConsumerState<SocialPostPage> createState() => _SocialPostPageState();
}

class _SocialPostPageState extends ConsumerState<SocialPostPage> {
  final TextEditingController _commentController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _commentController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _handleSubmitComment() async {
    if (_commentController.text.trim().isEmpty) return;

    final success = await ref.read(postCommentProvider(
      postId: widget.post.post.id,
      comment: _commentController.text.trim(),
    ).future);

    if (success) {
      _commentController.clear();
      _focusNode.unfocus();

      // Refresh the comments after posting a comment
      ref.invalidate(getCommentsProvider(postId: widget.post.post.id));
    } else {
      SnackbarUtils.showTopSnackbar(
        context: context,
        message: 'Failed to post comment. Please try again.',
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print('postid: ${widget.post.post.id}');
    final commentsAsyncValue = ref.watch(getCommentsProvider(postId: widget.post.post.id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Post', style: TextStyle(color: AppColors.grey800)),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back, color: AppColors.grey800),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Display the original post
                  widget.post,
                  const Divider(height: 1),
                  // Comments section
                  commentsAsyncValue.when(
                    data: (comments) => _buildCommentsList(comments),
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (error, stack) => Center(child: Text('Error: $error $stack')),
                  ),
                ],
              ),
            ),
          ),
          // Comment input section
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            padding: const EdgeInsets.only(
              bottom: 8,
              left: 16,
              right: 16,
              top: 8,
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      focusNode: _focusNode,
                      decoration: InputDecoration(
                        hintText: 'Type your comment here',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                      ),
                      maxLines: 4,
                      minLines: 2,
                    ),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: _handleSubmitComment,
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                    child: const Text('Send'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentsList(List<CommentModel> comments) {
    if (comments.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: const Center(child: Text('No comments available')),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: comments.length,
      itemBuilder: (context, index) {
        final comment = comments[index];
        return _CommentItem(
          avatarUrl: comment.userId.profilePicture ?? 'https://hoodhub.blob.core.windows.net/hoodhub-container/HoodHubFullLogo-1728900343707-.png',
          username: '${comment.userId.username}',
          comment: comment.body,
          timeAgo: GetTimeAgo.parse(comment.createdAt),
        );
      },
    );
  }
}

class _CommentItem extends StatelessWidget {
  final String avatarUrl;
  final String username;
  final String comment;
  final String timeAgo;

  const _CommentItem({
    Key? key,
    required this.avatarUrl,
    required this.username,
    required this.comment,
    required this.timeAgo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(avatarUrl),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      username,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      timeAgo,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  comment,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
