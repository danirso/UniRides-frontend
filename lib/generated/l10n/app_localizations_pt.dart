// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get loginButton => 'Entrar';

  @override
  String get emailLabel => 'E-mail Institucional';

  @override
  String get passwordLabel => 'Senha';

  @override
  String get nameLabel => 'Nome';

  @override
  String get registerPrompt => 'Ainda não tem uma conta? Cadastre-se';

  @override
  String get errorInvalidCredentials => 'Login ou senha incorretos.';

  @override
  String get errorInvalidEmail => 'Por favor insira um e-mail válido';

  @override
  String get errorShortPassword =>
      'A senha deve conter pelo menos 6 caracteres';

  @override
  String get signUpScreen => 'Criar Conta';

  @override
  String get errorNoName => 'Insira seu nome';

  @override
  String get driverRoleTitle => 'Quero oferecer caronas';

  @override
  String get driverRoleSubtitle =>
      'Marque se você também deseja atuar como motorista';

  @override
  String get registerSuccessMessage => 'Conta criada! Verifique seu e-mail';

  @override
  String get registerButton => 'Cadastrar';
}
