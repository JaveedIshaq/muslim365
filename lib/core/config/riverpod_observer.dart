import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/logger/logger.dart';

final class RiverpodDebugObserver extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderObserverContext context,
    Object? previousValue,
    Object? newValue,
  ) {
    Log.info('[RIVERPOD] Updated provider: ${context.provider}');
  }

  @override
  void didAddProvider(
    ProviderObserverContext context,
    Object? value,
  ) {
    Log.info('[RIVERPOD] Added provider: ${context.provider}');
  }

  @override
  void didDisposeProvider(
    ProviderObserverContext context,
  ) {
    Log.info('[RIVERPOD] Disposed provider: ${context.provider}');
  }
}
