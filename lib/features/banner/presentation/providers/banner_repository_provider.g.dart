// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for BannerRemoteDataSource
/// Handles the data layer dependencies

@ProviderFor(bannerRemoteDataSource)
const bannerRemoteDataSourceProvider = BannerRemoteDataSourceProvider._();

/// Provider for BannerRemoteDataSource
/// Handles the data layer dependencies

final class BannerRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          BannerRemoteDataSource,
          BannerRemoteDataSource,
          BannerRemoteDataSource
        >
    with $Provider<BannerRemoteDataSource> {
  /// Provider for BannerRemoteDataSource
  /// Handles the data layer dependencies
  const BannerRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bannerRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bannerRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<BannerRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BannerRemoteDataSource create(Ref ref) {
    return bannerRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BannerRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BannerRemoteDataSource>(value),
    );
  }
}

String _$bannerRemoteDataSourceHash() =>
    r'bc13c939e7327d960e194ae87812770c2c42061c';

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

@ProviderFor(bannerRepository)
const bannerRepositoryProvider = BannerRepositoryProvider._();

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

final class BannerRepositoryProvider
    extends
        $FunctionalProvider<
          BannerRepository,
          BannerRepository,
          BannerRepository
        >
    with $Provider<BannerRepository> {
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
  const BannerRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bannerRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bannerRepositoryHash();

  @$internal
  @override
  $ProviderElement<BannerRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BannerRepository create(Ref ref) {
    return bannerRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BannerRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BannerRepository>(value),
    );
  }
}

String _$bannerRepositoryHash() => r'7359547bf58980c42ade2a4b3d8a2568d3257ac0';
