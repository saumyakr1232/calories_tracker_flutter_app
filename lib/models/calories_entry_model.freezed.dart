// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calories_entry_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CaloriesEntryModel {
  int get foodCalories;
  int get exerciseCalories;
  int get targetCalories;
  MacrosModel get macros;

  /// Create a copy of CaloriesEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CaloriesEntryModelCopyWith<CaloriesEntryModel> get copyWith =>
      _$CaloriesEntryModelCopyWithImpl<CaloriesEntryModel>(
          this as CaloriesEntryModel, _$identity);

  /// Serializes this CaloriesEntryModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CaloriesEntryModel &&
            (identical(other.foodCalories, foodCalories) ||
                other.foodCalories == foodCalories) &&
            (identical(other.exerciseCalories, exerciseCalories) ||
                other.exerciseCalories == exerciseCalories) &&
            (identical(other.targetCalories, targetCalories) ||
                other.targetCalories == targetCalories) &&
            (identical(other.macros, macros) || other.macros == macros));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, foodCalories, exerciseCalories, targetCalories, macros);

  @override
  String toString() {
    return 'CaloriesEntryModel(foodCalories: $foodCalories, exerciseCalories: $exerciseCalories, targetCalories: $targetCalories, macros: $macros)';
  }
}

/// @nodoc
abstract mixin class $CaloriesEntryModelCopyWith<$Res> {
  factory $CaloriesEntryModelCopyWith(
          CaloriesEntryModel value, $Res Function(CaloriesEntryModel) _then) =
      _$CaloriesEntryModelCopyWithImpl;
  @useResult
  $Res call(
      {int foodCalories,
      int exerciseCalories,
      int targetCalories,
      MacrosModel macros});

  $MacrosModelCopyWith<$Res> get macros;
}

/// @nodoc
class _$CaloriesEntryModelCopyWithImpl<$Res>
    implements $CaloriesEntryModelCopyWith<$Res> {
  _$CaloriesEntryModelCopyWithImpl(this._self, this._then);

  final CaloriesEntryModel _self;
  final $Res Function(CaloriesEntryModel) _then;

  /// Create a copy of CaloriesEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? foodCalories = null,
    Object? exerciseCalories = null,
    Object? targetCalories = null,
    Object? macros = null,
  }) {
    return _then(_self.copyWith(
      foodCalories: null == foodCalories
          ? _self.foodCalories
          : foodCalories // ignore: cast_nullable_to_non_nullable
              as int,
      exerciseCalories: null == exerciseCalories
          ? _self.exerciseCalories
          : exerciseCalories // ignore: cast_nullable_to_non_nullable
              as int,
      targetCalories: null == targetCalories
          ? _self.targetCalories
          : targetCalories // ignore: cast_nullable_to_non_nullable
              as int,
      macros: null == macros
          ? _self.macros
          : macros // ignore: cast_nullable_to_non_nullable
              as MacrosModel,
    ));
  }

  /// Create a copy of CaloriesEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MacrosModelCopyWith<$Res> get macros {
    return $MacrosModelCopyWith<$Res>(_self.macros, (value) {
      return _then(_self.copyWith(macros: value));
    });
  }
}

/// @nodoc

@JsonSerializable()
class _CaloriesEntryModel implements CaloriesEntryModel {
  const _CaloriesEntryModel(
      {required this.foodCalories,
      required this.exerciseCalories,
      required this.targetCalories,
      required this.macros});
  factory _CaloriesEntryModel.fromJson(Map<String, dynamic> json) =>
      _$CaloriesEntryModelFromJson(json);

  @override
  final int foodCalories;
  @override
  final int exerciseCalories;
  @override
  final int targetCalories;
  @override
  final MacrosModel macros;

  /// Create a copy of CaloriesEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CaloriesEntryModelCopyWith<_CaloriesEntryModel> get copyWith =>
      __$CaloriesEntryModelCopyWithImpl<_CaloriesEntryModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CaloriesEntryModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CaloriesEntryModel &&
            (identical(other.foodCalories, foodCalories) ||
                other.foodCalories == foodCalories) &&
            (identical(other.exerciseCalories, exerciseCalories) ||
                other.exerciseCalories == exerciseCalories) &&
            (identical(other.targetCalories, targetCalories) ||
                other.targetCalories == targetCalories) &&
            (identical(other.macros, macros) || other.macros == macros));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, foodCalories, exerciseCalories, targetCalories, macros);

  @override
  String toString() {
    return 'CaloriesEntryModel(foodCalories: $foodCalories, exerciseCalories: $exerciseCalories, targetCalories: $targetCalories, macros: $macros)';
  }
}

