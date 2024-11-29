import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hoodhub/ui/screens/chat/chat_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/create_post_provider.dart';
import '../../theme/theme.dart';
import 'add_members.dart';
import 'approve_request_screen.dart';
import 'chat_provider.dart';
import 'message_bubble_widget.dart';


class MessagingScreen extends ConsumerStatefulWidget {
  final String chatId;
  final bool isGroup;
  final ChatItemModel chatItemModel;

  const MessagingScreen({
    Key? key,
    required this.chatId,
    required this.isGroup,
    required this.chatItemModel
  }) : super(key: key);

  @override
  ConsumerState<MessagingScreen> createState() => _MessagingScreenState();
}

class _MessagingScreenState extends ConsumerState<MessagingScreen> {
  final TextEditingController _messageController = TextEditingController();
  String? currentUserId;
  bool _isLoading = true;
  var lastMessages = [];

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    final user = await ref.read(userNotifierProvider.future);

    setState(() {
      _isLoading = false;
      currentUserId = user?.id;
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage(String content, List<String> media) async {
    if ((content.trim().isEmpty && media.isEmpty) || _isLoading) return;

    setState(() => _isLoading = true);

    try {
      await ref.read(messageNotifierProvider(widget.chatId, widget.isGroup).notifier)
          .sendMessage(content, media: media);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send message: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }


  @override
  Widget build(BuildContext context) {
    var chatItemModel = widget.chatItemModel;
    var isGroup = widget.isGroup;
    final messagesAsync = ref.watch(
      messageNotifierProvider(widget.chatId, widget.isGroup),
    );
    final currentUser = ref.watch(userNotifierProvider);

    return currentUser.when(
        data: (data) {
          var userId = data?.id!;

          // Check if the current user is an admin
          final isAdmin = isGroup && chatItemModel.admins.contains(userId);

          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.white,
              leading: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min, // Ensures row takes only the required space
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
                      onPressed: () => context.pop(),
                    ),
                  ],
                ),
              ),
              leadingWidth: 60,
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(
                      isGroup
                          ? chatItemModel.groupImage ??
                          'https://hoodhub.blob.core.windows.net/hoodhub-container/HoodHubFullLogo-1728900354345-.png'
                          : (chatItemModel.firstPartyId == userId
                          ? chatItemModel.secondPartyProfilePicture ?? ''
                          : chatItemModel.firstPartyProfilePicture ?? ''),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      isGroup
                          ? chatItemModel.name
                          : (chatItemModel.firstPartyId == userId
                          ? chatItemModel.secondPartyUsername ?? ''
                          : chatItemModel.firstPartyUsername ?? ''),
                      style: TextStyles.appBarTitle.copyWith(color: AppColors.grey800),
                      overflow: TextOverflow.ellipsis, // Prevents overflow
                    ),
                  ),
                ],
              ),
              actions: [
                if (isAdmin)
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'add_members') {
                        // Add members for public groups
                        if (chatItemModel.visibility == 'public') {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (BuildContext context) {
                              return AddMembersBottomSheet(groupId: chatItemModel.id);
                            },
                          );
                        } else if (chatItemModel.visibility == 'private') {
                          // Manage requests for private groups
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AdminRequestsScreen(groupId: chatItemModel.id),
                            ),
                          );
                        }
                      }
                    },
                    icon: const Icon(Icons.more_vert, color: AppColors.grey800),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'add_members',
                        child: Text(
                          chatItemModel.visibility == 'public'
                              ? 'Add Members'
                              : 'Manage Requests',
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: messagesAsync.when(
                    data: (messages) {
                      lastMessages = messages;

                      return ListView.builder(
                        reverse: true,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          final isCurrentUser = message.sender.id == currentUserId;

                          return MessageBubble(
                            message: message,
                            isCurrentUser: isCurrentUser,
                            showSender: widget.isGroup && !isCurrentUser,
                          );
                        },
                      );
                    },
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (error, stack) => ListView.builder(
                      reverse: true,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      itemCount: lastMessages.length,
                      itemBuilder: (context, index) {
                        final message = lastMessages[index];
                        final isCurrentUser = message.sender.id == currentUserId;

                        return MessageBubble(
                          message: message,
                          isCurrentUser: isCurrentUser,
                          showSender: widget.isGroup && !isCurrentUser,
                        );
                      },
                    ),
                  ),
                ),
                MessageInput(
                  controller: _messageController,
                  isLoading: _isLoading,
                  onSend: _sendMessage,
                ),
              ],
            ),
          );
        },
        error: (e, s) => SizedBox(),
        loading: () => SizedBox());
  }

}

