import 'package:mobile/core/error/error_handler.dart';
import 'package:mobile/core/logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:mobile/features/banner/data/dtos/banner_dto.dart';

class BannerRemoteDataSource {
  final SupabaseClient _supabaseClient;

  BannerRemoteDataSource(this._supabaseClient);

  /// Supabase Realtime automatically manages connection lifecycle.
  Stream<List<BannerDto>> getBannersStream() {
    Log.info("Setting up banners stream from database");

    return _supabaseClient
        .from('banners')
        .stream(primaryKey: ['id'])
        .eq('status', 'ACTIVE') // Only fetch active banners
        .order('created_at', ascending: false)
        .map((event) {
          //
          Log.supabaseResponse('GET', 'banners', event);

          //
          List<BannerDto> banners = event
              .map((e) => BannerDto.fromJson(e))
              .toList();

          return banners;
        })
        .handleError(ErrorHandler.handleStreamError);
  }
}
