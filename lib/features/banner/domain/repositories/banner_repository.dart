import 'package:mobile/features/banner/domain/entities/banner_entity.dart';

abstract class BannerRepository {
  Stream<List<BannerEntity>> getBannersStream();
}
