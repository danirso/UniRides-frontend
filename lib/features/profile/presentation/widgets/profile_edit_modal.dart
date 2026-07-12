import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcc_caronas_frontend/generated/l10n/app_localizations.dart';
import '../../../auth/presentation/controllers/user_controller.dart';
import '../../../auth/domain/entities/user_entity.dart';

class ProfileEditModal extends ConsumerStatefulWidget {
  final UserEntity user;

  const ProfileEditModal({super.key, required this.user});

  @override
  ConsumerState<ProfileEditModal> createState() => _ProfileEditModalState();
}

class _ProfileEditModalState extends ConsumerState<ProfileEditModal> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late bool _canDrive;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
    _passwordController = TextEditingController();
    _canDrive = widget.user.canDrive;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _isLoading = true);

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    final success = await ref
        .read(userControllerProvider.notifier)
        .updateMe(
          name: name != widget.user.name ? name : null,
          email: email != widget.user.email ? email : null,
          password: password.isNotEmpty ? password : null,
          canDrive: _canDrive != widget.user.canDrive ? _canDrive : null,
        );

    if (!mounted) return;
    setState(() => _isLoading = false);

    final l10n = AppLocalizations.of(context)!;
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success ? l10n.profileUpdatedSuccess : l10n.profileUpdatedError,
        ),
      ),
    );
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
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Semantics(
              header: true,
              child: Text(
                l10n.editProfileTitle,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            Semantics(
              label: l10n.nameLabel,
              child: TextFormField(
                key: const Key('edit_profile_name_input'),
                controller: _nameController,
                decoration: InputDecoration(labelText: l10n.nameLabel),
              ),
            ),
            const SizedBox(height: 12),
            Semantics(
              label: l10n.emailLabel,
              child: TextFormField(
                key: const Key('edit_profile_email_input'),
                controller: _emailController,
                decoration: InputDecoration(labelText: l10n.emailLabel),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            const SizedBox(height: 12),
            Semantics(
              label: l10n.newPasswordLabel,
              child: TextFormField(
                key: const Key('edit_profile_password_input'),
                controller: _passwordController,
                decoration: InputDecoration(labelText: l10n.newPasswordLabel),
                obscureText: true,
              ),
            ),
            const SizedBox(height: 12),
            Semantics(
              label: l10n.canDriveLabel,
              child: SwitchListTile(
                key: const Key('edit_profile_can_drive_switch'),
                title: Text(l10n.canDriveLabel),
                value: _canDrive,
                onChanged: (v) => setState(() => _canDrive = v),
                contentPadding: EdgeInsets.zero,
              ),
            ),
            const SizedBox(height: 24),
            Semantics(
              button: true,
              label: l10n.saveProfileAction,
              child: ElevatedButton(
                key: const Key('edit_profile_submit_button'),
                onPressed: _isLoading ? null : _submit,
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(l10n.saveProfileAction),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
