import 'dart:ui';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'locale_provider.g.dart';

@riverpod
class LocaleState extends _$LocaleState {
  @override
  Locale build() {
    return const Locale('pt', 'BR');
  }

  void setLocale(Locale locale) {
    state = locale;
  }
}