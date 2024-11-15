import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../providers/create_post_provider.dart';
import '../../../utils/dialog_utils.dart';
import '../../theme/app_colors.dart';
import '../../widgets/location_picker.dart';
import '../../widgets/widgets.dart';
import 'create_post_screen.dart';

class ReportIncidentScreen extends ConsumerStatefulWidget {
  const ReportIncidentScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ReportIncidentScreen> createState() => _ReportIncidentScreenState();
}

class _ReportIncidentScreenState extends ConsumerState<ReportIncidentScreen> {
  final TextEditingController _incidentTypeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _isLoading = false;
  LatLng? _selectedLocation;
  List<String> _mediaUrls = []; // List to store media URLs

  Future<void> _reportIncident() async {
    setState(() => _isLoading = true); // Show loading indicator during submission

    final body = {
      "text": "${_incidentTypeController.text} - ${_descriptionController.text}",
      "media": _mediaUrls, // Use media URLs from uploaded files
      "stringAddress": _locationController.text,
      "geoAddress": {
        "type": "Point",
        "coordinates": [
          _selectedLocation?.longitude ?? 0.0,
          _selectedLocation?.latitude ?? 0.0
        ]
      }
    };

    final result = await ref.read(createIncidentProvider(body: jsonEncode(body)).future);

    setState(() => _isLoading = false); // Hide loading indicator after submission

    if (result != null) {
      ref.read(selectedAddressProvider.notifier).state = null;
      ref.read(selectedLocationProvider.notifier).state = null;
      showCustomModalDialog(
        context: context,
        image: SvgPicture.asset('assets/images/celebration-ic.svg'),
        title: 'Incident Reported Successfully',
        buttonText: 'Go Back',
        buttonAction: () => context.pop(),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to report incident. Please try again.')),
      );
    }
  }

  Future<void> _pickMedia() async {
    setState(() => _isLoading = true); // Show loader while uploading
    final mediaUrl = await ref.read(uploadFilesProvider.future);
    if (mediaUrl != null && mediaUrl.isNotEmpty) {
      setState(() {
        _mediaUrls.addAll(mediaUrl); // Add the media URLs to the list
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
            _locationController.text = address;
          });
        },
      ),
    );
  }

  bool _isFormComplete() {
    return _incidentTypeController.text.isNotEmpty &&
        _locationController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty;
  }

  @override
  void dispose() {
    _incidentTypeController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text(
              'Report an Incident',
              style: TextStyle(color: AppColors.textPrimary),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
              onPressed: () => context.pop(),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  controller: _incidentTypeController,
                  hintText: 'Enter Incident',
                  labelText: 'Incident Type*',
                ),
                CustomTextField(
                  controller: _locationController,
                  hintText: 'Enter location where the incident occurred',
                  labelText: 'Location of Incident*',
                  prefixIcon: const Icon(Icons.location_on, color: AppColors.textSecondary),
                  readOnly: true,
                  onTap: _showLocationPicker,
                ),
                CustomTextField(
                  controller: _descriptionController,
                  hintText: 'Please describe incident',
                  labelText: 'Description*',
                  maxLines: 5, // Larger input area for description
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.add_a_photo, color: AppColors.primary),
                      onPressed: _pickMedia,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Wrap(
                        spacing: 8.0,
                        children: _mediaUrls.map((url) => _buildMediaThumbnail(url)).toList(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                CustomButton(
                  text: 'Report Incident',
                  onPressed: _isFormComplete() ? _reportIncident : null,
                  color: _isFormComplete() ? AppColors.primary : Colors.grey,
                  isLoading: _isLoading,
                ),
              ],
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

  Widget _buildMediaThumbnail(String url) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: NetworkImage(url),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