/// @nodoc
abstract mixin class _$CaloriesEntryModelCopyWith<$Res>
    implements $CaloriesEntryModelCopyWith<$Res> {
  factory _$CaloriesEntryModelCopyWith(
          _CaloriesEntryModel value, $Res Function(_CaloriesEntryModel) _then) =
      __$CaloriesEntryModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int foodCalories,
      int exerciseCalories,
      int targetCalories,
      MacrosModel macros});

  @override
  $MacrosModelCopyWith<$Res> get macros;
}

/// @nodoc
class __$CaloriesEntryModelCopyWithImpl<$Res>
    implements _$CaloriesEntryModelCopyWith<$Res> {
  __$CaloriesEntryModelCopyWithImpl(this._self, this._then);

  final _CaloriesEntryModel _self;
  final $Res Function(_CaloriesEntryModel) _then;

  /// Create a copy of CaloriesEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? foodCalories = null,
    Object? exerciseCalories = null,
    Object? targetCalories = null,
    Object? macros = null,
  }) {
    return _then(_CaloriesEntryModel(
      foodCalories: null == foodCalories
          ? _self.foodCalories
          : foodCalories // ignore: cast_nullable_to_non_nullable
              as int,
      exerciseCalories: null == exerciseCalories
          ? _self.exerciseCalories
          : exerciseCalories // ignore: cast_nullable_to_non_nullable
              as int,
      targetCalories: null == targetCalories
          ? _self.targetCalories
          : targetCalories // ignore: cast_nullable_to_non_nullable
              as int,
      macros: null == macros
          ? _self.macros
          : macros // ignore: cast_nullable_to_non_nullable
              as MacrosModel,
    ));
  }

  /// Create a copy of CaloriesEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MacrosModelCopyWith<$Res> get macros {
    return $MacrosModelCopyWith<$Res>(_self.macros, (value) {
      return _then(_self.copyWith(macros: value));
    });
  }
}

/// @nodoc
mixin _$MacrosModel {
  int get consumedCarbs;
  int get targetCarbs;
  int get consumedProtein;
  int get targetProtein;
  int get consumedFat;
  int get targetFat;

  /// Create a copy of MacrosModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MacrosModelCopyWith<MacrosModel> get copyWith =>
      _$MacrosModelCopyWithImpl<MacrosModel>(this as MacrosModel, _$identity);

  /// Serializes this MacrosModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MacrosModel &&
            (identical(other.consumedCarbs, consumedCarbs) ||
                other.consumedCarbs == consumedCarbs) &&
            (identical(other.targetCarbs, targetCarbs) ||
                other.targetCarbs == targetCarbs) &&
            (identical(other.consumedProtein, consumedProtein) ||
                other.consumedProtein == consumedProtein) &&
            (identical(other.targetProtein, targetProtein) ||
                other.targetProtein == targetProtein) &&
            (identical(other.consumedFat, consumedFat) ||
                other.consumedFat == consumedFat) &&
            (identical(other.targetFat, targetFat) ||
                other.targetFat == targetFat));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, consumedCarbs, targetCarbs,
      consumedProtein, targetProtein, consumedFat, targetFat);

  @override
  String toString() {
    return 'MacrosModel(consumedCarbs: $consumedCarbs, targetCarbs: $targetCarbs, consumedProtein: $consumedProtein, targetProtein: $targetProtein, consumedFat: $consumedFat, targetFat: $targetFat)';
  }
}

/// @nodoc
abstract mixin class $MacrosModelCopyWith<$Res> {
  factory $MacrosModelCopyWith(
          MacrosModel value, $Res Function(MacrosModel) _then) =
      _$MacrosModelCopyWithImpl;
  @useResult
  $Res call(
      {int consumedCarbs,
      int targetCarbs,
      int consumedProtein,
      int targetProtein,
      int consumedFat,
      int targetFat});
}

/// @nodoc
class _$MacrosModelCopyWithImpl<$Res> implements $MacrosModelCopyWith<$Res> {
  _$MacrosModelCopyWithImpl(this._self, this._then);

  final MacrosModel _self;
  final $Res Function(MacrosModel) _then;

