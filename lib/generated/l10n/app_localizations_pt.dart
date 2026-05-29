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

  @override
  String get myRidesTitle => 'Minhas Viagens';

  @override
  String get ridesAsDriverTab => 'Caronas que ofereço';

  @override
  String get ridesAsPassengerTab => 'Minhas solicitações';

  @override
  String get rideStatusScheduled => 'Agendada';

  @override
  String get rideStatusInProgress => 'Em andamento';

  @override
  String get rideStatusCompleted => 'Concluída';

  @override
  String get rideStatusCanceled => 'Cancelada';

  @override
  String get rideStatusPending => 'Pendente';

  @override
  String get rideStatusAccepted => 'Aceita';

  @override
  String get rideStatusRejected => 'Rejeitada';

  @override
  String get startRideAction => 'Iniciar';

  @override
  String get completeRideAction => 'Finalizar carona';

  @override
  String get cancelRideAction => 'Cancelar carona';

  @override
  String get editRideAction => 'Editar carona';

  @override
  String get viewRequestsAction => 'Solicitações';

  @override
  String get rideRequestsTitle => 'Solicitações da carona';

  @override
  String get acceptRequestAction => 'Aceitar';

  @override
  String get rejectRequestAction => 'Rejeitar';

  @override
  String get cancelRequestAction => 'Cancelar solicitação';

  @override
  String get noRidesAsDriver => 'Você não ofereceu nenhuma carona ainda.';

  @override
  String get noRidesAsPassenger => 'Você não fez nenhuma solicitação ainda.';

  @override
  String get noRequests => 'Nenhuma solicitação para esta carona.';

  @override
  String get rideUpdatedSuccess => 'Carona atualizada com sucesso!';

  @override
  String get rideUpdatedError => 'Erro ao atualizar carona. Tente novamente.';

  @override
  String get rideStartedSuccess => 'Carona iniciada!';

  @override
  String get rideStartedError => 'Erro ao iniciar carona.';

  @override
  String get rideCompletedSuccess => 'Carona finalizada!';

  @override
  String get rideCompletedError => 'Erro ao finalizar carona.';

  @override
  String get rideCanceledSuccess => 'Carona cancelada.';

  @override
  String get rideCanceledError => 'Erro ao cancelar carona.';

  @override
  String get requestAcceptedSuccess => 'Passageiro aceito!';

  @override
  String get requestAcceptedError => 'Erro ao aceitar solicitação.';

  @override
  String get requestRejectedSuccess => 'Solicitação rejeitada.';

  @override
  String get requestRejectedError => 'Erro ao rejeitar solicitação.';

  @override
  String get requestCanceledSuccess => 'Solicitação cancelada.';

  @override
  String get requestCanceledError => 'Erro ao cancelar solicitação.';

  @override
  String get confirmCancelRideTitle => 'Cancelar carona?';

  @override
  String get confirmCancelRideMessage =>
      'Tem certeza que deseja cancelar esta carona? Esta ação não pode ser desfeita.';

  @override
  String get confirmCompleteRideTitle => 'Finalizar carona?';

  @override
  String get confirmCompleteRideMessage =>
      'Confirma que a carona foi concluída?';

  @override
  String get confirmCancelRequestTitle => 'Cancelar solicitação?';

  @override
  String get confirmCancelRequestMessage =>
      'Tem certeza que deseja cancelar sua solicitação para esta carona?';

  @override
  String get confirmStartRideTitle => 'Iniciar carona?';

  @override
  String get confirmStartRideMessage =>
      'Deseja mesmo iniciar esta carona agora?';

  @override
  String get maxDetourInfoLabel => 'Informação sobre raio de desvio';

  @override
  String get maxDetourInfoMessage =>
      'Distância máxima que você aceita desviar do seu trajeto para buscar ou deixar um passageiro. Quanto maior o valor, mais caronas compatíveis aparecerão para os passageiros.';

  @override
  String get searchRidesTitle => 'Explorar Caronas';

  @override
  String get searchRidesAction => 'Buscar';

  @override
  String get noRidesFound => 'Nenhuma carona encontrada para este trajeto.';

  @override
  String get driverLabel => 'Motorista';

  @override
  String get estimatedTimeLabel => 'Tempo estimado';

  @override
  String get distanceLabel => 'Distância';

  @override
  String minutesLabel(int mins) {
    return '$mins min';
  }

  @override
  String kilometersLabel(String km) {
    return '$km km';
  }

  @override
  String get requestSeatAction => 'Solicitar vaga';

  @override
  String get rideRequestedSuccess => 'Solicitação enviada com sucesso!';

  @override
  String get rideRequestedError => 'Erro ao solicitar vaga. Tente novamente.';

  @override
  String get searchingRides => 'Buscando caronas...';

  @override
  String get rideDetailsTitle => 'Detalhes da Carona';

  @override
  String get viewDetailsAction => 'Ver detalhes';

  @override
  String get editProfileTitle => 'Editar Perfil';

  @override
  String get editProfileAction => 'Editar Perfil';

  @override
  String get deleteProfileTitle => 'Excluir Perfil';

  @override
  String get deleteProfileConfirmMessage =>
      'Tem certeza que deseja excluir sua conta? Esta ação não pode ser desfeita.';

  @override
  String get profileUpdatedSuccess => 'Perfil atualizado com sucesso!';

  @override
  String get profileUpdatedError =>
      'Erro ao atualizar perfil. Tente novamente.';

  @override
  String get profileDeletedError => 'Erro ao excluir perfil. Tente novamente.';

  @override
  String get newPasswordLabel => 'Nova senha (opcional)';

  @override
  String get canDriveLabel => 'Sou motorista';

  @override
  String get languageLabel => 'Idioma';

  @override
  String get myProfileTitle => 'Meu Perfil';

  @override
  String get logoutTitle => 'Sair';

  @override
  String get saveProfileAction => 'Salvar Perfil';
}
