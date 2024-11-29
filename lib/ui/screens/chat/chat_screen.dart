import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hoodhub/ui/screens/chat/start_chat.dart';
import '../../theme/theme.dart';
import '../../widgets/filter_radio_group_widget.dart';
import 'chat_item.dart';
import 'chat_provider.dart';


// ConsumerStatefulWidget for the chat screen with search and filter
class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  String _selectedFilter = 'groups';

  final ScrollController _scrollController = ScrollController();


  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent &&
          !ref.read(getChatListProvider.notifier).isLastPage) {
        print('dfdfggfd');
        ref.read(getChatListProvider.notifier).loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    final chatListState = ref.watch(getChatListProvider);


    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          'Chats',
          style: TextStyles.appBarTitle.copyWith(color: AppColors.grey800),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              color: AppColors.grey800,
            ),
            onPressed: () {
              Navigator.pop;
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (BuildContext context) {
                  return const StartChatBottomSheet();
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search TextField
            SizedBox(
              height: 40,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search people or groups',
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(90),
                    borderSide: const BorderSide(color: Color(0xFFF1F1F3), width: 1.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(90),
                    borderSide: const BorderSide(color: Color(0xFFF1F1F3), width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(90),
                    borderSide: const BorderSide(color: Color(0xFF6A0DAD), width: 1.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Filter options
            FilterRadioGroupWidget(
              options: const ['Groups', 'DMs'],
              currentValue: ref.watch(chatFilterProvider),
              onChanged: (newFilter) {
                ref.read(chatFilterProvider.notifier).updateFilter(newFilter);
                ref.read(getChatListProvider.notifier).refresh();
              },
            ),

            const SizedBox(height: 16),
            Expanded(
              child: chatListState.when(
                data: (chatList) => ListView.separated(
                  separatorBuilder: (context, index) =>
                  const Divider(color: AppColors.greyf1),
                  controller: _scrollController,
                  itemCount: chatList.length + 1, // Add 1 for the loading indicator
                  itemBuilder: (context, index) {
                    if (index < chatList.length) {
                      final chat = chatList[index];
                      return ChatItem(chatItemModel: ChatItemModel.fromJson(chat));
                    } else {
                      return ref
                          .read(getChatListProvider.notifier)
                          .isLastPage
                          ? const SizedBox.shrink()
                          : const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text('Error: $error')),
              ),
            )

            // List of chat items
        /*            const Expanded(
              child: ChatList(),
            ),*/
          ],
        ),
      ),
    );
  }
}