  /// Create a copy of MacrosModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? consumedCarbs = null,
    Object? targetCarbs = null,
    Object? consumedProtein = null,
    Object? targetProtein = null,
    Object? consumedFat = null,
    Object? targetFat = null,
  }) {
    return _then(_self.copyWith(
      consumedCarbs: null == consumedCarbs
          ? _self.consumedCarbs
          : consumedCarbs // ignore: cast_nullable_to_non_nullable
              as int,
      targetCarbs: null == targetCarbs
          ? _self.targetCarbs
          : targetCarbs // ignore: cast_nullable_to_non_nullable
              as int,
      consumedProtein: null == consumedProtein
          ? _self.consumedProtein
          : consumedProtein // ignore: cast_nullable_to_non_nullable
              as int,
      targetProtein: null == targetProtein
          ? _self.targetProtein
          : targetProtein // ignore: cast_nullable_to_non_nullable
              as int,
      consumedFat: null == consumedFat
          ? _self.consumedFat
          : consumedFat // ignore: cast_nullable_to_non_nullable
              as int,
      targetFat: null == targetFat
          ? _self.targetFat
          : targetFat // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _MacrosModel implements MacrosModel {
  const _MacrosModel(
      {required this.consumedCarbs,
      required this.targetCarbs,
      required this.consumedProtein,
      required this.targetProtein,
      required this.consumedFat,
      required this.targetFat});
  factory _MacrosModel.fromJson(Map<String, dynamic> json) =>
      _$MacrosModelFromJson(json);

  @override
  final int consumedCarbs;
  @override
  final int targetCarbs;
  @override
  final int consumedProtein;
  @override
  final int targetProtein;
  @override
  final int consumedFat;
  @override
  final int targetFat;

  /// Create a copy of MacrosModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MacrosModelCopyWith<_MacrosModel> get copyWith =>
      __$MacrosModelCopyWithImpl<_MacrosModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MacrosModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MacrosModel &&
            (identical(other.consumedCarbs, consumedCarbs) ||
                other.consumedCarbs == consumedCarbs) &&
            (identical(other.targetCarbs, targetCarbs) ||
                other.targetCarbs == targetCarbs) &&
            (identical(other.consumedProtein, consumedProtein) ||
                other.consumedProtein == consumedProtein) &&
            (identical(other.targetProtein, targetProtein) ||
                other.targetProtein == targetProtein) &&
            (identical(other.consumedFat, consumedFat) ||
                other.consumedFat == consumedFat) &&
            (identical(other.targetFat, targetFat) ||
                other.targetFat == targetFat));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, consumedCarbs, targetCarbs,
      consumedProtein, targetProtein, consumedFat, targetFat);

  @override
  String toString() {
    return 'MacrosModel(consumedCarbs: $consumedCarbs, targetCarbs: $targetCarbs, consumedProtein: $consumedProtein, targetProtein: $targetProtein, consumedFat: $consumedFat, targetFat: $targetFat)';
  }
}

/// @nodoc
abstract mixin class _$MacrosModelCopyWith<$Res>
    implements $MacrosModelCopyWith<$Res> {
  factory _$MacrosModelCopyWith(
          _MacrosModel value, $Res Function(_MacrosModel) _then) =
      __$MacrosModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int consumedCarbs,
      int targetCarbs,
      int consumedProtein,
      int targetProtein,
      int consumedFat,
      int targetFat});
}

/// @nodoc
class __$MacrosModelCopyWithImpl<$Res> implements _$MacrosModelCopyWith<$Res> {
  __$MacrosModelCopyWithImpl(this._self, this._then);

  final _MacrosModel _self;
  final $Res Function(_MacrosModel) _then;

  /// Create a copy of MacrosModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? consumedCarbs = null,
    Object? targetCarbs = null,
    Object? consumedProtein = null,
    Object? targetProtein = null,
    Object? consumedFat = null,
    Object? targetFat = null,
  }) {
    return _then(_MacrosModel(
      consumedCarbs: null == consumedCarbs
          ? _self.consumedCarbs
          : consumedCarbs // ignore: cast_nullable_to_non_nullable
              as int,
      targetCarbs: null == targetCarbs
          ? _self.targetCarbs
          : targetCarbs // ignore: cast_nullable_to_non_nullable
              as int,
      consumedProtein: null == consumedProtein
          ? _self.consumedProtein
          : consumedProtein // ignore: cast_nullable_to_non_nullable
              as int,
      targetProtein: null == targetProtein
          ? _self.targetProtein
          : targetProtein // ignore: cast_nullable_to_non_nullable
              as int,
      consumedFat: null == consumedFat
          ? _self.consumedFat
          : consumedFat // ignore: cast_nullable_to_non_nullable
              as int,
      targetFat: null == targetFat
          ? _self.targetFat
          : targetFat // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
