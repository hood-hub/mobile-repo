import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hoodhub/ui/screens/chat/chat_item.dart';
import '../../../models/user_model.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/dio_providers/dio_provider.dart';
import '../../../providers/explore_provider.dart';
import '../../theme/theme.dart';
import 'create_group.dart';
import 'messaging_screen.dart';


class StartChatBottomSheet extends ConsumerStatefulWidget {
  const StartChatBottomSheet({Key? key}) : super(key: key);

  @override
  ConsumerState<StartChatBottomSheet> createState() =>
      _StartChatBottomSheetState();
}

class _StartChatBottomSheetState extends ConsumerState<StartChatBottomSheet> {
  late Future<List<UserModel>?> nearbyUsersFuture;

  @override
  void initState() {
    super.initState();
    nearbyUsersFuture = ref.read(getNearByUsersProvider(distance: 20).future);
  }

  void _createDirectMessage(UserModel user) async {
    final dio = ref.read(dioServiceProvider);

    try {
      // Get current user details
      final currentUser = await ref.read(userNotifierProvider.future);

      if (currentUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Current user not found')),
        );
        return;
      }

      final response = await dio.postRequest(
        '/api/v1/message/direct-message',
        data: {
          "firstParty": currentUser.id, // Current user is the firstParty
          "secondParty": user.id, // Selected user is the secondParty
        },
      );

      if (response.data['success'] == true) {
        final chatData = response.data['data'];
        print(chatData);
        final chatItemModel = ChatItemModel(id: chatData['_id'], name: '${user.firstName} ${user.lastName}', description: '', visibility: 'public', noOfMembers: 0, firstPartyId: user.id, firstPartyProfilePicture: user.profilePicture, firstPartyUsername: user.username, members: [], admins: []);

        // Navigate to MessagingScreen with the new DM chat ID
        context.pushNamed(
          'messaging',
          queryParams: {
            'chatId': chatItemModel.id,
          },
          extra: {
            'isGroup': false,
            'chatItemModel': chatItemModel
          },
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.data['message'] ?? 'Failed to create direct message')),
        );
      }
    } catch (e,s) {
      print('Error creating direct message: $e $s');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error creating direct message: $e $s')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      maxChildSize: 0.9,
      minChildSize: 0.3,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: AppColors.primary),
                  ),
                  const Text(
                    'Start Chat',
                    style: TextStyles.headlineSmall,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (BuildContext context) {
                      return const CreateGroupBottomSheet();
                    },
                  );
                },
                child: Row(
                  children: const [
                    Icon(Icons.group_add, color: AppColors.primary),
                    SizedBox(width: 8),
                    Text('New Group', style: TextStyles.bodyMedium),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                child: FutureBuilder<List<UserModel>?>(
                  future: nearbyUsersFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (snapshot.hasError || snapshot.data == null) {
                      return const Center(
                        child: Text('Failed to load friends'),
                      );
                    }

                    final users = snapshot.data!;
                    if (users.isEmpty) {
                      return const Center(
                        child: Text('No nearby users found'),
                      );
                    }

                    return ListView.builder(
                      controller: scrollController,
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user = users[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(user.profilePicture ?? ''),
                          ),
                          title: Text(user.username ?? 'Unknown User'),
                          subtitle: Text(user.isVerified == true
                              ? 'online'
                              : 'last seen 5 minutes ago'),
                          onTap: () => _createDirectMessage(user),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
