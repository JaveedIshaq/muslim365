import 'package:mobile/core/providers/supabase_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mobile/features/banner/domain/repositories/banner_repository.dart';
import 'package:mobile/features/banner/data/repositories/banner_repository.dart';
import 'package:mobile/features/banner/data/data_sources/banner_remote_data_source.dart';

part 'banner_repository_provider.g.dart';

/// Provider for BannerRemoteDataSource
/// Handles the data layer dependencies
@riverpod
BannerRemoteDataSource bannerRemoteDataSource(Ref ref) {
  return BannerRemoteDataSource(ref.watch(supabaseClientProvider));
}

/// Provider for BannerRepository
///
/// This provider follows pure Riverpod patterns without mixing Service Locator.
/// Dependencies are explicit and can be easily mocked in tests.
///
/// Usage:
/// ```dart
/// final repository = ref.watch(bannerRepositoryProvider);
/// ```
///
/// Testing:
/// ```dart
/// ref.override(bannerRepositoryProvider, mockBannerRepository);
/// ```
@riverpod
BannerRepository bannerRepository(Ref ref) {
  return BannerRepositoryImpl(ref.watch(bannerRemoteDataSourceProvider));
}
