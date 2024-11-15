import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../models/user_model.dart';
import '../../../providers/account_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/create_post_provider.dart';
import '../../../utils/dialog_utils.dart';
import '../../theme/app_colors.dart';
import '../../widgets/location_picker.dart';
import '../../widgets/widgets.dart';
import '../create_post_screen/create_post_screen.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  bool _isEditing = true;
  bool _isInitialized = false;
  bool _isLoading = false; // Loader state
  String? _profileImageUrl;
  LatLng? _selectedLocation;
  String _reducedAddress = '';

/*  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _initializeControllers();
      _isInitialized = true;
    }
  }*/

  Future<void> _initializeControllers() async {
   // ref.invalidate(userNotifierProvider);
    final user = await ref.refresh(userNotifierProvider.future);
    print(user?.toJson());
    if (user != null) {
      setState(() {
        _firstNameController.text = user.firstName ?? '';
        _lastNameController.text = user.lastName ?? '';
        _usernameController.text = user.username ?? '';
        _emailController.text = user.email ?? '';
        _addressController.text = user.stringAddress ?? '';
        _profileImageUrl = user.profilePicture;
        _selectedLocation = user.geoAddress?.coordinates != null
            ? LatLng(user.geoAddress!.coordinates[0], user.geoAddress!.coordinates[1])
            : null;
      });
    }
  }

  Future<void> _pickMedia() async {
    setState(() => _isLoading = true); // Show loader while uploading
    final mediaUrl = await ref.read(uploadFilesProvider.future);
    if (mediaUrl != null && mediaUrl.isNotEmpty) {
      setState(() {
        _profileImageUrl = mediaUrl.first;
        _isEditing = true; // Show "Save Changes" when media is picked
      });
    }
    setState(() => _isLoading = false); // Hide loader after upload
  }

  void _showLocationPicker() {
    showDialog(
      context: context,
      builder: (context) => LocationPicker(
        onSelected: (address, location) {
          ref.read(selectedAddressProvider.notifier).state = address;
          ref.read(selectedLocationProvider.notifier).state = location;
          setState(() {
            _selectedLocation = location;
            _reducedAddress = _extractCityProvince(address);
            _addressController.text = address;
            _isEditing = true;
          });
        },
      ),
    );
  }

  String _extractCityProvince(String address) {
    final parts = address.split(',').map((part) => part.trim()).toList();
    final city = parts.isNotEmpty ? parts[0] : '';
    final province = parts.length > 1 ? parts[1] : '';
    return '$city, $province';
  }

  Future<void> _saveChanges() async {
    setState(() => _isLoading = true); // Show loader while saving changes
    final body = {
      "firstName": _firstNameController.text,
      "lastName": _lastNameController.text,
      "username": _usernameController.text,
      "stringAddress": _reducedAddress.isEmpty ? _addressController.text : _reducedAddress,
      "geoAddress": {
        "type": "Point",
        "coordinates": [_selectedLocation?.longitude ?? 105.381, _selectedLocation?.latitude ?? 62.227]
      },
      "profilePicture": _profileImageUrl ?? '',
    };

    final result = await ref.read(updateProfileProvider(body: jsonEncode(body)).future);
    setState(() => _isLoading = false); // Hide loader after save completes

    if (result != null) {
      ref.invalidate(getUserProvider);
      ref.invalidate(userNotifierProvider);
      ref.read(selectedAddressProvider.notifier).state = null;
      ref.read(selectedLocationProvider.notifier).state = null;
      setState(() {
        _isEditing = false;
      });
      showCustomModalDialog(
        context: context,
        image: SvgPicture.asset('assets/images/celebration-ic.svg'),
        title: 'Profile Updated',
        buttonText: 'Go Back',
        buttonAction: () {
          //ref.invalidate(userNotifierProvider);
          context.pop();
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update profile. Please try again.')),
      );
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(userNotifierProvider);

    return Stack(
      children: [
        userAsync.when(
          data: (user) {
            if (user != null) {
              setState(() {
                _firstNameController.text = user.firstName ?? '';
                _lastNameController.text = user.lastName ?? '';
                _usernameController.text = user.username ?? '';
                _emailController.text = user.email ?? '';
                _addressController.text = user.stringAddress ?? '';
                _profileImageUrl = user.profilePicture;
                _selectedLocation = user.geoAddress?.coordinates != null
                    ? LatLng(user.geoAddress!.coordinates[0], user.geoAddress!.coordinates[1])
                    : null;
              });
            }

            return BaseFlowScreen(
              title: 'Edit Profile',
              buttonText: 'Save Changes',
              buttonAction: _isEditing ? _saveChanges : null,
              child: Column(
                children: [
                  _buildProfileSummary(user!),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _firstNameController,
                    hintText: 'Enter your first name',
                    labelText: 'First Name*',
                  ),
                  CustomTextField(
                    controller: _lastNameController,
                    hintText: 'Enter your last name',
                    labelText: 'Last Name*',
                  ),
                  CustomTextField(
                    controller: _usernameController,
                    hintText: 'Enter your username',
                    labelText: 'Username*',
                  ),
                  CustomTextField(
                    controller: _emailController,
                    hintText: 'Enter your email',
                    labelText: 'Email*',
                  ),
                  CustomTextField(
                    controller: _addressController,
                    hintText: 'Enter your address',
                    labelText: 'Address',
                    readOnly: true,
                    onTap: _showLocationPicker,
                  ),
                  const SizedBox(height: 20),
                  //_buildOptionsRow(),
                ],
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('Error: $err')),
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

  Widget _buildProfileSummary(UserModel user) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFF1F1F3), width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: _pickMedia,
            child: CircleAvatar(
              radius: 40,
              backgroundImage: _profileImageUrl != null
                  ? NetworkImage(_profileImageUrl!)
                  : null,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '${user.firstName} ${user.lastName}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 4),
          Text(
            user.email ?? '',
            style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_on, size: 16, color: AppColors.textSecondary),
              const SizedBox(width: 4),
              Text(
                user.stringAddress ?? 'No address provided',
                style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOptionsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          icon: const Icon(Icons.photo_camera, color: AppColors.primary),
          onPressed: _pickMedia,
        ),
        IconButton(
          icon: const Icon(Icons.location_on, color: AppColors.primary),
          onPressed: _showLocationPicker,
        ),
        if (_profileImageUrl != null)
          Row(
            children: const [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 4),
              Text("Files Added"),
            ],
          ),
      ],
    );
  }
}
