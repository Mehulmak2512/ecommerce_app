import 'package:freezed_annotation/freezed_annotation.dart';

part 'unknown_model_entity.freezed.dart';

part 'unknown_model_entity.g.dart';

@freezed
class UnknownModelEntity with _$UnknownModelEntity {
  const factory UnknownModelEntity({
    int? page,
    @JsonKey(name: 'per_page') int? perPage,
    int? total,
    @JsonKey(name: 'total_pages') int? totalPages,
    List<UnknownModelDataEntity?>? data,
    UnknownModelSupportEntity? support,
  }) = _UnknownModelEntity;

  factory UnknownModelEntity.fromJson(Map<String, dynamic> json) => _$UnknownModelEntityFromJson(json);
}

@freezed
class UnknownModelDataEntity with _$UnknownModelDataEntity {
  const factory UnknownModelDataEntity({
    int? id,
    String? name,
    int? year,
    String? color,
    @JsonKey(name: 'pantone_value') String? pantoneValue,
  }) = _UnknownModelDataEntity;

  factory UnknownModelDataEntity.fromJson(Map<String, dynamic> json) => _$UnknownModelDataEntityFromJson(json);
}

@freezed
class UnknownModelSupportEntity with _$UnknownModelSupportEntity {
  const factory UnknownModelSupportEntity({
    String? url,
    String? text,
  }) = _UnknownModelSupportEntity;

  factory UnknownModelSupportEntity.fromJson(Map<String, dynamic> json) => _$UnknownModelSupportEntityFromJson(json);
}
