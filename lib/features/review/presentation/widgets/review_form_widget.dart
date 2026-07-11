import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/pending_review_target_entity.dart';
import '../controllers/pending_reviews_controller.dart';
import 'star_rating_input.dart';

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

  Future<void> _submit() async {
    if (_rating == 0) {
      setState(() => _errorMessage = 'Selecione uma nota de 1 a 5 estrelas.');
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
      setState(() => _errorMessage = e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final roleLabel =
        widget.target.role == ReviewTargetRole.driver ? 'motorista' : 'passageiro';

    return Padding(
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
              'Avaliar $roleLabel: ${widget.target.name}',
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
            textField: true,
            label: 'Comentário opcional sobre $roleLabel',
            child: TextField(
              key: const Key('review_comment_field'),
              controller: _commentController,
              maxLines: 3,
              maxLength: 500,
              decoration: const InputDecoration(
                hintText: 'Comentário (opcional)',
                border: OutlineInputBorder(),
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
                child: TextButton(
                  key: const Key('review_skip_button'),
                  onPressed: _isSubmitting ? null : () => Navigator.of(context).pop(),
                  child: const Text('Pular'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  key: const Key('review_submit_button'),
                  onPressed: _isSubmitting ? null : _submit,
                  child: _isSubmitting
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Enviar avaliação'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
