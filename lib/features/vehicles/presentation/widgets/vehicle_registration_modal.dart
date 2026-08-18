import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcc_caronas_frontend/generated/l10n/app_localizations.dart';
import '../controllers/vehicle_controller.dart';

class VehicleRegistrationModal extends ConsumerStatefulWidget {
  const VehicleRegistrationModal({super.key});

  @override
  ConsumerState<VehicleRegistrationModal> createState() =>
      _VehicleRegistrationModalState();
}

class _VehicleRegistrationModalState
    extends ConsumerState<VehicleRegistrationModal> {
  final _formKey = GlobalKey<FormState>();
  final _plateController = TextEditingController();
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _colorController = TextEditingController();
  final _capacityController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _plateController.dispose();
    _brandController.dispose();
    _modelController.dispose();
    _colorController.dispose();
    _capacityController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final capacity = int.tryParse(_capacityController.text.trim()) ?? 0;

    final success = await ref
        .read(vehicleControllerProvider.notifier)
        .addVehicle(
          plate: _plateController.text.trim(),
          brand: _brandController.text.trim(),
          model: _modelController.text.trim(),
          color: _colorController.text.trim(),
          capacity: capacity,
        );

    if (!mounted) return;
    setState(() => _isLoading = false);

    final l10n = AppLocalizations.of(context)!;

    if (success) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.vehicleRegisteredSuccess)));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.vehicleRegisteredError)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Semantics(
      identifier: 'modal_register_vehicle',
      container: true,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Semantics(
                  header: true,
                  child: Text(
                    l10n.registerVehicleTitle,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16),
                Semantics(
                  identifier: 'vehicle_plate_input',
                  label: l10n.vehiclePlateLabel,
                  child: TextFormField(
                    key: const Key('vehicle_plate_input'),
                    controller: _plateController,
                    decoration: InputDecoration(
                      labelText: l10n.vehiclePlateLabel,
                    ),
                    textCapitalization: TextCapitalization.characters,
                    validator: (value) => value == null || value.isEmpty
                        ? l10n.requiredField
                        : null,
                  ),
                ),
                const SizedBox(height: 16),
                Semantics(
                  identifier: 'vehicle_brand_input',
                  label: l10n.vehicleBrandLabel,
                  child: TextFormField(
                    key: const Key('vehicle_brand_input'),
                    controller: _brandController,
                    decoration: InputDecoration(
                      labelText: l10n.vehicleBrandLabel,
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? l10n.requiredField
                        : null,
                  ),
                ),
                const SizedBox(height: 16),
                Semantics(
                  identifier: 'vehicle_model_input',
                  label: l10n.vehicleModelLabel,
                  child: TextFormField(
                    key: const Key('vehicle_model_input'),
                    controller: _modelController,
                    decoration: InputDecoration(
                      labelText: l10n.vehicleModelLabel,
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? l10n.requiredField
                        : null,
                  ),
                ),
                const SizedBox(height: 16),
                Semantics(
                  identifier: 'vehicle_color_input',
                  label: l10n.vehicleColorLabel,
                  child: TextFormField(
                    key: const Key('vehicle_color_input'),
                    controller: _colorController,
                    decoration: InputDecoration(
                      labelText: l10n.vehicleColorLabel,
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? l10n.requiredField
                        : null,
                  ),
                ),
                const SizedBox(height: 16),
                Semantics(
                  identifier: 'vehicle_capacity_input',
                  label: l10n.vehicleCapacityLabel,
                  child: TextFormField(
                    key: const Key('vehicle_capacity_input'),
                    controller: _capacityController,
                    decoration: InputDecoration(
                      labelText: l10n.vehicleCapacityLabel,
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return l10n.requiredField;
                      if (int.tryParse(value) == null || int.parse(value) <= 0)
                        return l10n.invalidValue;
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 24),
                Semantics(
                  identifier: 'submit_vehicle_button',
                  button: true,
                  label: l10n.saveVehicleAction,
                  child: ElevatedButton(
                    key: const Key('submit_vehicle_button'),
                    onPressed: _isLoading ? null : _submit,
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(l10n.saveVehicleAction),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
