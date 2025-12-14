// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// ✅ BEST PRACTICE: Simple StreamProvider for real-time data
///
/// Benefits:
/// - Automatic subscription management
/// - Built-in error handling
/// - Memory leak prevention (auto-dispose when not in use)
/// - Clean, readable code
/// - Follows functional programming principles

@ProviderFor(bannerStream)
const bannerStreamProvider = BannerStreamProvider._();

/// ✅ BEST PRACTICE: Simple StreamProvider for real-time data
///
/// Benefits:
/// - Automatic subscription management
/// - Built-in error handling
/// - Memory leak prevention (auto-dispose when not in use)
/// - Clean, readable code
/// - Follows functional programming principles

final class BannerStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<BannerEntity>>,
          List<BannerEntity>,
          Stream<List<BannerEntity>>
        >
    with
        $FutureModifier<List<BannerEntity>>,
        $StreamProvider<List<BannerEntity>> {
  /// ✅ BEST PRACTICE: Simple StreamProvider for real-time data
  ///
  /// Benefits:
  /// - Automatic subscription management
  /// - Built-in error handling
  /// - Memory leak prevention (auto-dispose when not in use)
  /// - Clean, readable code
  /// - Follows functional programming principles
  const BannerStreamProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bannerStreamProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bannerStreamHash();

  @$internal
  @override
  $StreamProviderElement<List<BannerEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<BannerEntity>> create(Ref ref) {
    return bannerStream(ref);
  }
}

String _$bannerStreamHash() => r'8fa0f28db5bf6c41f6e31573990348ef5db983af';

/// ✅ BEST PRACTICE: AsyncNotifier for complex stream management
///
/// Use when you need:
/// - Additional methods (refresh, retry, etc.)
/// - Complex stream transformations
/// - Initial loading states
/// - Manual subscription control

@ProviderFor(BannerAsync)
const bannerAsyncProvider = BannerAsyncProvider._();

/// ✅ BEST PRACTICE: AsyncNotifier for complex stream management
///
/// Use when you need:
/// - Additional methods (refresh, retry, etc.)
/// - Complex stream transformations
/// - Initial loading states
/// - Manual subscription control
final class BannerAsyncProvider
    extends $AsyncNotifierProvider<BannerAsync, List<BannerEntity>> {
  /// ✅ BEST PRACTICE: AsyncNotifier for complex stream management
  ///
  /// Use when you need:
  /// - Additional methods (refresh, retry, etc.)
  /// - Complex stream transformations
  /// - Initial loading states
  /// - Manual subscription control
  const BannerAsyncProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bannerAsyncProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bannerAsyncHash();

  @$internal
  @override
  BannerAsync create() => BannerAsync();
}

String _$bannerAsyncHash() => r'a5909bc08cc495edc72eb66a280ee794abde7a71';

/// ✅ BEST PRACTICE: AsyncNotifier for complex stream management
///
/// Use when you need:
/// - Additional methods (refresh, retry, etc.)
/// - Complex stream transformations
/// - Initial loading states
/// - Manual subscription control

abstract class _$BannerAsync extends $AsyncNotifier<List<BannerEntity>> {
  FutureOr<List<BannerEntity>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<BannerEntity>>, List<BannerEntity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<BannerEntity>>, List<BannerEntity>>,
              AsyncValue<List<BannerEntity>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
