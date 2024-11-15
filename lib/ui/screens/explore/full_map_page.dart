import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:ui' as ui;

import '../../../models/user_model.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/explore_provider.dart';
import 'create_custom_marker.dart';
import 'location_range_selection_dialog.dart';

class FullMapPage extends ConsumerStatefulWidget {
  const FullMapPage({Key? key}) : super(key: key);

  @override
  ConsumerState<FullMapPage> createState() => _FullMapPageState();
}

class _FullMapPageState extends ConsumerState<FullMapPage> {
  GoogleMapController? _controller;
  Set<Marker> _markers = {};
  LatLng _initialCenter = LatLng(40.7831, -73.9712); // Default center
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeMapData();
  }

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

  Future<void> _initializeMapData() async {
    try {
      // Get current user's location
      final currentUser = await ref.read(userNotifierProvider.future);
      final coordinates = currentUser?.geoAddress?.coordinates;
      if (coordinates != null && coordinates.length >= 2) {
        _initialCenter = LatLng(coordinates[1], coordinates[0]);

        // Create marker for current user
        final currentUserMarker = Marker(
          visible: true,
          markerId: MarkerId(currentUser!.id),
          position: _initialCenter,
          infoWindow: InfoWindow(title: currentUser?.username ?? 'Me'),
          icon: await _createCustomMarker(currentUser),
/*          icon: await _getMarkerIconFromUrl(
              currentUser.profilePicture ??
                  'https://hoodhub.blob.core.windows.net/hoodhub-container/HoodHubFullLogo-1728900343707-.png'
          )*/
        );

        _markers.add(currentUserMarker);
      }

      // Get nearby users
      final nearbyUsers = await ref.read(getNearByUsersProvider(distance: 20).future);
      if (nearbyUsers != null) {
        for (final user in nearbyUsers) {
          // Skip if this is the current user
          if (user.id == currentUser?.id) continue;

          if (user.geoAddress?.coordinates != null && user.geoAddress!.coordinates.length >= 2) {
            final lat = user.geoAddress!.coordinates[1];
            final lng = user.geoAddress!.coordinates[0];
            final icon = await _getMarkerIconFromUrl(
                user.profilePicture ??
                    'https://hoodhub.blob.core.windows.net/hoodhub-container/HoodHubFullLogo-1728900343707-.png'
            );

            final marker = Marker(
              visible: true,
              markerId: MarkerId(user.id),
              position: LatLng(lat, lng),
              infoWindow: InfoWindow(title: user.username ?? 'Unknown User'),
              icon: await _createCustomMarker(user),
              //icon: icon
            );
            _markers.add(marker);
          }
        }

        // Move camera to current user's location
        if (_controller != null) {
          _controller!.animateCamera(
            CameraUpdate.newLatLngZoom(_initialCenter, 13),
          );
        }

        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading map data: $e');
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading users')),
      );
    }
  }

  Future<BitmapDescriptor> _getMarkerIconFromUrl(String url) async {
    try {
      final http.Response response = await http.get(Uri.parse(url));
      final Uint8List bytes = response.bodyBytes;
      final ui.Codec codec = await ui.instantiateImageCodec(bytes, targetWidth: 100, targetHeight: 100);
      final ui.FrameInfo frameInfo = await codec.getNextFrame();
      final ByteData? byteData = await frameInfo.image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) return BitmapDescriptor.defaultMarker;
      return BitmapDescriptor.fromBytes(byteData.buffer.asUint8List());
    } catch (e) {
      print('Error loading marker icon: $e');
      return BitmapDescriptor.defaultMarker;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: _buildTopView(),
      ),
      body: _isLoading ? const Center(child: CircularProgressIndicator()) : Stack(
        children: [
          if (_isLoading)
            const Center(child: CircularProgressIndicator()),
          GoogleMap(
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
              // Move to user's location when map is created
              controller.animateCamera(
                CameraUpdate.newLatLngZoom(_initialCenter, 13),
              );
            },
            initialCameraPosition: CameraPosition(
              target: _initialCenter,
              zoom: 13,
            ),
            markers: _markers,
            zoomControlsEnabled: true,
            myLocationButtonEnabled: false,
          ),
        ],
      ),
    );
  }

  Widget _buildTopView() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          _buildSearchAndActions(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildSearchAndActions() {
    return Row(
     // mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: SizedBox(
            height: 40,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search, messages',
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
        ),
        const SizedBox(width: 10),
        _buildCustomActionButton(
          svgAsset: 'assets/images/filter.svg',
          onPressed: () async {
            final selectedDistance = await showLocationRangeDialog(context);
            if (selectedDistance != null) {
              setState(() {
                _isLoading = true;
              });
              _initializeMapData();
            }
          },
        ),
        const SizedBox(width: 10),
      ],
    );
  }

/*  // Search bar with action items (filter and notification icons)
  Widget _buildSearchAndActions() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 40,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search, messages',
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
        ),
        const SizedBox(width: 10),
        _buildCustomActionButton(
          svgAsset: 'assets/images/filter.svg',
          onPressed: () {},
        ),
        const SizedBox(width: 10),
        _buildCustomActionButton(
          svgAsset: 'assets/images/notification.svg',
          onPressed: () {},
        ),
      ],
    );
  }*/

  Widget _buildCustomActionButton({required String svgAsset, required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: const Color(0xFFF1F1F3), width: 0.83),
        ),
        child: Center(
          child: SvgPicture.asset(svgAsset),
        ),
      ),
    );
  }
}