// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_message_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatMessageModel {
  String get id;
  MessageType get type;
  String get content;
  bool get isUser;
  DateTime get timestamp;
  FoodAnalysis? get analysis;
  String? get imagePath;

  /// Create a copy of ChatMessageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ChatMessageModelCopyWith<ChatMessageModel> get copyWith =>
      _$ChatMessageModelCopyWithImpl<ChatMessageModel>(
          this as ChatMessageModel, _$identity);

  /// Serializes this ChatMessageModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChatMessageModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.isUser, isUser) || other.isUser == isUser) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.analysis, analysis) ||
                other.analysis == analysis) &&
            (identical(other.imagePath, imagePath) ||
                other.imagePath == imagePath));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, type, content, isUser, timestamp, analysis, imagePath);

  @override
  String toString() {
    return 'ChatMessageModel(id: $id, type: $type, content: $content, isUser: $isUser, timestamp: $timestamp, analysis: $analysis, imagePath: $imagePath)';
  }
}

/// @nodoc
abstract mixin class $ChatMessageModelCopyWith<$Res> {
  factory $ChatMessageModelCopyWith(
          ChatMessageModel value, $Res Function(ChatMessageModel) _then) =
      _$ChatMessageModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      MessageType type,
      String content,
      bool isUser,
      DateTime timestamp,
      FoodAnalysis? analysis,
      String? imagePath});
}

/// @nodoc
class _$ChatMessageModelCopyWithImpl<$Res>
    implements $ChatMessageModelCopyWith<$Res> {
  _$ChatMessageModelCopyWithImpl(this._self, this._then);

  final ChatMessageModel _self;
  final $Res Function(ChatMessageModel) _then;

  /// Create a copy of ChatMessageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? content = null,
    Object? isUser = null,
    Object? timestamp = null,
    Object? analysis = freezed,
    Object? imagePath = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as MessageType,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      isUser: null == isUser
          ? _self.isUser
          : isUser // ignore: cast_nullable_to_non_nullable
              as bool,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      analysis: freezed == analysis
          ? _self.analysis
          : analysis // ignore: cast_nullable_to_non_nullable
              as FoodAnalysis?,
      imagePath: freezed == imagePath
          ? _self.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ChatMessageModel implements ChatMessageModel {
  const _ChatMessageModel(
      {required this.id,
      required this.type,
      required this.content,
      required this.isUser,
      required this.timestamp,
      this.analysis,
      this.imagePath});
  factory _ChatMessageModel.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageModelFromJson(json);

  @override
  final String id;
  @override
  final MessageType type;
  @override
  final String content;
  @override
  final bool isUser;
  @override
  final DateTime timestamp;
  @override
  final FoodAnalysis? analysis;
  @override
  final String? imagePath;

  /// Create a copy of ChatMessageModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ChatMessageModelCopyWith<_ChatMessageModel> get copyWith =>
      __$ChatMessageModelCopyWithImpl<_ChatMessageModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ChatMessageModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ChatMessageModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.isUser, isUser) || other.isUser == isUser) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.analysis, analysis) ||
                other.analysis == analysis) &&
            (identical(other.imagePath, imagePath) ||
                other.imagePath == imagePath));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, type, content, isUser, timestamp, analysis, imagePath);

  @override
  String toString() {
    return 'ChatMessageModel(id: $id, type: $type, content: $content, isUser: $isUser, timestamp: $timestamp, analysis: $analysis, imagePath: $imagePath)';
  }
}

/// @nodoc
abstract mixin class _$ChatMessageModelCopyWith<$Res>
    implements $ChatMessageModelCopyWith<$Res> {
  factory _$ChatMessageModelCopyWith(
          _ChatMessageModel value, $Res Function(_ChatMessageModel) _then) =
      __$ChatMessageModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      MessageType type,
      String content,
      bool isUser,
      DateTime timestamp,
      FoodAnalysis? analysis,
      String? imagePath});
}

/// @nodoc
class __$ChatMessageModelCopyWithImpl<$Res>
    implements _$ChatMessageModelCopyWith<$Res> {
  __$ChatMessageModelCopyWithImpl(this._self, this._then);

  final _ChatMessageModel _self;
  final $Res Function(_ChatMessageModel) _then;

  /// Create a copy of ChatMessageModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? content = null,
    Object? isUser = null,
    Object? timestamp = null,
    Object? analysis = freezed,
    Object? imagePath = freezed,
  }) {
    return _then(_ChatMessageModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as MessageType,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      isUser: null == isUser
          ? _self.isUser
          : isUser // ignore: cast_nullable_to_non_nullable
              as bool,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      analysis: freezed == analysis
          ? _self.analysis
          : analysis // ignore: cast_nullable_to_non_nullable
              as FoodAnalysis?,
      imagePath: freezed == imagePath
          ? _self.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
