import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/auth_controller.dart';
import '../../../rides/presentation/home_screen.dart';
import 'register_screen.dart';
import 'package:tcc_caronas_frontend/generated/l10n/app_localizations.dart';
import '../widgets/language_switcher.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;

  Future<void> _handleLogin() async {
  if (!_formKey.currentState!.validate()) return;

  final success = await ref.read(authControllerProvider.notifier).login(
    _emailController.text,
    _passwordController.text,
  );

  if (success && mounted) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }
}

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    final authState = ref.watch(authControllerProvider);
    final isLoading = authState.isLoading;

    ref.listen<AsyncValue<void>>(
      authControllerProvider,
      (_, state) {
        state.whenOrNull(
          error: (error, _) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(error.toString().replaceAll('Exception: ', ''))),
            );
          },
        );
      },
    );

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'UniRides',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineLarge?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                    ),
                  ),
                  const SizedBox(height: 48),
                  Semantics(
                    identifier: 'login_email_input',
                    child: TextFormField(
                      key: const Key('email_input_key'),
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.emailLabel,
                        prefixIcon: const Icon(Icons.email_outlined),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty || !value.contains('@')) {
                          return AppLocalizations.of(context)!.errorInvalidEmail; 
                        }

                        final email = value.trim().toLowerCase();
                        final isPuc = email.endsWith('@puccampinas.edu.br');
                        final isUnicamp = email.endsWith('@dac.unicamp.br');

                        if (!isPuc && !isUnicamp){
                          return AppLocalizations.of(context)!.errorInvalidEmail;
                        }

                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Semantics(
                    identifier: 'password_input',
                    child:TextFormField(
                        key: const Key('password_input_key'),
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.passwordLabel,
                          prefixIcon: Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty || value.length < 6) {
                            return AppLocalizations.of(context)!.errorShortPassword;
                          }
                          return null;
                        },
                      ),
                    ),
                  const SizedBox(height: 32),
                  Semantics(
                    identifier: 'login_submit_button',
                    button: true,
                    child: ElevatedButton(
                      key: const Key('login_submit_key'),
                      onPressed: isLoading ? null : _handleLogin,
                      child: isLoading
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(AppLocalizations.of(context)!.loginButton),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Semantics(
                    identifier: 'login_to_register_button',
                    button: true,
                    child: TextButton(
                      key: const Key('login_register_key'),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.registerPrompt,
                        style: TextStyle(color: theme.colorScheme.primary),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: const LanguageSwitcher(),
    );
  }
}