import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../../../providers/dio_providers/dio_provider.dart';
import '../../../utils/dialog_utils.dart';
import '../../../utils/snackbar_utils.dart';
import '../../theme/app_colors.dart';
import '../../theme/text_styles.dart';
import '../../widgets/widgets.dart';



class AddressScreen extends ConsumerStatefulWidget {
  final String userId;
  final String username;

  AddressScreen({Key? key, required this.userId, required this.username}) : super(key: key);

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends ConsumerState<AddressScreen> {
  final TextEditingController addressController = TextEditingController();
  List<dynamic> predictions = [];
  late GoogleMapController mapController;
  LatLng? selectedLocation;
  String apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'] ?? '';
  bool _isLoading = false;

  void autoCompleteSearch(String value) async {
    if (value.isNotEmpty) {
      final url = Uri.parse(
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$value&types=address&components=country:ca&key=$apiKey');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          predictions = json.decode(response.body)['predictions'];
        });
      }
    } else {
      setState(() {
        predictions = [];
      });
    }
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void selectAddress(dynamic prediction) async {
    final placeId = prediction['place_id'];
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=geometry&key=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final details = json.decode(response.body)['result'];
      final lat = details['geometry']['location']['lat'];
      final lng = details['geometry']['location']['lng'];

      setState(() {
        addressController.text = prediction['description'];
        selectedLocation = LatLng(lat, lng);
        predictions = [];
      });

/*      mapController.animateCamera(
        CameraUpdate.newLatLngZoom(selectedLocation!, 15),
      );*/
    }
  }

  Future<void> _completeOnboarding() async {
    if (addressController.text.isEmpty || selectedLocation == null) {
      SnackbarUtils.showTopSnackbar(
        context: context,
        message: 'Please select an address.',
        backgroundColor: Colors.red,
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Extract city and province from the address string
      final addressParts = addressController.text.split(',').map((part) => part.trim()).toList();
      final city = addressParts.length > 0 ? addressParts[0] : '';
      final province = addressParts.length > 1 ? addressParts[1] : '';
      final stringAddress = '$city, $province';

      final geoAddress = {
        "type": "Point",
        "coordinates": [selectedLocation!.longitude, selectedLocation!.latitude],
      };

      final authService = ref.read(authServiceProvider);
      bool isOnboarded = await authService.onboardUser(
        userId: widget.userId,
        username: widget.username,
        stringAddress: stringAddress,
        geoAddress: geoAddress,
      );

      if (isOnboarded) {
        showCustomModalDialog(
          context: context,
          image: SvgPicture.asset('assets/images/celebration-ic.svg'),
          title: 'Account all set',
          buttonText: 'Go to Home',
          buttonAction: () {
            context.push('/login'); // Navigate to the login screen
          },
        );
      } else {
        SnackbarUtils.showTopSnackbar(
          context: context,
          message: 'Failed to complete onboarding. Please try again.',
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      SnackbarUtils.showTopSnackbar(
        context: context,
        message: 'An error occurred: $e',
        backgroundColor: Colors.red,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return BaseFlowScreen(
      buttonText: _isLoading ? 'Loading...' : 'Next',
      buttonAction: _isLoading ? null : _completeOnboarding,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Where's your hood?",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                hintText: 'Enter your address',
                prefixIcon: Icon(
                  Icons.location_on_outlined,
                  color: AppColors.textSecondary,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) {
                autoCompleteSearch(value);
              },
            ),
            const SizedBox(height: 10),
            if (predictions.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: predictions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.location_on),
                    title: Text(predictions[index]['description'], style: TextStyles.headlineSmall),
                    onTap: () => selectAddress(predictions[index]),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    addressController.dispose();
    mapController.dispose();
    super.dispose();
  }
}
