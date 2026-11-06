import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcc_caronas_frontend/generated/l10n/app_localizations.dart';
import '../../../auth/presentation/controllers/user_controller.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../auth/presentation/screens/login_screen.dart';
import '../../../vehicles/presentation/screens/vehicle_list_screen.dart';
import '../widgets/profile_edit_modal.dart';
import 'package:tcc_caronas_frontend/core/providers/locale_provider.dart';
import '../../../review/presentation/widgets/rating_badge.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => Semantics(
        identifier: 'dialog_delete_profile',
        container: true,
        child: AlertDialog(
          title: Semantics(header: true, child: Text(l10n.deleteProfileTitle)),
          content: Text(l10n.deleteProfileConfirmMessage),
          actions: [
            Semantics(
              identifier: 'cancel_delete_profile_button',
              button: true,
              child: TextButton(
                key: const Key('cancel_delete_profile_button'),
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(l10n.cancel),
              ),
            ),
            Semantics(
              identifier: 'confirm_delete_profile_button',
              button: true,
              child: ElevatedButton(
                key: const Key('confirm_delete_profile_button'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                ),
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(l10n.confirmAction),
              ),
            ),
          ],
        ),
      ),
    );

    if (confirmed != true || !context.mounted) return;

    final success = await ref.read(userControllerProvider.notifier).deleteMe();

    if (!context.mounted) return;

    if (success) {
      await ref.read(authControllerProvider.notifier).logout();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.profileDeletedError),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final user = ref.watch(userControllerProvider).value;
    final currentLocale = ref.watch(localeStateProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.myProfileTitle)),
      body: Semantics(
        identifier: 'screen_profile',
        container: true,
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.person),
              title: Row(
                children: [
                  Flexible(
                    child: Text(
                      user?.name ?? '',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (user != null) ...[
                    const SizedBox(width: 8),
                    RatingBadge(
                      ratingAvg: user.ratingAvg,
                      ratingCount: user.ratingCount,
                      userId: user.id,
                    ),
                  ],
                ],
              ),
              subtitle: Text(user?.email ?? ''),
            ),
            const Divider(),
            Semantics(
              identifier: 'edit_profile_tile',
              button: true,
              child: ListTile(
                key: const Key('edit_profile_tile'),
                leading: const Icon(Icons.edit_outlined),
                title: Text(l10n.editProfileAction),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  if (user == null) return;
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => ProfileEditModal(user: user),
                  );
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(l10n.languageLabel),
              trailing: Semantics(
                identifier: 'language_dropdown',
                child: DropdownButton<String>(
                  key: const Key('language_dropdown'),
                  value: currentLocale.languageCode,
                  underline: const SizedBox.shrink(),
                  items: const [
                    DropdownMenuItem(value: 'pt', child: Text('Português')),
                    DropdownMenuItem(value: 'en', child: Text('English')),
                  ],
                  onChanged: (String? newValue) {
                    if (newValue == null) return;
                    final locale = newValue == 'pt'
                        ? const Locale('pt', 'BR')
                        : const Locale('en', 'US');
                    ref.read(localeStateProvider.notifier).setLocale(locale);
                  },
                ),
              ),
            ),
            Semantics(
              identifier: 'my_vehicles_tile',
              button: true,
              child: ListTile(
                key: const Key('my_vehicles_tile'),
                leading: const Icon(Icons.directions_car),
                title: Text(l10n.myVehiclesTitle),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const VehicleListScreen(),
                  ),
                ),
              ),
            ),
            const Divider(),
            Semantics(
              identifier: 'delete_profile_tile',
              button: true,
              child: ListTile(
                key: const Key('delete_profile_tile'),
                leading: const Icon(
                  Icons.delete_forever,
                  color: Colors.redAccent,
                ),
                title: Text(
                  l10n.deleteProfileTitle,
                  style: const TextStyle(color: Colors.redAccent),
                ),
                onTap: () => _confirmDelete(context, ref),
              ),
            ),
            Semantics(
              identifier: 'logout_tile',
              button: true,
              child: ListTile(
                key: const Key('logout_tile'),
                leading: const Icon(Icons.logout),
                title: Text(l10n.logoutTitle),
                onTap: () async {
                  await ref.read(authControllerProvider.notifier).logout();
                  if (context.mounted) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                      (route) => false,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
