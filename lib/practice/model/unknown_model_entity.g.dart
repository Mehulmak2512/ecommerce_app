// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unknown_model_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UnknownModelEntityImpl _$$UnknownModelEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$UnknownModelEntityImpl(
      page: (json['page'] as num?)?.toInt(),
      perPage: (json['per_page'] as num?)?.toInt(),
      total: (json['total'] as num?)?.toInt(),
      totalPages: (json['total_pages'] as num?)?.toInt(),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : UnknownModelDataEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      support: json['support'] == null
          ? null
          : UnknownModelSupportEntity.fromJson(
              json['support'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UnknownModelEntityImplToJson(
        _$UnknownModelEntityImpl instance) =>
    <String, dynamic>{
      'page': instance.page,
      'per_page': instance.perPage,
      'total': instance.total,
      'total_pages': instance.totalPages,
      'data': instance.data,
      'support': instance.support,
    };

_$UnknownModelDataEntityImpl _$$UnknownModelDataEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$UnknownModelDataEntityImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      year: (json['year'] as num?)?.toInt(),
      color: json['color'] as String?,
      pantoneValue: json['pantone_value'] as String?,
    );

Map<String, dynamic> _$$UnknownModelDataEntityImplToJson(
        _$UnknownModelDataEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'year': instance.year,
      'color': instance.color,
      'pantone_value': instance.pantoneValue,
    };

_$UnknownModelSupportEntityImpl _$$UnknownModelSupportEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$UnknownModelSupportEntityImpl(
      url: json['url'] as String?,
      text: json['text'] as String?,
    );

Map<String, dynamic> _$$UnknownModelSupportEntityImplToJson(
        _$UnknownModelSupportEntityImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
      'text': instance.text,
    };
