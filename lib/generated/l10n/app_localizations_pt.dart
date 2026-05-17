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

  @override
  String get errorEmailNotVerified =>
      'Sua conta ainda não foi ativada. Verifique seu e-mail.';

  @override
  String get errorEmailAlreadyRegistered => 'Este e-mail já está cadastrado.';

  @override
  String get errorServer =>
      'Erro de conexão com o servidor. Tente novamente mais tarde.';

  @override
  String get errorGeneric => 'Ocorreu um erro inesperado.';

  @override
  String get navSearchLabel => 'Buscar';

  @override
  String get navRidesLabel => 'Minhas Caronas';

  @override
  String get navOfferLabel => 'Oferecer';

  @override
  String get navProfileLabel => 'Perfil';

  @override
  String get errorProfileLoad => 'Erro ao carregar perfil';

  @override
  String get semanticLoadingProfile => 'Carregando perfil do usuário';

  @override
  String get semanticMainContent => 'Conteúdo principal';

  @override
  String get noVehicleTitle => 'Veículo Necessário';

  @override
  String get noVehicleMessage =>
      'Para oferecer caronas, você precisa cadastrar pelo menos um veículo.';

  @override
  String get registerVehicleAction => 'Cadastrar Agora';

  @override
  String get cancel => 'Cancelar';

  @override
  String get registerVehicleTitle => 'Cadastrar Veículo';

  @override
  String get vehiclePlateLabel => 'Placa';

  @override
  String get vehicleBrandLabel => 'Marca (Ex: Hyundai, Chevrolet)';

  @override
  String get vehicleModelLabel => 'Modelo (Ex: HB20)';

  @override
  String get vehicleColorLabel => 'Cor';

  @override
  String get vehicleCapacityLabel => 'Capacidade de Passageiros';

  @override
  String get saveVehicleAction => 'Salvar Veículo';

  @override
  String get vehicleRegisteredSuccess => 'Veículo cadastrado com sucesso!';

  @override
  String get vehicleRegisteredError =>
      'Erro ao cadastrar veículo. Verifique os dados e tente novamente.';

  @override
  String get requiredField => 'Campo obrigatório';

  @override
  String get invalidValue => 'Insira um valor válido';

  @override
  String get myVehiclesTitle => 'Meus Veículos';

  @override
  String get editVehicleAction => 'Editar veículo';

  @override
  String get deleteVehicleAction => 'Excluir veículo';

  @override
  String vehiclePassengersLabel(int count) {
    return '$count passageiros';
  }

  @override
  String get deleteVehicleConfirmTitle => 'Excluir veículo?';

  @override
  String deleteVehicleConfirmMessage(String plate) {
    return 'Tem certeza que deseja excluir o veículo $plate? Esta ação não pode ser desfeita.';
  }

  @override
  String get confirmAction => 'Confirmar';

  @override
  String get vehicleDeletedSuccess => 'Veículo excluído com sucesso!';

  @override
  String get vehicleDeletedError => 'Erro ao excluir veículo. Tente novamente.';

  @override
  String get vehicleUpdatedSuccess => 'Veículo atualizado com sucesso!';

  @override
  String get vehicleUpdatedError =>
      'Erro ao atualizar veículo. Verifique os dados e tente novamente.';

  @override
  String get noVehiclesRegistered => 'Nenhum veículo cadastrado.';

  @override
  String get offerRideTitle => 'Oferecer Carona';

  @override
  String get originLabel => 'Origem';

  @override
  String get destinationLabel => 'Destino';

  @override
  String get departureDateLabel => 'Data e Hora de Partida';

  @override
  String get availableSeatsLabel => 'Vagas disponíveis';

  @override
  String get maxDetourLabel => 'Desvio máximo aceito';

  @override
  String maxDetourValue(int km) {
    return '$km km';
  }

  @override
  String get selectVehicleLabel => 'Veículo';

  @override
  String get offerRideAction => 'Publicar Carona';

  @override
  String get rideCreatedSuccess => 'Carona publicada com sucesso!';

  @override
  String get rideCreatedError =>
      'Erro ao publicar carona. Verifique os dados e tente novamente.';

  @override
  String get selectOriginFirst => 'Selecione a origem antes de continuar.';

  @override
  String get selectDestinationFirst =>
      'Selecione o destino antes de continuar.';

  @override
  String get selectVehicleFirst => 'Selecione um veículo antes de continuar.';

  @override
  String get selectDepartureFirst => 'Selecione a data e hora de partida.';
}
