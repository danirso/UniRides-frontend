import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt'),
  ];

  /// Texto do botão principal para realizar o login
  ///
  /// In pt, this message translates to:
  /// **'Entrar'**
  String get loginButton;

  /// Rótulo do campo de entrada para o e-mail acadêmico
  ///
  /// In pt, this message translates to:
  /// **'E-mail Institucional'**
  String get emailLabel;

  /// Rótulo do campo de entrada para a senha
  ///
  /// In pt, this message translates to:
  /// **'Senha'**
  String get passwordLabel;

  /// Rótulo do campo de entrada para o nome completo do usuário
  ///
  /// In pt, this message translates to:
  /// **'Nome'**
  String get nameLabel;

  /// Texto de convite para usuários que ainda não possuem registro
  ///
  /// In pt, this message translates to:
  /// **'Ainda não tem uma conta? Cadastre-se'**
  String get registerPrompt;

  /// Mensagem de erro exibida quando as credenciais não conferem
  ///
  /// In pt, this message translates to:
  /// **'Login ou senha incorretos.'**
  String get errorInvalidCredentials;

  /// Erro de validação para formatos de e-mail incorretos ou domínios não permitidos
  ///
  /// In pt, this message translates to:
  /// **'Por favor insira um e-mail válido'**
  String get errorInvalidEmail;

  /// Aviso de segurança quando a senha inserida é muito curta
  ///
  /// In pt, this message translates to:
  /// **'A senha deve conter pelo menos 6 caracteres'**
  String get errorShortPassword;

  /// Título da tela de cadastro de novos usuários
  ///
  /// In pt, this message translates to:
  /// **'Criar Conta'**
  String get signUpScreen;

  /// Mensagem de erro quando o campo de nome está vazio
  ///
  /// In pt, this message translates to:
  /// **'Insira seu nome'**
  String get errorNoName;

  /// Título da opção para o usuário atuar como motorista
  ///
  /// In pt, this message translates to:
  /// **'Quero oferecer caronas'**
  String get driverRoleTitle;

  /// Subtítulo explicativo sobre a função de motorista
  ///
  /// In pt, this message translates to:
  /// **'Marque se você também deseja atuar como motorista'**
  String get driverRoleSubtitle;

  /// Mensagem de sucesso exibida após o registro concluído
  ///
  /// In pt, this message translates to:
  /// **'Conta criada! Verifique seu e-mail'**
  String get registerSuccessMessage;

  /// Texto do botão de submissão do formulário de cadastro
  ///
  /// In pt, this message translates to:
  /// **'Cadastrar'**
  String get registerButton;

  /// Mensagem de erro quando o email do usuario não foi verificado
  ///
  /// In pt, this message translates to:
  /// **'Sua conta ainda não foi ativada. Verifique seu e-mail.'**
  String get errorEmailNotVerified;

  /// Mensagem de erro quando se tenta cadastrar um email ja cadastrado
  ///
  /// In pt, this message translates to:
  /// **'Este e-mail já está cadastrado.'**
  String get errorEmailAlreadyRegistered;

  /// Erro de server (http 500)
  ///
  /// In pt, this message translates to:
  /// **'Erro de conexão com o servidor. Tente novamente mais tarde.'**
  String get errorServer;

  /// Erro generico
  ///
  /// In pt, this message translates to:
  /// **'Ocorreu um erro inesperado.'**
  String get errorGeneric;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
