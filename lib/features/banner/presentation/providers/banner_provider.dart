import 'package:mobile/core/logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mobile/features/banner/domain/entities/banner_entity.dart';
import 'package:mobile/features/banner/presentation/providers/banner_repository_provider.dart';

part 'banner_provider.g.dart';

/// ✅ BEST PRACTICE: Simple StreamProvider for real-time data
///
/// Benefits:
/// - Automatic subscription management
/// - Built-in error handling
/// - Memory leak prevention (auto-dispose when not in use)
/// - Clean, readable code
/// - Follows functional programming principles
@Riverpod(keepAlive: false)
Stream<List<BannerEntity>> bannerStream(Ref ref) {
  Log.info('Provider: Building banner stream');

  final bannerRepository = ref.watch(bannerRepositoryProvider);

  // Repository now returns Stream<List<BannerEntity>> directly
  // Errors are thrown by the repository and caught by Riverpod
  return bannerRepository.getBannersStream().map((banners) {
    Log.success(
      'Provider: Stream emitted banners',
      data: {'count': banners.length},
    );
    return banners;
  });
}

/// ✅ BEST PRACTICE: AsyncNotifier for complex stream management
///
/// Use when you need:
/// - Additional methods (refresh, retry, etc.)
/// - Complex stream transformations
/// - Initial loading states
/// - Manual subscription control
@riverpod
class BannerAsync extends _$BannerAsync {
  @override
  FutureOr<List<BannerEntity>> build() async {
    final bannerRepository = ref.watch(bannerRepositoryProvider);

    // Subscribe to stream for real-time updates
    final streamSubscription = bannerRepository.getBannersStream().listen(
      (banners) {
        state = AsyncValue.data(banners);
      },
      onError: (error, stackTrace) {
        state = AsyncValue.error(error, stackTrace);
      },
    );

    // Clean up subscription when provider is disposed
    ref.onDispose(() => streamSubscription.cancel());

    // Return initial value while waiting for first stream emission
    return [];
  }

  /// Manual refresh capability
  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}
