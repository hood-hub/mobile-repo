import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hoodhub/models/user_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../screens/explore/create_custom_marker.dart';

class MapImageWidget extends StatefulWidget {
  final UserModel? user;
  final double? latitude;
  final double? longitude;

  const MapImageWidget({
    Key? key,
    this.user,
    this.latitude,
    this.longitude,
  }) : super(key: key);

  @override
  State<MapImageWidget> createState() => _MapImageWidgetState();
}

class _MapImageWidgetState extends State<MapImageWidget> {

  var isLoading = true;

  BitmapDescriptor? icon = null;

  @override
  void initState() {
    setIcon();
    super.initState();
  }

  setIcon() async {
    setState(() async {
      icon = await _createCustomMarker();
      isLoading = false;
    });
  }


  Completer<GoogleMapController> _controller = Completer();
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  Future<void> _launchMapsUrl(double lat, double lng) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<BitmapDescriptor> _createCustomMarker() async {
    try {
      return BitmapDescriptor.defaultMarker;
      return await createCustomMarker(
        widget.user?.profilePicture ??
            'https://hoodhub.blob.core.windows.net/hoodhub-container/HoodHubFullLogo-1728900343707-.png',
        widget.user?.username ?? 'Unknown',
      );

    } catch (e) {
      print('Error creating custom marker: $e');
      setState(() {
        isLoading = false;
      });
      return BitmapDescriptor.defaultMarker;
    }

  }

  @override
  Widget build(BuildContext context) {
    if (widget.latitude == null || widget.longitude == null) {
      return const Center(child: Text("No location data available"));
    }

    return/* icon== null ? const Center(child: CircularProgressIndicator()) :*/ ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: double.infinity,
        width: double.infinity,
        child: GoogleMap(
          onMapCreated: _onMapCreated,
          markers: {
            Marker(
              visible: true,
              markerId: MarkerId(widget.user?.id ?? ''),
              position: LatLng(widget.latitude!, widget.longitude!),
              infoWindow: InfoWindow(title: widget.user?.username ?? ''),
              //icon: icon!
            ),
          },
          initialCameraPosition: CameraPosition(
            target: LatLng(widget.latitude!, widget.longitude!),
            zoom: 14.0,
          ),
          //onTap: (_) => _launchMapsUrl(widget.latitude!, widget.longitude!),
          zoomControlsEnabled: false,
          mapToolbarEnabled: false,
          myLocationButtonEnabled: false,
        ),
      ),
    );
  }
}
