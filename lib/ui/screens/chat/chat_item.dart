import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:go_router/go_router.dart';
import 'package:hoodhub/routes/app_router.dart';
import '../../../providers/auth_provider.dart';
import '../../theme/theme.dart';
import 'messaging_screen.dart';

// ChatItemModel to hold data for each chat item
class ChatItemModel {
  final String id;
  final String name;
  final String description;
  final String visibility;
  final int noOfMembers;
  final String? groupImage;
  final List<Map<String, dynamic>?> members;
  final List<dynamic> admins;
  final bool isGroup;
  final String? firstPartyUsername;
  final String? secondPartyUsername;
  final String? firstPartyProfilePicture;
  final String? secondPartyProfilePicture;
  final String? firstPartyId;
  final String? secondPartyId;
  final DateTime? updatedAt;

  ChatItemModel({
    required this.id,
    required this.name,
    required this.description,
    required this.visibility,
    required this.noOfMembers,
    this.groupImage,
     required this.members,
     required this.admins,
    this.firstPartyUsername,
    this.secondPartyUsername,
    this.firstPartyProfilePicture,
    this.secondPartyProfilePicture,
    this.firstPartyId,
    this.secondPartyId,
     this.updatedAt,
  }) : isGroup = admins.isNotEmpty;

  factory ChatItemModel.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('firstParty') && json.containsKey('secondParty')) {
      // Handling DM response
      return ChatItemModel(
        id: json['_id'] ?? '',
        name: '',
        description: '',
        visibility: 'public',
        noOfMembers: 2,
        members: [],
        admins: [],
        firstPartyUsername: json['firstParty']['username'],
        secondPartyUsername: json['secondParty']['username'],
        firstPartyProfilePicture: json['firstParty']['profilePicture'],
        secondPartyProfilePicture: json['secondParty']['profilePicture'],
        firstPartyId: json['firstParty']['_id'],
        secondPartyId: json['secondParty']['_id'],
        updatedAt: DateTime.parse(json['updatedAt']),
      );
    } else {
      // Handling group response
      return ChatItemModel(
        id: json['_id'] ?? '',
        name: json['name'] ?? '',
        description: json['description'] ?? '',
        visibility: json['visibility'] ?? 'public',
        noOfMembers: json['noOfMembers'] ?? 0,
        groupImage: json['groupImage'],
        members: List<Map<String, dynamic>>.from(json['members'] ?? []),
        admins: List<String>.from(json['admins'] ?? []),
        updatedAt: DateTime.parse(json['updatedAt']),
      );
    }
  }
}




// ConsumerWidget for individual chat item
// ConsumerWidget for individual chat item
class ChatItem extends ConsumerWidget {
  final ChatItemModel chatItemModel;

  const ChatItem({
    Key? key,
    required this.chatItemModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isLocked = chatItemModel.visibility == 'private';
    bool isGroup = chatItemModel.isGroup;

    final currentUser = ref.watch(userNotifierProvider);



    return InkWell(
      onTap: () async {
        final currentUser = await ref.read(userNotifierProvider.future);
        if (currentUser != null) {
          final currentUserId = currentUser.id;
          final isUserInGroup = chatItemModel.members.any((member) => member?['_id'] == currentUserId);
          if (!isGroup || chatItemModel.visibility == 'public' || isUserInGroup) {
            context.pushNamed(
              'messaging',
              queryParams: {
                'chatId': chatItemModel.id,
              },
              extra: {
                'isGroup': isGroup,
                'chatItemModel': chatItemModel
              },
            );
          }
        }
      },
      child: currentUser.when(
          data: (data) {
            var userId = data?.id!;

            return Container(
              color: Colors.transparent,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(
                      isGroup
                          ? chatItemModel.groupImage ?? 'https://hoodhub.blob.core.windows.net/hoodhub-container/HoodHubFullLogo-1728900354345-.png'
                          : (chatItemModel.firstPartyId == userId
                          ? chatItemModel.secondPartyProfilePicture ?? ''
                          : chatItemModel.firstPartyProfilePicture ?? ''),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            if (isLocked)
                              const Icon(
                                Icons.lock,
                                size: 16,
                                color: Colors.grey,
                              ),
                            if (isLocked) const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                isGroup
                                    ? chatItemModel.name
                                    : (chatItemModel.firstPartyId == userId
                                    ? chatItemModel.secondPartyUsername ?? ''
                                    : chatItemModel.firstPartyUsername ?? ''),
                                style: TextStyles.headlineSmall.copyWith(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          chatItemModel.description,
                          style: TextStyles.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    GetTimeAgo.parse(chatItemModel.updatedAt!),
                    style: TextStyles.bodySmall.copyWith(color: AppColors.grey500),
                  ),
                ],
              ),
            );
          },
          error: (e,s) => SizedBox(),
          loading: () => SizedBox())
    );
  }
}