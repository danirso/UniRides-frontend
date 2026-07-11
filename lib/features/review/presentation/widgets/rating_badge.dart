import 'package:flutter/material.dart';
import 'package:tcc_caronas_frontend/generated/l10n/app_localizations.dart';
import 'package:tcc_caronas_frontend/core/theme/app_theme.dart';

class RatingBadge extends StatelessWidget {
  final double ratingAvg;
  final int ratingCount;

  const RatingBadge({
    super.key,
    required this.ratingAvg,
    required this.ratingCount,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (ratingCount == 0) {
      return Semantics(
        label: l10n.noRatingsYet,
        child: Text(
          '—',
          style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
        ),
      );
    }

    return Semantics(
      label: l10n.ratingSemanticLabel(
        ratingAvg.toStringAsFixed(1),
        ratingCount,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star_rounded, size: 16, color: AppTheme.sandYellow),
          const SizedBox(width: 4),
          Text(
            ratingAvg.toStringAsFixed(1),
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
          const SizedBox(width: 2),
          Text(
            '($ratingCount)',
            style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
