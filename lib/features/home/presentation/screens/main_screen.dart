import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcc_caronas_frontend/generated/l10n/app_localizations.dart';
import '../../../auth/presentation/controllers/user_controller.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userControllerProvider);
    final l10n = AppLocalizations.of(context)!;

    return userState.when(
      loading: () => Scaffold(
        body: Semantics(
          label: l10n.semanticLoadingProfile,
          child: const Center(child: CircularProgressIndicator()),
        ),
      ),
      error: (err, stack) {
        debugPrint('Erro no MainScreen: $err');
        return Scaffold(
          body: Semantics(
            label: l10n.errorProfileLoad,
            child: Center(child: Text(l10n.errorProfileLoad)),
          ),
        );
      },
      data: (user) {
        final bool canDrive = user?.canDrive ?? false;

        final List<Widget> screens = [
          const Center(child: Text('TBI: Explorar Caronas')),
          const Center(child: Text('TBI: Minhas Viagens')),
          if (canDrive) const Center(child: Text('TBI: Oferecer Carona')),
          const Center(child: Text('TBI: Perfil')),
        ];

        final List<NavigationDestination> destinations = [
          NavigationDestination(
            icon: Semantics(
              label: l10n.navSearchLabel,
              child: const Icon(Icons.search),
            ),
            label: l10n.navSearchLabel,
            key: const Key('nav_search_key'),
          ),
          NavigationDestination(
            icon: Semantics(
              label: l10n.navRidesLabel,
              child: const Icon(Icons.list_alt),
            ),
            label: l10n.navRidesLabel,
            key: const Key('nav_rides_key'),
          ),
          if (canDrive)
            NavigationDestination(
              icon: Semantics(
                label: l10n.navOfferLabel,
                child: const Icon(Icons.add_circle),
              ),
              label: l10n.navOfferLabel,
              key: const Key('nav_offer_key'),
            ),
          NavigationDestination(
            icon: Semantics(
              label: l10n.navProfileLabel,
              child: const Icon(Icons.account_circle),
            ),
            label: l10n.navProfileLabel,
            key: const Key('nav_profile_key'),
          ),
        ];

        final safeIndex = _selectedIndex >= destinations.length ? 0 : _selectedIndex;

        return Scaffold(
          body: Semantics(
            label: l10n.semanticMainContent,
            child: IndexedStack(
              index: safeIndex,
              children: screens,
            ),
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: safeIndex,
            onDestinationSelected: (index) => setState(() => _selectedIndex = index),
            destinations: destinations,
          ),
        );
      },
    );
  }
}