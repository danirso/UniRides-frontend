# UniRides — Flutter app

University ride-sharing application developed individually by [Daniel Rossi](https://github.com/danirso) as an undergraduate final project (TCC).

The app connects students offering rides with passengers, using the [UniRides FastAPI backend](https://github.com/danirso/tcc-caronas-backend) for authentication, ride management and geospatial matching.

## Features and stack

- Registration, email activation and login with JWT authentication.
- Driver vehicles, ride offers and passenger searches.
- Seat requests, driver acceptance/rejection and cancellations.
- Participant ratings and reviews after completed rides.
- English and Portuguese interface translations.
- Flutter/Dart, Riverpod, Dio, Flutter Secure Storage and Flutter Map.
- Address autocomplete and geocoding through Google Maps web services. Route matching is performed by the backend with PostgreSQL/PostGIS.

Code is organized by feature, with data repositories, domain entities and presentation controllers/screens under `lib/features/`. Shared networking, theme and localization support live under `lib/core/` and `lib/l10n/`.

## Run with the local backend

The instructions below cover debug execution on Linux desktop and an Android emulator. Linux startup and connection to the local API were verified; the Android instructions use the emulator networking configuration. Other platform folders are also present in the repository.

### 1. Start the backend

Follow the [backend setup instructions](https://github.com/danirso/tcc-caronas-backend#run-locally). From its repository, run:

```bash
./scripts/run-local.sh
```

This starts the API at `http://127.0.0.1:8000` and a local Mailpit inbox at `http://127.0.0.1:8025`. The backend script enables local `example.com` accounts and uses a separate local database.

### 2. Prepare Flutter

Install Flutter and the toolchain for your target platform. For Android, start an emulator before running the app. The project requires Dart `^3.11.1` as declared in `pubspec.yaml`; the reference SDK for these instructions is Flutter 3.44.4 with Dart 3.12.2.

```bash
git clone https://github.com/danirso/tcc_caronas_frontend.git
cd tcc_caronas_frontend
flutter doctor
flutter pub get
flutter gen-l10n
flutter devices
```

### 3. Run the app

For **Linux desktop**, use the host loopback address:

```bash
flutter run -d linux \
  --dart-define=API_URL=http://127.0.0.1:8000 \
  --dart-define=ALLOW_LOCAL_TEST_EMAILS=true
```

For **Android Emulator**, replace `<android-device-id>` with the emulator ID reported by `flutter devices`:

```bash
flutter run -d <android-device-id> \
  --dart-define=API_URL=http://10.0.2.2:8000 \
  --dart-define=ALLOW_LOCAL_TEST_EMAILS=true
```

The [Android emulator uses 10.0.2.2 to reach the host computer](https://developer.android.com/studio/run/emulator-networking-address). Without `API_URL`, the app defaults to `http://127.0.0.1:8000`, which refers to the emulator itself when used inside Android Emulator.

Select the device explicitly with `-d`; the API address must match that device. Changes to these compile-time settings require stopping the app and restarting the Flutter run command.

If the repository was moved and a CMake error refers to an old path, rebuild its generated cache:

```bash
flutter clean
flutter pub get
```

### 4. Try registration and login

1. Register `driver@example.com` and enable the driver option, or register `passenger@example.com` as a passenger.
2. Open [Mailpit](http://127.0.0.1:8025) in your computer's browser and follow the activation link.
3. Return to the app and log in with the registered email and password.
4. Explore profiles and vehicles. Configure the Google Maps keys below to use address lookup and the ride-offer flow.

The Flutter client accepts `example.com` only in debug builds with `ALLOW_LOCAL_TEST_EMAILS=true`. Profile/release builds reject that domain even when the option is passed. The backend independently enforces its own email policy and account activation.

The supported institutional domains are `puccampinas.edu.br`, `puc-campinas.edu.br` and `dac.unicamp.br`. UniRides is an academic project, not an official university service.

## Google Maps configuration

Two settings are used by the separate repositories:

| Setting | Used by | Purpose |
| --- | --- | --- |
| `GOOGLE_MAPS_KEY` | Flutter | Places autocomplete and geocoding for address selection |
| `GOOGLE_MAPS_API_KEY` | Backend | Directions data when creating a ride |

Provide your own keys with the corresponding APIs enabled. The app can start and exercise registration/login without them, but address lookup and route creation require working keys.

For the Flutter key, enter it at the prompt below, then run the app in the same shell (Android Emulator example; use `-d linux` and `http://127.0.0.1:8000` for Linux):

```bash
read -rs GOOGLE_MAPS_KEY
flutter run -d <android-device-id> \
  --dart-define=API_URL=http://10.0.2.2:8000 \
  --dart-define=ALLOW_LOCAL_TEST_EMAILS=true \
  --dart-define=GOOGLE_MAPS_KEY="$GOOGLE_MAPS_KEY"
```

A key supplied with `--dart-define` is included in the compiled client; this is not secret storage. Use separate client/backend keys with the appropriate restrictions, following [Google Maps security guidance](https://developers.google.com/maps/api-security-best-practices). Keep real keys, signing files and local configuration out of Git.

## Automation and project scope

Screens and controls include stable `Semantics.identifier` values and widget keys to support future Appium automation. An Appium test suite is not included in this repository. Backend API tests and CI are documented in the [backend repository](https://github.com/danirso/tcc-caronas-backend#run-the-tests).

This setup is intended for local exploration in debug mode. Store distribution and production release signing are not configured by these instructions.

Stop the app with Ctrl+C. To stop the supporting backend services, run this from the backend repository:

```bash
docker compose -f compose.local.yml down
```

The backend database persists in its Docker volume; `down -v` deliberately deletes that local data.
