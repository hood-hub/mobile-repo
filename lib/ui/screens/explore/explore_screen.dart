import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hoodhub/models/user_model.dart';

import '../../../providers/auth_provider.dart';
import '../../../providers/dio_providers/dio_provider.dart';
import '../../theme/app_colors.dart';
import '../../theme/text_styles.dart';
import '../../widgets/map_image_widget.dart';
import '../chat/chat_item.dart';
import '../chat/chat_provider.dart';
import '../chat/messaging_screen.dart';
import 'create_custom_marker.dart';

class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends ConsumerState<ExploreScreen> {

  Future<BitmapDescriptor> _createCustomMarker(UserModel user) async {
    try {
      return await createCustomMarker(
        user.profilePicture ??
            'https://hoodhub.blob.core.windows.net/hoodhub-container/HoodHubFullLogo-1728900343707-.png',
        user.username ?? 'Unknown',
      );
    } catch (e) {
      print('Error creating custom marker: $e');
      return BitmapDescriptor.defaultMarker;
    }
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(userNotifierProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Explore Nearby',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  // Events Map Card with Google Map image
                  userAsync.when(
                    data: (user) {

                      final coordinates = user?.geoAddress?.coordinates;
                      final latitude = coordinates != null && coordinates.isNotEmpty ? coordinates[1] : null;
                      final longitude = coordinates != null && coordinates.isNotEmpty ? coordinates[0] : null;
                      print("$longitude, $latitude");
                      return EventsMapCard(user: user, latitude: latitude, longitude: longitude);
                    },
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (error, stack) => Center(child: Text('Error: $error')),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Groups to join',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.grey800,
                        ),
                      ),
/*                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'See all',
                          style: TextStyle(fontSize: 14),
                        ),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.grey700,
                          padding: EdgeInsets.zero,
                        ),
                      ),*/
                    ],
                  ),
                  const SizedBox(height: 16),
                  AllGroupsList()
                 // ..._groups.map((group) => GroupListItem(group: group)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GroupItem {
  final String imageUrl;
  final String name;
  final int memberCount;
  final List<dynamic> memberAvatars;
  final bool isPrivate;

  GroupItem({
    required this.imageUrl,
    required this.name,
    required this.memberCount,
    required this.memberAvatars,
    required this.isPrivate,
  });
}

class GroupListItem extends ConsumerWidget {
  final GroupItem group;
  final Map<String, dynamic> groupMap;

  const GroupListItem({Key? key, required this.group, required this.groupMap}) : super(key: key);



