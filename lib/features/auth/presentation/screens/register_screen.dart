import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/auth_controller.dart';
import 'package:tcc_caronas_frontend/generated/l10n/app_localizations.dart';
import '../widgets/language_switcher.dart';
import '../../domain/errors/auth_failures.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _canDrive = false;
  bool _isPasswordVisible = false;

  String _getErrorMessage(BuildContext context, Object error) {
    final l10n = AppLocalizations.of(context)!;

    if (error is EmailAlreadyRegisteredFailure)
      return l10n.errorEmailAlreadyRegistered;
    if (error is ServerFailure) return l10n.errorServer;

    return l10n.errorGeneric;
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await ref
        .read(authControllerProvider.notifier)
        .register(
          _nameController.text,
          _emailController.text,
          _passwordController.text,
          _canDrive,
        );

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.registerSuccessMessage),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authState = ref.watch(authControllerProvider);
    final isLoading = authState.isLoading;

    ref.listen<AsyncValue<void>>(authControllerProvider, (_, state) {
      state.whenOrNull(
        error: (error, _) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(_getErrorMessage(context, error)),
              backgroundColor: theme.colorScheme.error,
            ),
          );
        },
      );
    });

    return Semantics(
      identifier: 'screen_register',
      container: true,
      child: Scaffold(
        appBar: AppBar(title: Text(AppLocalizations.of(context)!.signUpScreen)),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Semantics(
                    identifier: 'name_input',
                    child: TextFormField(
                      key: const Key('name_input_key'),
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.nameLabel,
                        prefixIcon: const Icon(Icons.person_outline),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.errorNoName;
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Semantics(
                    identifier: 'email_input',
                    child: TextFormField(
                      key: const Key('email_input_key'),
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.emailLabel,
                        prefixIcon: const Icon(Icons.email_outlined),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !value.contains('@')) {
                          return AppLocalizations.of(
                            context,
                          )!.errorInvalidEmail;
                        }
                        final email = value.trim().toLowerCase();
                        final isPuc = email.endsWith('@puccampinas.edu.br');
                        final isUnicamp = email.endsWith('@dac.unicamp.br');

                        if (!isPuc && !isUnicamp) {
                          return AppLocalizations.of(
                            context,
                          )!.errorInvalidEmail;
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Semantics(
                    identifier: 'password_input',
                    child: TextFormField(
                      key: const Key('password_input_key'),
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.passwordLabel,
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: Semantics(
                          identifier: 'register_password_visibility_button',
                          button: true,
                          child: IconButton(
                            key: const Key(
                              'register_password_visibility_button',
                            ),
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 6) {
                          return AppLocalizations.of(
                            context,
                          )!.errorShortPassword;
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Semantics(
                    identifier: 'register_can_drive_switch',
                    child: SwitchListTile(
                      key: const Key('register_can_drive_key'),
                      title: Text(
                        AppLocalizations.of(context)!.driverRoleTitle,
                      ),
                      subtitle: Text(
                        AppLocalizations.of(context)!.driverRoleSubtitle,
                      ),
                      value: _canDrive,
                      onChanged: isLoading
                          ? null
                          : (bool value) {
                              setState(() {
                                _canDrive = value;
                              });
                            },
                    ),
                  ),
                  const SizedBox(height: 32),
                  Semantics(
                    identifier: 'register_submit_button',
                    button: true,
                    child: ElevatedButton(
                      key: const Key('register_submit_key'),
                      onPressed: isLoading ? null : _handleRegister,
                      child: isLoading
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(AppLocalizations.of(context)!.registerButton),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: const LanguageSwitcher(),
      ),
    );
  }
}
