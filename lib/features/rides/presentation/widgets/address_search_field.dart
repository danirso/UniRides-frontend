import 'package:flutter/material.dart';
import 'package:google_places_sdk_plus/google_places_sdk_plus.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PlaceResult {
  final String address;
  final double lat;
  final double lng;

  const PlaceResult({
    required this.address,
    required this.lat,
    required this.lng,
  });
}

class AddressSearchField extends StatefulWidget {
  final String label;
  final String widgetKey;
  final TextEditingController controller;
  final void Function(PlaceResult) onPlaceSelected;
  final FlutterGooglePlacesSdk placesClient;

  const AddressSearchField({
    super.key,
    required this.label,
    required this.widgetKey,
    required this.controller,
    required this.onPlaceSelected,
    required this.placesClient,
  });

  @override
  State<AddressSearchField> createState() => _AddressSearchFieldState();
}

class _AddressSearchFieldState extends State<AddressSearchField> {
  List<AutocompletePrediction> _predictions = [];
  bool _isLoading = false;
  bool _placeSelected = false;
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> _onChanged(String value) async {
    if (_placeSelected) {
      setState(() => _placeSelected = false);
    }

    if (value.length < 5) {
      setState(() => _predictions = []);
      return;
    }

    _debounce?.cancel;
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      setState(() => _isLoading = true);
    try {
      final result = await widget.placesClient.findAutocompletePredictions(
        value,
        countries: ['BR'],
        //placeTypesFilter: [PlaceTypeFilter.ADDRESS],
      );
      setState(() => _predictions = result.predictions);
    } catch (_) {
      setState(() => _predictions = []);
    } finally {
      setState(() => _isLoading = false);
    }
    
    });
  }

  Future<void> _onPredictionSelected(AutocompletePrediction prediction) async {
  setState(() {
    _isLoading = true;
    _predictions = [];
  });

  try {
    const apiKey = String.fromEnvironment('GOOGLE_MAPS_KEY');
    final uri = Uri.parse(
      'https://maps.googleapis.com/maps/api/geocode/json'
      '?place_id=${prediction.placeId}'
      '&key=$apiKey'
      '&language=pt-BR',
    );
    final response = await http.get(uri);
    final data = jsonDecode(response.body);

    if (data['status'] == 'OK') {
      final result = data['results'][0];
      final lat = result['geometry']['location']['lat'] as double;
      final lng = result['geometry']['location']['lng'] as double;
      final address = result['formatted_address'] as String;

      widget.controller.text = address;
      setState(() => _placeSelected = true);
      widget.onPlaceSelected(PlaceResult(address: address, lat: lat, lng: lng));
    }
  } catch (_) {

  } finally {
    setState(() => _isLoading = false);
  }
}

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(
          label: widget.label,
          textField: true,
          child: TextField(
            key: Key('${widget.widgetKey}_input'),
            controller: widget.controller,
            onChanged: _onChanged,
            decoration: InputDecoration(
              labelText: widget.label,
              suffixIcon: _isLoading
                  ? const Padding(
                      padding: EdgeInsets.all(12),
                      child: SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                  : _placeSelected
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : const Icon(Icons.search),
            ),
          ),
        ),
        if (_predictions.isNotEmpty)
          Card(
            margin: const EdgeInsets.only(top: 2),
            elevation: 4,
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _predictions.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final prediction = _predictions[index];
                return Semantics(
                  button: true,
                  label: prediction.fullText,
                  child: ListTile(
                    key: Key('${widget.widgetKey}_prediction_$index'),
                    leading: const Icon(Icons.location_on_outlined),
                    title: Text(
                      prediction.primaryText ?? '',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      prediction.secondaryText ?? '',
                      style: const TextStyle(fontSize: 12),
                    ),
                    onTap: () => _onPredictionSelected(prediction),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}