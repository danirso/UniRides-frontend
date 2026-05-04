import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/login_screen.dart';
import 'generated/l10n/app_localizations.dart';
import 'core/providers/locale_provider.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

// 1. Troque StatelessWidget por ConsumerWidget
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // 2. Adicione o WidgetRef ref aos parâmetros
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeStateProvider);

    return MaterialApp(
      title: 'Unirides',
      theme: AppTheme.lightTheme,
      locale: currentLocale,
      home: const LoginScreen(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}