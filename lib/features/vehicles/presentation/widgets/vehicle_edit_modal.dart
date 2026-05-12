import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcc_caronas_frontend/generated/l10n/app_localizations.dart';
import '../../domain/entities/vehicle_entity.dart';
import '../controllers/vehicle_controller.dart';

class VehicleEditModal extends ConsumerStatefulWidget {
  final VehicleEntity vehicle;

  const VehicleEditModal({super.key, required this.vehicle});

  @override
  ConsumerState<VehicleEditModal> createState() => _VehicleEditModalState();
}

class _VehicleEditModalState extends ConsumerState<VehicleEditModal> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _plateController;
  late final TextEditingController _brandController;
  late final TextEditingController _modelController;
  late final TextEditingController _colorController;
  late final TextEditingController _capacityController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _plateController = TextEditingController(text: widget.vehicle.plate);
    _brandController = TextEditingController(text: widget.vehicle.brand);
    _modelController = TextEditingController(text: widget.vehicle.model);
    _colorController = TextEditingController(text: widget.vehicle.color);
    _capacityController = TextEditingController(text: widget.vehicle.capacity.toString());
  }

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

    final success = await ref.read(vehicleControllerProvider.notifier).updateVehicle(
      vehicleId: widget.vehicle.id,
      plate: _plateController.text.trim(),
      brand: _brandController.text.trim(),
      model: _modelController.text.trim(),
      color: _colorController.text.trim(),
      capacity: int.tryParse(_capacityController.text.trim()),
    );

    if (!mounted) return;
    setState(() => _isLoading = false);

    final l10n = AppLocalizations.of(context)!;

    if (success) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.vehicleUpdatedSuccess)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.vehicleUpdatedError)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
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
                  l10n.editVehicleAction,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),
              Semantics(
                label: l10n.vehiclePlateLabel,
                child: TextFormField(
                  key: const Key('edit_vehicle_plate_input'),
                  controller: _plateController,
                  decoration: InputDecoration(labelText: l10n.vehiclePlateLabel),
                  textCapitalization: TextCapitalization.characters,
                  validator: (value) => value == null || value.isEmpty ? l10n.requiredField : null,
                ),
              ),
              const SizedBox(height: 12),
              Semantics(
                label: l10n.vehicleBrandLabel,
                child: TextFormField(
                  key: const Key('edit_vehicle_brand_input'),
                  controller: _brandController,
                  decoration: InputDecoration(labelText: l10n.vehicleBrandLabel),
                  validator: (value) => value == null || value.isEmpty ? l10n.requiredField : null,
                ),
              ),
              const SizedBox(height: 12),
              Semantics(
                label: l10n.vehicleModelLabel,
                child: TextFormField(
                  key: const Key('edit_vehicle_model_input'),
                  controller: _modelController,
                  decoration: InputDecoration(labelText: l10n.vehicleModelLabel),
                  validator: (value) => value == null || value.isEmpty ? l10n.requiredField : null,
                ),
              ),
              const SizedBox(height: 12),
              Semantics(
                label: l10n.vehicleColorLabel,
                child: TextFormField(
                  key: const Key('edit_vehicle_color_input'),
                  controller: _colorController,
                  decoration: InputDecoration(labelText: l10n.vehicleColorLabel),
                  validator: (value) => value == null || value.isEmpty ? l10n.requiredField : null,
                ),
              ),
              const SizedBox(height: 12),
              Semantics(
                label: l10n.vehicleCapacityLabel,
                child: TextFormField(
                  key: const Key('edit_vehicle_capacity_input'),
                  controller: _capacityController,
                  decoration: InputDecoration(labelText: l10n.vehicleCapacityLabel),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) return l10n.requiredField;
                    if (int.tryParse(value) == null || int.parse(value) <= 0) return l10n.invalidValue;
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 24),
              Semantics(
                button: true,
                label: l10n.saveVehicleAction,
                child: ElevatedButton(
                  key: const Key('submit_edit_vehicle_button'),
                  onPressed: _isLoading ? null : _submit,
                  child: _isLoading
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                      : Text(l10n.saveVehicleAction),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}