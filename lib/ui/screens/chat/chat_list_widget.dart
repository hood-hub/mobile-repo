/*
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/theme.dart';
import 'chat_item.dart';
import 'chat_provider.dart';

// ConsumerStatefulWidget for the chat list
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatList extends ConsumerStatefulWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  ConsumerState<ChatList> createState() => _ChatListState();
}

class _ChatListState extends ConsumerState<ChatList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent &&
        !ref.read(getChatListProvider.notifier).isLoading) {
      ref.read(getChatListProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatListState = ref.watch(getChatListProvider);

    return chatListState.when(
      data: (chatList) => ListView.builder(
        controller: _scrollController,
        itemCount: chatList.length + 1, // Add 1 for the loading indicator
        itemBuilder: (context, index) {

          if (index == chatList.length) {
            return ref.read(getChatListProvider.notifier).hasMore
                ? const Center(child: CircularProgressIndicator())
                : const SizedBox.shrink();
          }
          final chatData = chatList[index];
          final chatItemModel = ChatItemModel.fromJson(chatData);
          return ChatItem(chatItemModel: chatItemModel);
        },
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
*/
