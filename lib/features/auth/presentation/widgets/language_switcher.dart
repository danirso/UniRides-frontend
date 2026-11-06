import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/locale_provider.dart';

class LanguageSwitcher extends ConsumerWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeStateProvider);

    return Semantics(
      identifier: 'language_switcher_button',
      button: true,
      child: FloatingActionButton.extended(
        key: const Key('language_switcher_button'),
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
      ),
    );
  }
}
