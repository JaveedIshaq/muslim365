import 'package:equatable/equatable.dart';
import 'package:mobile/core/enum/banner_status_enum.dart';

class BannerEntity extends Equatable {
  final String id;
  final String img;
  final BannerStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String title;
  final String description;

  const BannerEntity({
    required this.id,
    required this.img,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.title,
    required this.description,
  });

  BannerEntity.empty()
    : id = "",
      img = "",
      status = BannerStatus.inactive,
      createdAt = DateTime.fromMillisecondsSinceEpoch(0),
      updatedAt = DateTime.fromMillisecondsSinceEpoch(0),
      title = "",
      description = "";

  @override
  List<Object?> get props => [
    id,
    img,
    status,
    createdAt,
    updatedAt,
    title,
    description,
  ];

  BannerEntity copyWith({
    String? id,
    String? img,
    BannerStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? title,
    String? description,
  }) {
    return BannerEntity(
      id: id ?? this.id,
      img: img ?? this.img,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }
}
