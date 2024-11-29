import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/dio_providers/dio_provider.dart';
import '../../../providers/explore_provider.dart';
import '../../theme/theme.dart';
import '../../../models/user_model.dart';

class AddMembersBottomSheet extends ConsumerStatefulWidget {
  final String groupId;

  const AddMembersBottomSheet({Key? key, required this.groupId}) : super(key: key);

  @override
  ConsumerState<AddMembersBottomSheet> createState() =>
      _AddMembersBottomSheetState();
}

class _AddMembersBottomSheetState extends ConsumerState<AddMembersBottomSheet> {
  List<String> selectedUserIds = [];
  late Future<List<UserModel>?> nearbyUsersFuture;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    nearbyUsersFuture = ref.read(getNearByUsersProvider(distance: 20).future);
  }

  void _toggleUserSelection(String userId) {
    setState(() {
      if (selectedUserIds.contains(userId)) {
        selectedUserIds.remove(userId);
      } else {
        selectedUserIds.add(userId);
      }
    });
  }

  Future<void> _addMembersToGroup() async {
    if (selectedUserIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one member')),
      );
      return;
    }

    try {
      setState(() {
        _isLoading = true;
      });

      var body = jsonEncode({"userIds": selectedUserIds});

      final dio = ref.read(dioServiceProvider);
      final response = await dio.putRequest(
        '/api/v1/group/add-members/${widget.groupId}',
        data: body,
      );


      if (response.data['success'] == true) {
        Navigator.pop(context); // Close the bottom sheet
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Members added successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.data['message'] ?? 'Failed to add members')),
        );
      }
    } catch (e,s) {
      print(e);
      print(s);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding members: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      maxChildSize: 0.9,
      minChildSize: 0.3,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.all(16),
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
                    'Add Members',
                    style: TextStyles.headlineSmall,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: FutureBuilder<List<UserModel>?>(
                  future: nearbyUsersFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError || snapshot.data == null) {
                      return const Center(child: Text('Failed to load nearby users'));
                    }

                    final users = snapshot.data!;
                    if (users.isEmpty) {
                      return const Center(child: Text('No nearby users found'));
                    }

                    return ListView.builder(
                      controller: scrollController,
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user = users[index];
                        final isSelected = selectedUserIds.contains(user.id);

                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(user.profilePicture ?? ''),
                          ),
                          title: Text(user.username ?? 'Unknown User'),
                          subtitle: Text(user.isVerified == true
                              ? 'online'
                              : 'last seen recently'),
                          trailing: Checkbox(
                            value: isSelected,
                            onChanged: (value) => _toggleUserSelection(user.id),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _isLoading ? null : _addMembersToGroup,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: AppColors.white)
                    : const Text('Add Members'),
              ),
            ],
          ),
        );
      },
    );
  }
}