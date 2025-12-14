import 'dart:async';

import 'package:mobile/core/error/error_handler.dart';
import 'package:mobile/features/banner/domain/entities/banner_entity.dart';
import 'package:mobile/features/banner/domain/repositories/banner_repository.dart';
import 'package:mobile/features/banner/data/data_sources/banner_remote_data_source.dart';
import 'package:mobile/features/banner/data/dtos/banner_dto.dart';

class BannerRepositoryImpl implements BannerRepository {
  final BannerRemoteDataSource _remoteDataSource;

  BannerRepositoryImpl(this._remoteDataSource);

  @override
  Stream<List<BannerEntity>> getBannersStream() {
    // Data source returns Stream<List<BannerDto>>
    return _remoteDataSource
        .getBannersStream()
        .map((bannerDtos) {
          // Convert DTOs to Entities
          return bannerDtos.map((dto) => dto.toEntity()).toList();
        })
        .handleError(ErrorHandler.handleStreamError);
  }
}
