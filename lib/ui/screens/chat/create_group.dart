import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/create_post_provider.dart';
import '../../../providers/dio_providers/dio_provider.dart';
import '../../theme/theme.dart';
import 'add_members.dart';
import 'chat_provider.dart';



class CreateGroupBottomSheet extends ConsumerStatefulWidget {
  const CreateGroupBottomSheet({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateGroupBottomSheet> createState() =>
      _CreateGroupBottomSheetState();
}

class _CreateGroupBottomSheetState extends ConsumerState<CreateGroupBottomSheet> {
  final TextEditingController _groupNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _isPrivate = true;
  String? _groupImageUrl;
  bool _isLoading = false;

  Future<void> _pickMedia() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final fileUrls = await ref.read(uploadFilesProvider.future);
      if (fileUrls != null && fileUrls.isNotEmpty) {
        setState(() {
          _groupImageUrl = fileUrls.first;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading group image: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _createGroup() async {
    if (_groupNameController.text.trim().isEmpty ||
        _descriptionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Group Name and Description are required')),
      );
      return;
    }

    try {
      setState(() {
        _isLoading = true;
      });

      final dio = ref.read(dioServiceProvider);
      final response = await dio.postRequest('/api/v1/group', data: {
        "name": _groupNameController.text.trim(),
        "visibility": _isPrivate ? "private" : "public",
        "description": _descriptionController.text.trim(),
        "groupImage": _groupImageUrl,
      });

      if (response.data['success'] == true) {
        final groupId = response.data['data']['_id'];

        if (_isPrivate) {
          Navigator.pop(context); // Close bottom sheet if group is private
        } else {
          Navigator.pop(context);
          // Navigate to the third bottom sheet if group is public
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (BuildContext context) {
              return AddMembersBottomSheet(groupId: groupId);
            },
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.data['message'] ?? 'Failed to create group')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error creating group: $e')),
      );
    } finally {
      ref.read(groupListNotifierProvider.notifier).refresh();
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
                    icon: const Icon(Icons.arrow_back, color: AppColors.primary),
                  ),
                  const Text(
                    'Create Group',
                    style: TextStyles.headlineSmall,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: _isLoading ? null : _pickMedia,
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: AppColors.grey500,
                  backgroundImage:
                  _groupImageUrl != null ? NetworkImage(_groupImageUrl!) : null,
                  child: _groupImageUrl == null && !_isLoading
                      ? const Icon(Icons.camera_alt, color: AppColors.grey500)
                      : _isLoading
                      ? const CircularProgressIndicator()
                      : null,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _groupNameController,
                decoration: InputDecoration(
                  labelText: 'Group Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text(
                    'Private Group',
                    style: TextStyles.bodyMedium,
                  ),
                  Switch(
                    value: _isPrivate,
                    inactiveThumbColor: AppColors.white,
                    inactiveTrackColor: AppColors.grey500,
                    onChanged: (value) {
                      setState(() {
                        _isPrivate = value;
                      });
                    },
                  ),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _isLoading ? null : _createGroup,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: AppColors.white)
                    : const Text('Create Group'),
              ),
            ],
          ),
        );
      },
    );
  }
}
