import 'dart:io';

/// Abstract class for network information
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

/// Simple implementation of NetworkInfo using basic connectivity check
class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<bool> get isConnected async {
    try {
      // Simple connectivity check - try to resolve a common hostname
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}