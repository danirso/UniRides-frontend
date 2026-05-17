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

  /// Rótulo da aba de busca de caronas na barra de navegação principal.
  ///
  /// In pt, this message translates to:
  /// **'Buscar'**
  String get navSearchLabel;

  /// Rótulo da aba de histórico e gerenciamento de caronas.
  ///
  /// In pt, this message translates to:
  /// **'Minhas Caronas'**
  String get navRidesLabel;

  /// Rótulo da aba destinada ao motorista para criação de ofertas de carona.
  ///
  /// In pt, this message translates to:
  /// **'Oferecer'**
  String get navOfferLabel;

  /// Rótulo da aba de perfil do usuário e configurações.
  ///
  /// In pt, this message translates to:
  /// **'Perfil'**
  String get navProfileLabel;

  /// Mensagem exibida quando ocorre falha na requisição dos dados do usuário logado.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao carregar perfil'**
  String get errorProfileLoad;

  /// Texto descritivo lido por leitores de tela durante o estado de carregamento da tela principal.
  ///
  /// In pt, this message translates to:
  /// **'Carregando perfil do usuário'**
  String get semanticLoadingProfile;

  /// Descrição para leitores de tela indicando a área de conteúdo ativo exibido no momento.
  ///
  /// In pt, this message translates to:
  /// **'Conteúdo principal'**
  String get semanticMainContent;

  /// Título do diálogo quando o motorista tenta oferecer carona sem veículos.
  ///
  /// In pt, this message translates to:
  /// **'Veículo Necessário'**
  String get noVehicleTitle;

  /// Mensagem explicativa do diálogo de veículo necessário.
  ///
  /// In pt, this message translates to:
  /// **'Para oferecer caronas, você precisa cadastrar pelo menos um veículo.'**
  String get noVehicleMessage;

  /// Botão para redirecionar ao cadastro de veículo.
  ///
  /// In pt, this message translates to:
  /// **'Cadastrar Agora'**
  String get registerVehicleAction;

  /// Texto padrão para botões de cancelar.
  ///
  /// In pt, this message translates to:
  /// **'Cancelar'**
  String get cancel;

  /// Título do modal de cadastro de veículos.
  ///
  /// In pt, this message translates to:
  /// **'Cadastrar Veículo'**
  String get registerVehicleTitle;

  /// Rótulo do campo de placa do veículo.
  ///
  /// In pt, this message translates to:
  /// **'Placa'**
  String get vehiclePlateLabel;

  /// Rótulo do campo de marca do veículo.
  ///
  /// In pt, this message translates to:
  /// **'Marca (Ex: Hyundai, Chevrolet)'**
  String get vehicleBrandLabel;

  /// Rótulo do campo de modelo do veículo.
  ///
  /// In pt, this message translates to:
  /// **'Modelo (Ex: HB20)'**
  String get vehicleModelLabel;

  /// Rótulo do campo de cor do veículo.
  ///
  /// In pt, this message translates to:
  /// **'Cor'**
  String get vehicleColorLabel;

  /// Rótulo do campo de capacidade do veículo.
  ///
  /// In pt, this message translates to:
  /// **'Capacidade de Passageiros'**
  String get vehicleCapacityLabel;

  /// Botão de submissão do formulário de veículos.
  ///
  /// In pt, this message translates to:
  /// **'Salvar Veículo'**
  String get saveVehicleAction;

  /// Mensagem de sucesso ao cadastrar veículo.
  ///
  /// In pt, this message translates to:
  /// **'Veículo cadastrado com sucesso!'**
  String get vehicleRegisteredSuccess;

  /// Mensagem de erro ao falhar o cadastro do veículo.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao cadastrar veículo. Verifique os dados e tente novamente.'**
  String get vehicleRegisteredError;

  /// Mensagem de erro genérica para campos obrigatórios vazios.
  ///
  /// In pt, this message translates to:
  /// **'Campo obrigatório'**
  String get requiredField;

  /// Mensagem de erro para valores numéricos incorretos.
  ///
  /// In pt, this message translates to:
  /// **'Insira um valor válido'**
  String get invalidValue;

  /// Título da tela de listagem de veículos.
  ///
  /// In pt, this message translates to:
  /// **'Meus Veículos'**
  String get myVehiclesTitle;

  /// Tooltip/label do botão de editar veículo.
  ///
  /// In pt, this message translates to:
  /// **'Editar veículo'**
  String get editVehicleAction;

  /// Tooltip/label do botão de excluir veículo.
  ///
  /// In pt, this message translates to:
  /// **'Excluir veículo'**
  String get deleteVehicleAction;

  /// Capacidade de passageiros do veículo.
  ///
  /// In pt, this message translates to:
  /// **'{count} passageiros'**
  String vehiclePassengersLabel(int count);

  /// Título do dialog de confirmação de exclusão.
  ///
  /// In pt, this message translates to:
  /// **'Excluir veículo?'**
  String get deleteVehicleConfirmTitle;

  /// Mensagem do dialog de confirmação de exclusão.
  ///
  /// In pt, this message translates to:
  /// **'Tem certeza que deseja excluir o veículo {plate}? Esta ação não pode ser desfeita.'**
  String deleteVehicleConfirmMessage(String plate);

  /// Botão de confirmação genérico.
  ///
  /// In pt, this message translates to:
  /// **'Confirmar'**
  String get confirmAction;

  /// Mensagem de sucesso ao excluir veículo.
  ///
  /// In pt, this message translates to:
  /// **'Veículo excluído com sucesso!'**
  String get vehicleDeletedSuccess;

  /// Mensagem de erro ao excluir veículo.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao excluir veículo. Tente novamente.'**
  String get vehicleDeletedError;

  /// Mensagem de sucesso ao atualizar veículo.
  ///
  /// In pt, this message translates to:
  /// **'Veículo atualizado com sucesso!'**
  String get vehicleUpdatedSuccess;

  /// Mensagem de erro ao atualizar veículo.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao atualizar veículo. Verifique os dados e tente novamente.'**
  String get vehicleUpdatedError;

  /// Mensagem quando o motorista não tem veículos cadastrados.
  ///
  /// In pt, this message translates to:
  /// **'Nenhum veículo cadastrado.'**
  String get noVehiclesRegistered;

  /// Título da tela de oferta de carona.
  ///
  /// In pt, this message translates to:
  /// **'Oferecer Carona'**
  String get offerRideTitle;

  /// Label do campo de origem.
  ///
  /// In pt, this message translates to:
  /// **'Origem'**
  String get originLabel;

  /// Label do campo de destino.
  ///
  /// In pt, this message translates to:
  /// **'Destino'**
  String get destinationLabel;

  /// Label do campo de data/hora.
  ///
  /// In pt, this message translates to:
  /// **'Data e Hora de Partida'**
  String get departureDateLabel;

  /// Label do campo de vagas.
  ///
  /// In pt, this message translates to:
  /// **'Vagas disponíveis'**
  String get availableSeatsLabel;

  /// Label do slider de desvio.
  ///
  /// In pt, this message translates to:
  /// **'Desvio máximo aceito'**
  String get maxDetourLabel;

  /// Valor do slider de desvio.
  ///
  /// In pt, this message translates to:
  /// **'{km} km'**
  String maxDetourValue(int km);

  /// Label do dropdown de veículo.
  ///
  /// In pt, this message translates to:
  /// **'Veículo'**
  String get selectVehicleLabel;

  /// Botão de submissão da oferta de carona.
  ///
  /// In pt, this message translates to:
  /// **'Publicar Carona'**
  String get offerRideAction;

  /// Mensagem de sucesso ao criar carona.
  ///
  /// In pt, this message translates to:
  /// **'Carona publicada com sucesso!'**
  String get rideCreatedSuccess;

  /// Mensagem de erro ao criar carona.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao publicar carona. Verifique os dados e tente novamente.'**
  String get rideCreatedError;

  /// Validação de origem não selecionada.
  ///
  /// In pt, this message translates to:
  /// **'Selecione a origem antes de continuar.'**
  String get selectOriginFirst;

  /// Validação de destino não selecionado.
  ///
  /// In pt, this message translates to:
  /// **'Selecione o destino antes de continuar.'**
  String get selectDestinationFirst;

  /// Validação de veículo não selecionado.
  ///
  /// In pt, this message translates to:
  /// **'Selecione um veículo antes de continuar.'**
  String get selectVehicleFirst;

  /// Validação de data/hora não selecionada.
  ///
  /// In pt, this message translates to:
  /// **'Selecione a data e hora de partida.'**
  String get selectDepartureFirst;

  /// No description provided for @myRidesTitle.
  ///
  /// In pt, this message translates to:
  /// **'Minhas Viagens'**
  String get myRidesTitle;

  /// No description provided for @ridesAsDriverTab.
  ///
  /// In pt, this message translates to:
  /// **'Caronas que ofereço'**
  String get ridesAsDriverTab;

  /// No description provided for @ridesAsPassengerTab.
  ///
  /// In pt, this message translates to:
  /// **'Minhas solicitações'**
  String get ridesAsPassengerTab;

  /// No description provided for @rideStatusScheduled.
  ///
  /// In pt, this message translates to:
  /// **'Agendada'**
  String get rideStatusScheduled;

  /// No description provided for @rideStatusInProgress.
  ///
  /// In pt, this message translates to:
  /// **'Em andamento'**
  String get rideStatusInProgress;

  /// No description provided for @rideStatusCompleted.
  ///
  /// In pt, this message translates to:
  /// **'Concluída'**
  String get rideStatusCompleted;

  /// No description provided for @rideStatusCanceled.
  ///
  /// In pt, this message translates to:
  /// **'Cancelada'**
  String get rideStatusCanceled;

  /// No description provided for @rideStatusPending.
  ///
  /// In pt, this message translates to:
  /// **'Pendente'**
  String get rideStatusPending;

  /// No description provided for @rideStatusAccepted.
  ///
  /// In pt, this message translates to:
  /// **'Aceita'**
  String get rideStatusAccepted;

  /// No description provided for @rideStatusRejected.
  ///
  /// In pt, this message translates to:
  /// **'Rejeitada'**
  String get rideStatusRejected;

  /// No description provided for @startRideAction.
  ///
  /// In pt, this message translates to:
  /// **'Iniciar carona'**
  String get startRideAction;

  /// No description provided for @completeRideAction.
  ///
  /// In pt, this message translates to:
  /// **'Finalizar carona'**
  String get completeRideAction;

  /// No description provided for @cancelRideAction.
  ///
  /// In pt, this message translates to:
  /// **'Cancelar carona'**
  String get cancelRideAction;

  /// No description provided for @editRideAction.
  ///
  /// In pt, this message translates to:
  /// **'Editar carona'**
  String get editRideAction;

  /// No description provided for @viewRequestsAction.
  ///
  /// In pt, this message translates to:
  /// **'Ver solicitações'**
  String get viewRequestsAction;

  /// No description provided for @rideRequestsTitle.
  ///
  /// In pt, this message translates to:
  /// **'Solicitações da carona'**
  String get rideRequestsTitle;

  /// No description provided for @acceptRequestAction.
  ///
  /// In pt, this message translates to:
  /// **'Aceitar'**
  String get acceptRequestAction;

  /// No description provided for @rejectRequestAction.
  ///
  /// In pt, this message translates to:
  /// **'Rejeitar'**
  String get rejectRequestAction;

  /// No description provided for @cancelRequestAction.
  ///
  /// In pt, this message translates to:
  /// **'Cancelar solicitação'**
  String get cancelRequestAction;

  /// No description provided for @noRidesAsDriver.
  ///
  /// In pt, this message translates to:
  /// **'Você não ofereceu nenhuma carona ainda.'**
  String get noRidesAsDriver;

  /// No description provided for @noRidesAsPassenger.
  ///
  /// In pt, this message translates to:
  /// **'Você não fez nenhuma solicitação ainda.'**
  String get noRidesAsPassenger;

  /// No description provided for @noRequests.
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma solicitação para esta carona.'**
  String get noRequests;

  /// No description provided for @rideUpdatedSuccess.
  ///
  /// In pt, this message translates to:
  /// **'Carona atualizada com sucesso!'**
  String get rideUpdatedSuccess;

  /// No description provided for @rideUpdatedError.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao atualizar carona. Tente novamente.'**
  String get rideUpdatedError;

  /// No description provided for @rideStartedSuccess.
  ///
  /// In pt, this message translates to:
  /// **'Carona iniciada!'**
  String get rideStartedSuccess;

  /// No description provided for @rideStartedError.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao iniciar carona.'**
  String get rideStartedError;

  /// No description provided for @rideCompletedSuccess.
  ///
  /// In pt, this message translates to:
  /// **'Carona finalizada!'**
  String get rideCompletedSuccess;

  /// No description provided for @rideCompletedError.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao finalizar carona.'**
  String get rideCompletedError;

  /// No description provided for @rideCanceledSuccess.
  ///
  /// In pt, this message translates to:
  /// **'Carona cancelada.'**
  String get rideCanceledSuccess;

  /// No description provided for @rideCanceledError.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao cancelar carona.'**
  String get rideCanceledError;

  /// No description provided for @requestAcceptedSuccess.
  ///
  /// In pt, this message translates to:
  /// **'Passageiro aceito!'**
  String get requestAcceptedSuccess;

  /// No description provided for @requestAcceptedError.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao aceitar solicitação.'**
  String get requestAcceptedError;

  /// No description provided for @requestRejectedSuccess.
  ///
  /// In pt, this message translates to:
  /// **'Solicitação rejeitada.'**
  String get requestRejectedSuccess;

  /// No description provided for @requestRejectedError.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao rejeitar solicitação.'**
  String get requestRejectedError;

  /// No description provided for @requestCanceledSuccess.
  ///
  /// In pt, this message translates to:
  /// **'Solicitação cancelada.'**
  String get requestCanceledSuccess;

  /// No description provided for @requestCanceledError.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao cancelar solicitação.'**
  String get requestCanceledError;

  /// No description provided for @confirmCancelRideTitle.
  ///
  /// In pt, this message translates to:
  /// **'Cancelar carona?'**
  String get confirmCancelRideTitle;

  /// No description provided for @confirmCancelRideMessage.
  ///
  /// In pt, this message translates to:
  /// **'Tem certeza que deseja cancelar esta carona? Esta ação não pode ser desfeita.'**
  String get confirmCancelRideMessage;

  /// No description provided for @confirmCompleteRideTitle.
  ///
  /// In pt, this message translates to:
  /// **'Finalizar carona?'**
  String get confirmCompleteRideTitle;

  /// No description provided for @confirmCompleteRideMessage.
  ///
  /// In pt, this message translates to:
  /// **'Confirma que a carona foi concluída?'**
  String get confirmCompleteRideMessage;

  /// No description provided for @confirmCancelRequestTitle.
  ///
  /// In pt, this message translates to:
  /// **'Cancelar solicitação?'**
  String get confirmCancelRequestTitle;

  /// No description provided for @confirmCancelRequestMessage.
  ///
  /// In pt, this message translates to:
  /// **'Tem certeza que deseja cancelar sua solicitação para esta carona?'**
  String get confirmCancelRequestMessage;
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
