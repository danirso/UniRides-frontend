class DuplicateReviewException implements Exception {
  final String message;

  const DuplicateReviewException([
    this.message = 'Você já avaliou esta pessoa nesta carona.',
  ]);

  @override
  String toString() => message;
}