  @override
  Widget build(BuildContext context, WidgetRef ref) {

    void _onGroupTap(BuildContext context, Map<String, dynamic> group) async {
      final currentUser = await ref.read(userNotifierProvider.future);
      final currentUserId = currentUser?.id;
      print(currentUser);

      if (group['visibility'] == 'public') {
        final members = group['members'] ?? [];

        final isUserInGroup = members.any((member) => member['_id'] == currentUserId);

        if (!isUserInGroup) {
          try {
            final dio = ref.read(dioServiceProvider);
            final body = jsonEncode({"userIds": [currentUserId]});

            final response = await dio.putRequest(
              '/api/v1/group/add-members/${group['_id']}',
              data: body,
            );

            if (response.data['success'] == true) {
              final chatItemModel = ChatItemModel(
                id: group['_id'],
                name: group['name'],
                description: group['description'],
                visibility: group['visibility'],
                noOfMembers: group['noOfMembers'] + 1,
                groupImage: group['groupImage'],
                members: [],
                admins: group['admins'],
                updatedAt: DateTime.parse(group['updatedAt']),
              );

              // Navigate to MessagingScreen
              context.pushNamed(
                'messaging',
                queryParams: {
                  'chatId': chatItemModel.id,
                },
                extra: {
                  'isGroup': true,
                  'chatItemModel': chatItemModel
                },
              );

            }
          } catch (e,s) {
            print('Error joining group: $e $s');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error joining group: $e $s')),
            );
          }
        } else {
          print('jfjf');
          final chatItemModel = ChatItemModel(
            id: group['_id'],
            name: group['name'],
            description: group['description'],
            visibility: group['visibility'],
            noOfMembers: group['noOfMembers'] + 1,
            groupImage: group['groupImage'],
            members: [],
            admins: group['admins'],
            updatedAt: DateTime.parse(group['updatedAt']),
          );

          // Navigate to MessagingScreen
          context.pushNamed(
            'messaging',
            queryParams: {
              'chatId': chatItemModel.id,
            },
            extra: {
              'isGroup': true,
              'chatItemModel': chatItemModel
            },
          );
        }

        ref.refresh(getChatListProvider);
      } else {
        // Show a dialog for requesting to join the private group
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Request to Join'),
              content: const Text('Would you like to request to join this group?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    try {
                      final dio = ref.read(dioServiceProvider);
                      await dio.putRequest(
                        '/api/v1/group/request-to-join-group/${group['_id']}',
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Request sent successfully')),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error sending request: $e')),
                      );
                    }
                  },
                  child: const Text('Request'),
                ),
              ],
            );
          },
        );
      }
    }

    return InkWell(
      onTap: () => _onGroupTap(context, groupMap),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                group.imageUrl,
                width: 77,
                height: 74,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 77,
                  height: 74,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (group.isPrivate)
                        const Icon(Icons.lock, size: 16, color: AppColors.grey500),
                      Text(
                        group.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.grey800,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '${group.memberCount} members',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.grey500,
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    height: 40,
                    child: Stack(
                      children: [
                        for (var i = 0; i < group.memberAvatars.length.clamp(0, 4); i++)
                          Positioned(
                            left: i * 20.0,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 12,
                                backgroundImage: NetworkImage(group.memberAvatars[i]),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}




class AllGroupsList extends ConsumerWidget {
  const AllGroupsList({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupListState = ref.watch(groupListNotifierProvider);
    final notifier = ref.read(groupListNotifierProvider.notifier);

    return RefreshIndicator(
      onRefresh: () async {
        await notifier.refresh();
      },
      child: groupListState.when(
        data: (groups) {
          return ListView.builder(
            itemCount: groups.length + (notifier.isLastPage ? 0 : 1),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              if (index < groups.length) {
                final group = groups[index];
                return GroupListItem(
                  group: GroupItem(
                    imageUrl: group['groupImage'] ?? 'https://hoodhub.blob.core.windows.net/hoodhub-container/HoodHubFullLogo-1728900343707-.png',
                    name: group['name'],
                    memberCount: group['noOfMembers'],
                    memberAvatars: group['members'] ?.map((member) => (member['profilePicture'] ?? 'https://hoodhub.blob.core.windows.net/hoodhub-container/HoodHubFullLogo-1728900343707-.png') as String?).toList() ?? [],
                    isPrivate: group['visibility'] == 'private',
                  ), groupMap: group,
                );
              } else {
                // Pagination loader
                notifier.loadMore();
                return const Center(child: CircularProgressIndicator());
              }
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }
}


class EventsMapCard extends StatelessWidget {
  final UserModel? user;
  final double? latitude;
  final double? longitude;

  const EventsMapCard({
    Key? key,
    this.user,
    this.latitude,
    this.longitude,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 286,
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Stack(
        children: [
          // Replace image asset with MapImageWidget
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: MapImageWidget(
              user: user,
              latitude: latitude,
              longitude: longitude,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                child: Container(
                  height: 286 * 1 / 3,
                  width: double.infinity,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  'EVENTS & MAPS',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff027A48),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "See what's happening around your neighborhood.",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.grey800,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.push('/full-map');
                      },
                      child: const Text(
                        'View more',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xff027A48),
                        textStyle: TextStyles.bodyMedium,
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
