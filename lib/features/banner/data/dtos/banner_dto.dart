import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile/core/enum/banner_status_enum.dart';
import 'package:mobile/features/banner/domain/entities/banner_entity.dart';

// This is necessary for the generator to work.
part 'banner_dto.freezed.dart';
part 'banner_dto.g.dart';

/// A DTO (Data Transfer Object) for a Banner.
///
/// This class is used to deserialize JSON from the API into a structured object.
/// The `@freezed` annotation generates the necessary methods like `copyWith`,
/// `==`, `toString`, and `toJson`.
@freezed
abstract class BannerDto with _$BannerDto {
  /// Private constructor for the freezed class.
  /// All fields are final and nullable, matching the original implementation.
  /// `@JsonKey` is used to map JSON keys to Dart field names.
  const factory BannerDto({
    @JsonKey(name: "id") final String? id,
    @JsonKey(name: "img") final String? img,
    @JsonKey(name: "status") final String? status,
    @JsonKey(name: "created_at") final String? createdAt,
    @JsonKey(name: "updated_at") final String? updatedAt,
    @JsonKey(name: "title") final String? title,
    @JsonKey(name: "description") final String? description,
  }) = _BannerDto;

  factory BannerDto.fromJson(Map<String, dynamic> json) =>
      _$BannerDtoFromJson(json);
}

/// An extension on `BannerDto` to add custom methods, like `toEntity`.
///
/// This is the recommended way to add functionality to a freezed class
/// without interfering with the code generation.
extension BannerDtoX on BannerDto {
  /// Converts the `BannerDto` to a `BannerEntity`.
  ///
  /// This is useful for passing data between the data layer and the domain layer.
  /// It provides default values for null fields, matching the original logic.
  BannerEntity toEntity() => BannerEntity(
    id: id ?? "",
    img: img ?? "",
    status: BannerStatus.fromJson(status ?? ''),
    createdAt:
        DateTime.tryParse(createdAt ?? '') ??
        DateTime.fromMillisecondsSinceEpoch(0),
    updatedAt:
        DateTime.tryParse(updatedAt ?? '') ??
        DateTime.fromMillisecondsSinceEpoch(0),
    title: title ?? "",
    description: description ?? "",
  );
}
