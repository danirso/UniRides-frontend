// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get loginButton => 'Login';

  @override
  String get emailLabel => 'Institutional Email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get nameLabel => 'Name';

  @override
  String get registerPrompt => 'Don\'t have an account? Sign up';

  @override
  String get errorInvalidCredentials => 'Invalid username or password.';

  @override
  String get errorInvalidEmail => 'Please enter a valid email';

  @override
  String get errorShortPassword =>
      'Password should be at least 6 characters long';

  @override
  String get signUpScreen => 'Sign Up';

  @override
  String get errorNoName => 'Please enter your name';

  @override
  String get driverRoleTitle => 'I want to offer rides';

  @override
  String get driverRoleSubtitle => 'Check if you also want to act as a driver';

  @override
  String get registerSuccessMessage =>
      'Account created! Please check your email';

  @override
  String get registerButton => 'Sign Up';

  @override
  String get errorEmailNotVerified =>
      'Account not activated. Please check your email.';

  @override
  String get errorEmailAlreadyRegistered => 'This email is already registered.';

  @override
  String get errorServer => 'Server connection error. Please try again later.';

  @override
  String get errorGeneric => 'An unexpected error occurred.';

  @override
  String get navSearchLabel => 'Search';

  @override
  String get navRidesLabel => 'Trips';

  @override
  String get navOfferLabel => 'Offer';

  @override
  String get navProfileLabel => 'Profile';

  @override
  String get errorProfileLoad => 'Error loading profile';

  @override
  String get semanticLoadingProfile => 'Loading user profile';

  @override
  String get semanticMainContent => 'Main content';

  @override
  String get noVehicleTitle => 'Vehicle Required';

  @override
  String get noVehicleMessage =>
      'To offer rides, you must register at least one vehicle.';

  @override
  String get registerVehicleAction => 'Register Now';

  @override
  String get cancel => 'Cancel';

  @override
  String get registerVehicleTitle => 'Register Vehicle';

  @override
  String get vehiclePlateLabel => 'License Plate';

  @override
  String get vehicleBrandLabel => 'Brand (e.g., Hyundai, Chevrolet)';

  @override
  String get vehicleModelLabel => 'Model (e.g., HB20)';

  @override
  String get vehicleColorLabel => 'Color';

  @override
  String get vehicleCapacityLabel => 'Passenger Capacity';

  @override
  String get saveVehicleAction => 'Save Vehicle';

  @override
  String get vehicleRegisteredSuccess => 'Vehicle registered successfully!';

  @override
  String get vehicleRegisteredError =>
      'Error registering vehicle. Check your data and try again.';

  @override
  String get requiredField => 'Required field';

  @override
  String get invalidValue => 'Enter a valid value';

  @override
  String get myVehiclesTitle => 'My Vehicles';

  @override
  String get editVehicleAction => 'Edit vehicle';

  @override
  String get deleteVehicleAction => 'Delete vehicle';

  @override
  String vehiclePassengersLabel(int count) {
    return '$count passengers';
  }

  @override
  String get deleteVehicleConfirmTitle => 'Delete vehicle?';

  @override
  String deleteVehicleConfirmMessage(String plate) {
    return 'Are you sure you want to delete vehicle $plate? This action cannot be undone.';
  }

  @override
  String get confirmAction => 'Confirm';

  @override
  String get vehicleDeletedSuccess => 'Vehicle deleted successfully!';

  @override
  String get vehicleDeletedError => 'Error deleting vehicle. Please try again.';

  @override
  String get vehicleUpdatedSuccess => 'Vehicle updated successfully!';

  @override
  String get vehicleUpdatedError =>
      'Error updating vehicle. Please check the data and try again.';

  @override
  String get noVehiclesRegistered => 'No vehicles registered.';

  @override
  String get offerRideTitle => 'Offer a Ride';

  @override
  String get originLabel => 'Origin';

  @override
  String get destinationLabel => 'Destination';

  @override
  String get departureDateLabel => 'Departure Date and Time';

  @override
  String get availableSeatsLabel => 'Available seats';

  @override
  String get maxDetourLabel => 'Maximum accepted detour';

  @override
  String maxDetourValue(int km) {
    return '$km km';
  }

  @override
  String get selectVehicleLabel => 'Vehicle';

  @override
  String get offerRideAction => 'Publish Ride';

  @override
  String get rideCreatedSuccess => 'Ride published successfully!';

  @override
  String get rideCreatedError =>
      'Error publishing ride. Please check the data and try again.';

  @override
  String get selectOriginFirst => 'Please select an origin before continuing.';

  @override
  String get selectDestinationFirst =>
      'Please select a destination before continuing.';

  @override
  String get selectVehicleFirst => 'Please select a vehicle before continuing.';

  @override
  String get selectDepartureFirst => 'Please select a departure date and time.';

  @override
  String get myRidesTitle => 'My Trips';

  @override
  String get ridesAsDriverTab => 'Rides I offer';

  @override
  String get ridesAsPassengerTab => 'My requests';

  @override
  String get rideStatusScheduled => 'Scheduled';

  @override
  String get rideStatusInProgress => 'In progress';

  @override
  String get rideStatusCompleted => 'Completed';

  @override
  String get rideStatusCanceled => 'Canceled';

  @override
  String get rideStatusPending => 'Pending';

  @override
  String get rideStatusAccepted => 'Accepted';

  @override
  String get rideStatusRejected => 'Rejected';

  @override
  String get startRideAction => 'Start';

  @override
  String get completeRideAction => 'Complete ride';

  @override
  String get cancelRideAction => 'Cancel ride';

  @override
  String get editRideAction => 'Edit ride';

  @override
  String get viewRequestsAction => 'Requests';

  @override
  String get rideRequestsTitle => 'Ride requests';

  @override
  String get acceptRequestAction => 'Accept';

  @override
  String get rejectRequestAction => 'Reject';

  @override
  String get cancelRequestAction => 'Cancel request';

  @override
  String get noRidesAsDriver => 'You haven\'t offered any rides yet.';

  @override
  String get noRidesAsPassenger => 'You haven\'t made any requests yet.';

  @override
  String get noRequests => 'No requests for this ride.';

  @override
  String get rideUpdatedSuccess => 'Ride updated successfully!';

  @override
  String get rideUpdatedError => 'Error updating ride. Please try again.';

  @override
  String get rideStartedSuccess => 'Ride started!';

  @override
  String get rideStartedError => 'Error starting ride.';

  @override
  String get rideCompletedSuccess => 'Ride completed!';

  @override
  String get rideCompletedError => 'Error completing ride.';

  @override
  String get rideCanceledSuccess => 'Ride canceled.';

  @override
  String get rideCanceledError => 'Error canceling ride.';

  @override
  String get requestAcceptedSuccess => 'Passenger accepted!';

  @override
  String get requestAcceptedError => 'Error accepting request.';

  @override
  String get requestRejectedSuccess => 'Request rejected.';

  @override
  String get requestRejectedError => 'Error rejecting request.';

  @override
  String get requestCanceledSuccess => 'Request canceled.';

  @override
  String get requestCanceledError => 'Error canceling request.';

  @override
  String get confirmCancelRideTitle => 'Cancel ride?';

  @override
  String get confirmCancelRideMessage =>
      'Are you sure you want to cancel this ride? This action cannot be undone.';

  @override
  String get confirmCompleteRideTitle => 'Complete ride?';

  @override
  String get confirmCompleteRideMessage =>
      'Confirm that the ride has been completed?';

  @override
  String get confirmCancelRequestTitle => 'Cancel request?';

  @override
  String get confirmCancelRequestMessage =>
      'Are you sure you want to cancel your request for this ride?';

  @override
  String get confirmStartRideTitle => 'Start ride?';

  @override
  String get confirmStartRideMessage =>
      'Are you sure you want to start this ride now?';

  @override
  String get maxDetourInfoLabel => 'Detour radius information';

  @override
  String get maxDetourInfoMessage =>
      'Maximum distance you accept to deviate from your route to pick up or drop off a passenger. The higher the value, the more compatible rides will appear for passengers.';

  @override
  String get searchRidesTitle => 'Explore Rides';

  @override
  String get searchRidesAction => 'Search';

  @override
  String get noRidesFound => 'No rides found for this route.';

  @override
  String get driverLabel => 'Driver';

  @override
  String get estimatedTimeLabel => 'Estimated time';

  @override
  String get distanceLabel => 'Distance';

  @override
  String minutesLabel(int mins) {
    return '$mins min';
  }

  @override
  String kilometersLabel(String km) {
    return '$km km';
  }

  @override
  String get requestSeatAction => 'Request seat';

  @override
  String get rideRequestedSuccess => 'Request sent successfully!';

  @override
  String get rideRequestedError => 'Error requesting seat. Please try again.';

  @override
  String get searchingRides => 'Searching rides...';

  @override
  String get rideDetailsTitle => 'Ride Details';

  @override
  String get viewDetailsAction => 'View details';

  @override
  String get editProfileTitle => 'Edit Profile';

  @override
  String get editProfileAction => 'Edit Profile';

  @override
  String get deleteProfileTitle => 'Delete Profile';

  @override
  String get deleteProfileConfirmMessage =>
      'Are you sure you want to delete your account? This action cannot be undone.';

  @override
  String get profileUpdatedSuccess => 'Profile updated successfully!';

  @override
  String get profileUpdatedError => 'Error updating profile. Please try again.';

  @override
  String get profileDeletedError => 'Error deleting profile. Please try again.';

  @override
  String get newPasswordLabel => 'New password (optional)';

  @override
  String get canDriveLabel => 'I am a driver';

  @override
  String get languageLabel => 'Language';

  @override
  String get myProfileTitle => 'My Profile';

  @override
  String get logoutTitle => 'logout';

  @override
  String get saveProfileAction => 'Save Profile';

  @override
  String get noRatingsYet => 'No ratings yet';

  @override
  String ratingSemanticLabel(String avg, int count) {
    return 'Average rating $avg out of 5, based on $count reviews';
  }

  @override
  String get rateDriverAction => 'Rate driver';
}
