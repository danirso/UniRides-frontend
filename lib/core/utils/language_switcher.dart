import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/locale_provider.dart';

class LanguageSwitcher extends ConsumerWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeStateProvider);

    return FloatingActionButton.extended(
      heroTag: 'language_switcher',
      onPressed: () {
        final notifier = ref.read(localeStateProvider.notifier);
        
        if (currentLocale.languageCode == 'pt') {
          notifier.setLocale(const Locale('en', 'US'));
        } else {
          notifier.setLocale(const Locale('pt', 'BR'));
        }
      },
      icon: const Icon(Icons.language),
      label: Text(currentLocale.languageCode.toUpperCase()),
    );
  }
}