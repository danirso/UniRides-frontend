import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcc_caronas_frontend/generated/l10n/app_localizations.dart';
import '../../domain/entities/pending_review_target_entity.dart';
import '../controllers/pending_reviews_controller.dart';
import 'star_rating_input.dart';
import '../../../../core/errors/review_exceptions.dart';

class ReviewFormWidget extends ConsumerStatefulWidget {
  final String rideId;
  final PendingReviewTargetEntity target;

  const ReviewFormWidget({
    super.key,
    required this.rideId,
    required this.target,
  });

  @override
  ConsumerState<ReviewFormWidget> createState() => _ReviewFormWidgetState();
}

class _ReviewFormWidgetState extends ConsumerState<ReviewFormWidget> {
  int _rating = 0;
  final _commentController = TextEditingController();
  bool _isSubmitting = false;
  String? _errorMessage;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  String _roleLabel(AppLocalizations l10n) {
    return widget.target.role == ReviewTargetRole.driver
        ? l10n.reviewRoleDriver
        : l10n.reviewRolePassenger;
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context)!;
    if (_rating == 0) {
      setState(() => _errorMessage = l10n.selectRatingError);
      return;
    }
    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });
    try {
      await ref
          .read(pendingReviewsControllerProvider(widget.rideId).notifier)
          .submitReview(
            revieweeId: widget.target.userId,
            rating: _rating,
            comment: _commentController.text.trim().isEmpty
                ? null
                : _commentController.text.trim(),
          );
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = e is DuplicateReviewException
            ? l10n.duplicateReviewError
            : l10n.submitReviewError;
      });
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final roleLabel = _roleLabel(l10n);

    return Semantics(
      identifier: 'modal_review_form',
      container: true,
      child: Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Semantics(
              header: true,
              child: Text(
                l10n.reviewFormTitle(roleLabel, widget.target.name),
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            StarRatingInput(
              rating: _rating,
              onChanged: (value) => setState(() => _rating = value),
            ),
            const SizedBox(height: 16),
            Semantics(
              identifier: 'review_comment_field',
              textField: true,
              label: l10n.commentOptionalHint,
              child: TextField(
                key: const Key('review_comment_field'),
                controller: _commentController,
                maxLines: 3,
                maxLength: 500,
                decoration: InputDecoration(
                  hintText: l10n.commentOptionalHint,
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            if (_errorMessage != null) ...[
              const SizedBox(height: 4),
              Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
            ],
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Semantics(
                    identifier: 'review_skip_button',
                    button: true,
                    child: TextButton(
                      key: const Key('review_skip_button'),
                      onPressed: _isSubmitting
                          ? null
                          : () => Navigator.of(context).pop(),
                      child: Text(l10n.skipAction),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Semantics(
                    identifier: 'review_submit_button',
                    button: true,
                    child: ElevatedButton(
                      key: const Key('review_submit_button'),
                      onPressed: _isSubmitting ? null : _submit,
                      child: _isSubmitting
                          ? const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(l10n.submitReviewAction),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