/*
class MessageBubble extends StatelessWidget {
  final Message message;
  final bool isCurrentUser;
  final bool showSender;

  const MessageBubble({
    Key? key,
    required this.message,
    required this.isCurrentUser,
    required this.showSender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isCurrentUser ? AppColors.primary : AppColors.grey500,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showSender) ...[
              Text(
                message.sender.username,
                style: TextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.grey800,
                ),
              ),
              const SizedBox(height: 4),
            ],
            Text(
              message.content,
              style: TextStyles.bodyMedium.copyWith(
                color: isCurrentUser ? AppColors.white : AppColors.grey800,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _formatTimestamp(message.createdAt),
              style: TextStyles.bodyMedium.copyWith(
                color: isCurrentUser
                    ? AppColors.white.withOpacity(0.7)
                    : AppColors.grey500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return DateFormat('MMM d, h:mm a').format(timestamp);
    } else {
      return DateFormat('h:mm a').format(timestamp);
    }
  }
}
*/

class MessageInput extends ConsumerStatefulWidget {
  final TextEditingController controller;
  final bool isLoading;
  final Function(String content, List<String> media) onSend;

  const MessageInput({
    Key? key,
    required this.controller,
    required this.isLoading,
    required this.onSend,
  }) : super(key: key);

  @override
  ConsumerState<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends ConsumerState<MessageInput> {
  List<String> _mediaUrls = [];
  bool _isUploading = false;
  bool _filesAdded = false;

  Future<void> _pickMedia() async {
    try {
      setState(() {
        _isUploading = true;
      });
      final fileUrls = await ref.read(uploadFilesProvider.future);
      if (fileUrls != null) {
        setState(() {
          _mediaUrls = fileUrls;
          _filesAdded = true;
        });
      }
    } catch (e) {
      print('Error uploading files: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload media: $e')),
      );
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  void _handleSend() {
    if (widget.controller.text.trim().isEmpty && _mediaUrls.isEmpty) return;
    widget.onSend(widget.controller.text.trim(), _mediaUrls);
    widget.controller.clear();
    setState(() {
      _mediaUrls = [];
      _filesAdded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_filesAdded) ...[
          Container(
            height: 100,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _mediaUrls.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 8),
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(_mediaUrls[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 12,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _mediaUrls.removeAt(index);
                            if (_mediaUrls.isEmpty) _filesAdded = false;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppColors.grey800.withOpacity(0.7),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            size: 16,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.grey500.withOpacity(0.5),
                blurRadius: 4,
                offset: const Offset(0, -1),
              ),
            ],
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: _isUploading ? null : _pickMedia,
                icon: _isUploading
                    ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
                    : const Icon(Icons.add_photo_alternate_outlined),
                color: AppColors.grey500,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    hintStyle: TextStyles.bodyMedium.copyWith(
                      color: AppColors.grey500,
                    ),
                    filled: true,
                    fillColor: AppColors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  maxLines: null,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => _handleSend(),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: widget.isLoading ? null : _handleSend,
                icon: widget.isLoading
                    ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
                    : const Icon(Icons.send_rounded),
                color: AppColors.primary,
              ),
            ],
          ),
        ),
      ],
    );
  }
}