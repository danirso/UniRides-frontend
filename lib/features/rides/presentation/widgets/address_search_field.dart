import 'package:flutter/material.dart';
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

class _SimplePrediction {
  final String placeId;
  final String primaryText;
  final String secondaryText;
  final String fullText;

  const _SimplePrediction({
    required this.placeId,
    required this.primaryText,
    required this.secondaryText,
    required this.fullText,
  });
}

class AddressSearchField extends StatefulWidget {
  final String label;
  final String widgetKey;
  final TextEditingController controller;
  final void Function(PlaceResult) onPlaceSelected;

  const AddressSearchField({
    super.key,
    required this.label,
    required this.widgetKey,
    required this.controller,
    required this.onPlaceSelected,
  });

  @override
  State<AddressSearchField> createState() => _AddressSearchFieldState();
}

class _AddressSearchFieldState extends State<AddressSearchField> {
  List<_SimplePrediction> _predictions = [];
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

    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      setState(() => _isLoading = true);
      try {
        const apiKey = String.fromEnvironment('GOOGLE_MAPS_KEY');
        final uri = Uri.parse(
          'https://maps.googleapis.com/maps/api/place/autocomplete/json'
          '?input=${Uri.encodeComponent(value)}'
          '&key=$apiKey'
          '&language=pt-BR'
          '&components=country:br',
        );
        final response = await http.get(uri);
        final data = jsonDecode(response.body);

        if (data['status'] == 'OK') {
          final predictions = (data['predictions'] as List)
              .map(
                (p) => _SimplePrediction(
                  placeId: p['place_id'],
                  primaryText: p['structured_formatting']['main_text'] ?? '',
                  secondaryText:
                      p['structured_formatting']['secondary_text'] ?? '',
                  fullText: p['description'] ?? '',
                ),
              )
              .toList();
          setState(() => _predictions = predictions);
        } else {
          setState(() => _predictions = []);
        }
      } catch (e) {
        debugPrint('Erro autocomplete: $e');
        setState(() => _predictions = []);
      } finally {
        setState(() => _isLoading = false);
      }
    });
  }

  Future<void> _onPredictionSelected(_SimplePrediction prediction) async {
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
        widget.onPlaceSelected(
          PlaceResult(address: address, lat: lat, lng: lng),
        );
      }
    } catch (e) {
      debugPrint('Erro geocoding: $e');
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
          identifier: '${widget.widgetKey}_input',
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
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: _predictions.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final prediction = _predictions[index];
                  return Semantics(
                    identifier: '${widget.widgetKey}_prediction_$index',
                    button: true,
                    label: prediction.fullText,
                    child: ListTile(
                      key: Key('${widget.widgetKey}_prediction_$index'),
                      leading: const Icon(Icons.location_on_outlined),
                      title: Text(
                        prediction.primaryText,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        prediction.secondaryText,
                        style: const TextStyle(fontSize: 12),
                      ),
                      onTap: () => _onPredictionSelected(prediction),
                    ),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}
