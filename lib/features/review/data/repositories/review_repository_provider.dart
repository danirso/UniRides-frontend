import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tcc_caronas_frontend/core/network/dio_provider.dart';
import '../../domain/repositories/i_review_repository.dart';
import 'review_repository_impl.dart';

final reviewRepositoryProvider = Provider<IReviewRepository>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ReviewRepositoryImpl(dioClient);
});
