import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../auth/presentation/controllers/auth_controller.dart';
import '../../auth/presentation/screens/login_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UniRides - Início'),
        actions: [
          Semantics(
            identifier: 'logout_button',
            button: true,
            child: IconButton(
              key: const Key('logout_button_key'),
              icon: const Icon(Icons.logout),
              onPressed: () async {
                await ref.read(authControllerProvider.notifier).logout();
                if (context.mounted) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (route) => false,
                  );
                }
              },
            ),
          ),
        ],
      ),
      body:  Center(
        child: Semantics(
          label: 'Mensagem de boas-vindas',
          child: Text(
            'Bem-vindo às Caronas!',
            key: Key('welcome_text_key'),
          ),
        ),
      ),
    );
  }
}