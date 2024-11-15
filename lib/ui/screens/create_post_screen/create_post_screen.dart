import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../providers/auth_provider.dart';
import '../../../providers/create_post_provider.dart';
import '../../../providers/home_provider.dart';
import '../../theme/app_colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/location_picker.dart';

final bottomNavIndexProvider = StateProvider<int>((ref) => 0);
final postContentProvider = StateProvider<String>((ref) => '');
final selectedLocationProvider = StateProvider<LatLng?>((ref) => null);
final selectedAddressProvider = StateProvider<String?>((ref) => null);

class CreatePostScreen extends ConsumerStatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends ConsumerState<CreatePostScreen> {
  final TextEditingController _postController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  List<String> _mediaUrls = [];
  bool _isLoading = false;
  bool _filesAdded = false;

  @override
  void initState() {
    super.initState();
    _postController.addListener(() {
      ref.read(postContentProvider.notifier).state = _postController.text;
    });
  }

  Future<void> _pickMedia() async {
    try {
      setState(() {
        _isLoading = true; // Show loader while uploading
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
    } finally {
      setState(() {
        _isLoading = false; // Hide loader once upload is complete
      });
    }
  }

  void _showLocationPicker() {
    showDialog(
      context: context,
      builder: (context) => LocationPicker(
        onSelected: (address, location) {
          print(address);
          print(location);
          ref.read(selectedAddressProvider.notifier).state = address;
          ref.read(selectedLocationProvider.notifier).state = location;
        },
      ),
    );
  }

  Future<void> _handlePostCreation() async {
    try {
      setState(() {
        _isLoading = true; // Show loader while creating the post
      });

      ref.invalidate(getUserProvider);
      final content = ref.read(postContentProvider);
      final selectedAddress = ref.read(selectedAddressProvider);
      final selectedLocation = ref.read(selectedLocationProvider);
      final user = await ref.read(userNotifierProvider.future);

      // Determine the address to use (either selected address or user's address)
      final String? address = selectedAddress ?? user?.stringAddress;
      final LatLng? location = selectedLocation ??
          LatLng(user?.geoAddress?.coordinates[0] ?? 0.0, user?.geoAddress?.coordinates[1] ?? 0.0);

      // Extract city and province from the address
      String reducedAddress = 'Canada'; // Default value if parsing fails
      if (address != null && address.isNotEmpty) {
        final addressParts = address.split(',').map((part) => part.trim()).toList();
        final city = addressParts.length > 0 ? addressParts[0] : '';
        final province = addressParts.length > 1 ? addressParts[1] : '';
        reducedAddress = '$city, $province';
      }

      final body = {
        "text": content,
        "media": _mediaUrls,
        "stringAddress": reducedAddress,
        "geoAddress": {
          "type": "Point",
          "coordinates": [location?.longitude, location?.latitude]
        }
      };

      var body2 = jsonEncode(body);

      final result = await ref.read(createPostProvider(body: body2).future);
      if (result != null) {
        // Clear the post content, selected address, and location
        _postController.clear();
        ref.read(postContentProvider.notifier).state = '';
        ref.read(selectedAddressProvider.notifier).state = null;
        ref.read(selectedLocationProvider.notifier).state = null;
        _mediaUrls.clear();

        // Invalidate the posts cache to force a refresh
        ref.invalidate(getPostsProvider);

        // Force refresh of the HomePostsNotifier
        ref.invalidate(homePostsNotifierProvider);
        FocusManager.instance.primaryFocus?.unfocus();

        // Navigate to the Home or reset the screen state
        ref.read(bottomNavIndexProvider.notifier).state = 0;
      }
    } on Exception catch (e, s) {
      print('create-post: $e $s');
    } finally {
      setState(() {
        _isLoading = false; // Hide loader once the post creation is complete
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    ref.watch(getUserProvider);
    ref.watch(userNotifierProvider);
    final postContent = ref.watch(postContentProvider);
    final selectedAddress = ref.watch(selectedAddressProvider);

    return Stack(
      children: [
        Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.black),
                        onPressed: () {
                          _postController.clear();
                          ref.read(postContentProvider.notifier).state = '';
                          ref.read(selectedAddressProvider.notifier).state = null;
                          ref.read(selectedLocationProvider.notifier).state = null;
                          _mediaUrls.clear();

                          ref.read(bottomNavIndexProvider.notifier).state = 0;
                        },
                      ),
                      CustomButton(
                        text: 'Post',
                        width: 78,
                        height: 40,
                        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                        fontSize: 14,
                        onPressed: postContent.isEmpty ? null : _handlePostCreation,
                        color: postContent.isEmpty ? Colors.grey : AppColors.primary,
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 400,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: _postController,
                      maxLines: null,
                      decoration: const InputDecoration(
                        hintText: "What's happening neighbor?",
                        fillColor: AppColors.backgroundColor,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      IconButton(
                        icon: SvgPicture.asset('assets/images/gallery.svg'),
                        onPressed: _pickMedia,
                      ),
                      IconButton(
                        icon: SvgPicture.asset('assets/images/select-map.svg'),
                        onPressed: _showLocationPicker,
                      ),
                      if (_filesAdded) // Show "Files Added" text with a check mark if files were added
                        const Row(
                          children: [
                            Icon(Icons.check_circle, color: Colors.green),
                            SizedBox(width: 4),
                            Text(
                              'Media Added',
                              style: TextStyle(color: Colors.green),
                            ),
                          ],
                        ),
                      if (selectedAddress != null)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('$selectedAddress', style: TextStyle(overflow: TextOverflow.ellipsis)),
                          ),
                        ),
                    ],
                  ),
                  const Divider(height: 1, color: AppColors.greyf1),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'More Options',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildOptionButton(
                          icon: SvgPicture.asset('assets/images/create-event.svg'),
                          text: 'Create an event',
                          onTap: () {},
                        ),
                        const SizedBox(height: 16),
                        _buildOptionButton(
                          icon: SvgPicture.asset('assets/images/incident.svg'),
                          text: 'Report an incident',
                          onTap: () {
                            context.push('/report-incident');
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (_isLoading)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }

  Widget _buildOptionButton({
    required Widget icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(width: 1, color: AppColors.buttonBorder),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 16),
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.grey800,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.chevron_right,
              color: Colors.grey,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _postController.dispose();
    super.dispose();
  }
}
