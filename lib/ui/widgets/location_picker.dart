import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../theme/app_colors.dart';

class LocationPicker extends StatefulWidget {
  final Function(String address, LatLng location) onSelected;

  const LocationPicker({Key? key, required this.onSelected}) : super(key: key);

  @override
  _LocationPickerState createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  final TextEditingController addressController = TextEditingController();
  List<dynamic> predictions = [];
  String apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'] ?? '';
  LatLng? selectedLocation;

  // Autocomplete search
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

  // Select an address
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

      // Call the onSelected callback to pass the selected location to the parent
      widget.onSelected(prediction['description'], LatLng(lat, lng));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.close), onPressed: () { Navigator.pop(context); },

              ),
            ),
            const Text(
              'Select Location',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.grey800
              ),
            ),
            const SizedBox(height: 16),
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
              SizedBox(
                height: 140,
                child: ListView.builder(
                  itemCount: predictions.length,
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.location_on),
                      title: Text(predictions[index]['description']),
                      onTap: () => selectAddress(predictions[index]),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    addressController.dispose();
    super.dispose();
  }
}
