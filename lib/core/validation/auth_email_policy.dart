import 'package:flutter/foundation.dart';

const _institutionalDomains = {
  'puccampinas.edu.br',
  'puc-campinas.edu.br',
  'dac.unicamp.br',
};

/// Client-side validation; the backend remains responsible for enforcing access.
/// Example accounts require a debug build and explicit local opt-in.
bool isAllowedAuthEmail(String value) {
  final email = value.trim().toLowerCase();
  final separator = email.indexOf('@');
  if (separator <= 0 || separator != email.lastIndexOf('@')) {
    return false;
  }

  final domain = email.substring(separator + 1);
  const allowLocalTestEmails =
      kDebugMode && bool.fromEnvironment('ALLOW_LOCAL_TEST_EMAILS');

  return _institutionalDomains.contains(domain) ||
      (allowLocalTestEmails && domain == 'example.com');
}
