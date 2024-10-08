// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'unknown_model_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UnknownModelEntity _$UnknownModelEntityFromJson(Map<String, dynamic> json) {
  return _UnknownModelEntity.fromJson(json);
}

/// @nodoc
mixin _$UnknownModelEntity {
  int? get page => throw _privateConstructorUsedError;
  @JsonKey(name: 'per_page')
  int? get perPage => throw _privateConstructorUsedError;
  int? get total => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_pages')
  int? get totalPages => throw _privateConstructorUsedError;
  List<UnknownModelDataEntity?>? get data => throw _privateConstructorUsedError;
  UnknownModelSupportEntity? get support => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UnknownModelEntityCopyWith<UnknownModelEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UnknownModelEntityCopyWith<$Res> {
  factory $UnknownModelEntityCopyWith(
          UnknownModelEntity value, $Res Function(UnknownModelEntity) then) =
      _$UnknownModelEntityCopyWithImpl<$Res, UnknownModelEntity>;
  @useResult
  $Res call(
      {int? page,
      @JsonKey(name: 'per_page') int? perPage,
      int? total,
      @JsonKey(name: 'total_pages') int? totalPages,
      List<UnknownModelDataEntity?>? data,
      UnknownModelSupportEntity? support});

  $UnknownModelSupportEntityCopyWith<$Res>? get support;
}

/// @nodoc
class _$UnknownModelEntityCopyWithImpl<$Res, $Val extends UnknownModelEntity>
    implements $UnknownModelEntityCopyWith<$Res> {
  _$UnknownModelEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = freezed,
    Object? perPage = freezed,
    Object? total = freezed,
    Object? totalPages = freezed,
    Object? data = freezed,
    Object? support = freezed,
  }) {
    return _then(_value.copyWith(
      page: freezed == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int?,
      perPage: freezed == perPage
          ? _value.perPage
          : perPage // ignore: cast_nullable_to_non_nullable
              as int?,
      total: freezed == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int?,
      totalPages: freezed == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<UnknownModelDataEntity?>?,
      support: freezed == support
          ? _value.support
          : support // ignore: cast_nullable_to_non_nullable
              as UnknownModelSupportEntity?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UnknownModelSupportEntityCopyWith<$Res>? get support {
    if (_value.support == null) {
      return null;
    }

    return $UnknownModelSupportEntityCopyWith<$Res>(_value.support!, (value) {
      return _then(_value.copyWith(support: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UnknownModelEntityImplCopyWith<$Res>
    implements $UnknownModelEntityCopyWith<$Res> {
  factory _$$UnknownModelEntityImplCopyWith(_$UnknownModelEntityImpl value,
          $Res Function(_$UnknownModelEntityImpl) then) =
      __$$UnknownModelEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? page,
      @JsonKey(name: 'per_page') int? perPage,
      int? total,
      @JsonKey(name: 'total_pages') int? totalPages,
      List<UnknownModelDataEntity?>? data,
      UnknownModelSupportEntity? support});

  @override
  $UnknownModelSupportEntityCopyWith<$Res>? get support;
}

/// @nodoc
class __$$UnknownModelEntityImplCopyWithImpl<$Res>
    extends _$UnknownModelEntityCopyWithImpl<$Res, _$UnknownModelEntityImpl>
    implements _$$UnknownModelEntityImplCopyWith<$Res> {
  __$$UnknownModelEntityImplCopyWithImpl(_$UnknownModelEntityImpl _value,
      $Res Function(_$UnknownModelEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = freezed,
    Object? perPage = freezed,
    Object? total = freezed,
    Object? totalPages = freezed,
    Object? data = freezed,
    Object? support = freezed,
  }) {
    return _then(_$UnknownModelEntityImpl(
      page: freezed == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int?,
      perPage: freezed == perPage
          ? _value.perPage
          : perPage // ignore: cast_nullable_to_non_nullable
              as int?,
      total: freezed == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int?,
      totalPages: freezed == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int?,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<UnknownModelDataEntity?>?,
      support: freezed == support
          ? _value.support
          : support // ignore: cast_nullable_to_non_nullable
              as UnknownModelSupportEntity?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UnknownModelEntityImpl implements _UnknownModelEntity {
  const _$UnknownModelEntityImpl(
      {this.page,
      @JsonKey(name: 'per_page') this.perPage,
      this.total,
      @JsonKey(name: 'total_pages') this.totalPages,
      final List<UnknownModelDataEntity?>? data,
      this.support})
      : _data = data;

  factory _$UnknownModelEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$UnknownModelEntityImplFromJson(json);

  @override
  final int? page;
  @override
  @JsonKey(name: 'per_page')
  final int? perPage;
  @override
  final int? total;
  @override
  @JsonKey(name: 'total_pages')
  final int? totalPages;
  final List<UnknownModelDataEntity?>? _data;
  @override
  List<UnknownModelDataEntity?>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final UnknownModelSupportEntity? support;

  @override
  String toString() {
    return 'UnknownModelEntity(page: $page, perPage: $perPage, total: $total, totalPages: $totalPages, data: $data, support: $support)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnknownModelEntityImpl &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.perPage, perPage) || other.perPage == perPage) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.support, support) || other.support == support));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, page, perPage, total, totalPages,
      const DeepCollectionEquality().hash(_data), support);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UnknownModelEntityImplCopyWith<_$UnknownModelEntityImpl> get copyWith =>
      __$$UnknownModelEntityImplCopyWithImpl<_$UnknownModelEntityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UnknownModelEntityImplToJson(
      this,
    );
  }
}

abstract class _UnknownModelEntity implements UnknownModelEntity {
  const factory _UnknownModelEntity(
      {final int? page,
      @JsonKey(name: 'per_page') final int? perPage,
      final int? total,
      @JsonKey(name: 'total_pages') final int? totalPages,
      final List<UnknownModelDataEntity?>? data,
      final UnknownModelSupportEntity? support}) = _$UnknownModelEntityImpl;

  factory _UnknownModelEntity.fromJson(Map<String, dynamic> json) =
      _$UnknownModelEntityImpl.fromJson;

  @override
  int? get page;
  @override
  @JsonKey(name: 'per_page')
  int? get perPage;
  @override
  int? get total;
  @override
  @JsonKey(name: 'total_pages')
  int? get totalPages;
  @override
  List<UnknownModelDataEntity?>? get data;
  @override
  UnknownModelSupportEntity? get support;
  @override
  @JsonKey(ignore: true)
  _$$UnknownModelEntityImplCopyWith<_$UnknownModelEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UnknownModelDataEntity _$UnknownModelDataEntityFromJson(
    Map<String, dynamic> json) {
  return _UnknownModelDataEntity.fromJson(json);
}

/// @nodoc
mixin _$UnknownModelDataEntity {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  int? get year => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;
  @JsonKey(name: 'pantone_value')
  String? get pantoneValue => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UnknownModelDataEntityCopyWith<UnknownModelDataEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UnknownModelDataEntityCopyWith<$Res> {
  factory $UnknownModelDataEntityCopyWith(UnknownModelDataEntity value,
          $Res Function(UnknownModelDataEntity) then) =
      _$UnknownModelDataEntityCopyWithImpl<$Res, UnknownModelDataEntity>;
  @useResult
  $Res call(
      {int? id,
      String? name,
      int? year,
      String? color,
      @JsonKey(name: 'pantone_value') String? pantoneValue});
}

/// @nodoc
class _$UnknownModelDataEntityCopyWithImpl<$Res,
        $Val extends UnknownModelDataEntity>
    implements $UnknownModelDataEntityCopyWith<$Res> {
  _$UnknownModelDataEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? year = freezed,
    Object? color = freezed,
    Object? pantoneValue = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      year: freezed == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      pantoneValue: freezed == pantoneValue
          ? _value.pantoneValue
          : pantoneValue // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UnknownModelDataEntityImplCopyWith<$Res>
    implements $UnknownModelDataEntityCopyWith<$Res> {
  factory _$$UnknownModelDataEntityImplCopyWith(
          _$UnknownModelDataEntityImpl value,
          $Res Function(_$UnknownModelDataEntityImpl) then) =
      __$$UnknownModelDataEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? name,
      int? year,
      String? color,
      @JsonKey(name: 'pantone_value') String? pantoneValue});
}

/// @nodoc
class __$$UnknownModelDataEntityImplCopyWithImpl<$Res>
    extends _$UnknownModelDataEntityCopyWithImpl<$Res,
        _$UnknownModelDataEntityImpl>
    implements _$$UnknownModelDataEntityImplCopyWith<$Res> {
  __$$UnknownModelDataEntityImplCopyWithImpl(
      _$UnknownModelDataEntityImpl _value,
      $Res Function(_$UnknownModelDataEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? year = freezed,
    Object? color = freezed,
    Object? pantoneValue = freezed,
  }) {
    return _then(_$UnknownModelDataEntityImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      year: freezed == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      pantoneValue: freezed == pantoneValue
          ? _value.pantoneValue
          : pantoneValue // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UnknownModelDataEntityImpl implements _UnknownModelDataEntity {
  const _$UnknownModelDataEntityImpl(
      {this.id,
      this.name,
      this.year,
      this.color,
      @JsonKey(name: 'pantone_value') this.pantoneValue});

  factory _$UnknownModelDataEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$UnknownModelDataEntityImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;
  @override
  final int? year;
  @override
  final String? color;
  @override
  @JsonKey(name: 'pantone_value')
  final String? pantoneValue;

  @override
  String toString() {
    return 'UnknownModelDataEntity(id: $id, name: $name, year: $year, color: $color, pantoneValue: $pantoneValue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnknownModelDataEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.pantoneValue, pantoneValue) ||
                other.pantoneValue == pantoneValue));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, year, color, pantoneValue);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UnknownModelDataEntityImplCopyWith<_$UnknownModelDataEntityImpl>
      get copyWith => __$$UnknownModelDataEntityImplCopyWithImpl<
          _$UnknownModelDataEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UnknownModelDataEntityImplToJson(
      this,
    );
  }
}

abstract class _UnknownModelDataEntity implements UnknownModelDataEntity {
  const factory _UnknownModelDataEntity(
          {final int? id,
          final String? name,
          final int? year,
          final String? color,
          @JsonKey(name: 'pantone_value') final String? pantoneValue}) =
      _$UnknownModelDataEntityImpl;

  factory _UnknownModelDataEntity.fromJson(Map<String, dynamic> json) =
      _$UnknownModelDataEntityImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  int? get year;
  @override
  String? get color;
  @override
  @JsonKey(name: 'pantone_value')
  String? get pantoneValue;
  @override
  @JsonKey(ignore: true)
  _$$UnknownModelDataEntityImplCopyWith<_$UnknownModelDataEntityImpl>
      get copyWith => throw _privateConstructorUsedError;
}

UnknownModelSupportEntity _$UnknownModelSupportEntityFromJson(
    Map<String, dynamic> json) {
  return _UnknownModelSupportEntity.fromJson(json);
}

/// @nodoc
mixin _$UnknownModelSupportEntity {
  String? get url => throw _privateConstructorUsedError;
  String? get text => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UnknownModelSupportEntityCopyWith<UnknownModelSupportEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UnknownModelSupportEntityCopyWith<$Res> {
  factory $UnknownModelSupportEntityCopyWith(UnknownModelSupportEntity value,
          $Res Function(UnknownModelSupportEntity) then) =
      _$UnknownModelSupportEntityCopyWithImpl<$Res, UnknownModelSupportEntity>;
  @useResult
  $Res call({String? url, String? text});
}

/// @nodoc
class _$UnknownModelSupportEntityCopyWithImpl<$Res,
        $Val extends UnknownModelSupportEntity>
    implements $UnknownModelSupportEntityCopyWith<$Res> {
  _$UnknownModelSupportEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = freezed,
    Object? text = freezed,
  }) {
    return _then(_value.copyWith(
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UnknownModelSupportEntityImplCopyWith<$Res>
    implements $UnknownModelSupportEntityCopyWith<$Res> {
  factory _$$UnknownModelSupportEntityImplCopyWith(
          _$UnknownModelSupportEntityImpl value,
          $Res Function(_$UnknownModelSupportEntityImpl) then) =
      __$$UnknownModelSupportEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? url, String? text});
}

/// @nodoc
class __$$UnknownModelSupportEntityImplCopyWithImpl<$Res>
    extends _$UnknownModelSupportEntityCopyWithImpl<$Res,
        _$UnknownModelSupportEntityImpl>
    implements _$$UnknownModelSupportEntityImplCopyWith<$Res> {
  __$$UnknownModelSupportEntityImplCopyWithImpl(
      _$UnknownModelSupportEntityImpl _value,
      $Res Function(_$UnknownModelSupportEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = freezed,
    Object? text = freezed,
  }) {
    return _then(_$UnknownModelSupportEntityImpl(
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UnknownModelSupportEntityImpl implements _UnknownModelSupportEntity {
  const _$UnknownModelSupportEntityImpl({this.url, this.text});

  factory _$UnknownModelSupportEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$UnknownModelSupportEntityImplFromJson(json);

  @override
  final String? url;
  @override
  final String? text;

  @override
  String toString() {
    return 'UnknownModelSupportEntity(url: $url, text: $text)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnknownModelSupportEntityImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.text, text) || other.text == text));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, url, text);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UnknownModelSupportEntityImplCopyWith<_$UnknownModelSupportEntityImpl>
      get copyWith => __$$UnknownModelSupportEntityImplCopyWithImpl<
          _$UnknownModelSupportEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UnknownModelSupportEntityImplToJson(
      this,
    );
  }
}

abstract class _UnknownModelSupportEntity implements UnknownModelSupportEntity {
  const factory _UnknownModelSupportEntity(
      {final String? url,
      final String? text}) = _$UnknownModelSupportEntityImpl;

  factory _UnknownModelSupportEntity.fromJson(Map<String, dynamic> json) =
      _$UnknownModelSupportEntityImpl.fromJson;

  @override
  String? get url;
  @override
  String? get text;
  @override
  @JsonKey(ignore: true)
  _$$UnknownModelSupportEntityImplCopyWith<_$UnknownModelSupportEntityImpl>
      get copyWith => throw _privateConstructorUsedError;
}
