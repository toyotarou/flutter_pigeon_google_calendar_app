// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_param.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AppParamState {
  String get selectedStartDate => throw _privateConstructorUsedError;
  String get selectedStartTime => throw _privateConstructorUsedError;
  String get selectedEndDate => throw _privateConstructorUsedError;
  String get selectedEndTime => throw _privateConstructorUsedError;

  /// Create a copy of AppParamState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppParamStateCopyWith<AppParamState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppParamStateCopyWith<$Res> {
  factory $AppParamStateCopyWith(
    AppParamState value,
    $Res Function(AppParamState) then,
  ) = _$AppParamStateCopyWithImpl<$Res, AppParamState>;
  @useResult
  $Res call({
    String selectedStartDate,
    String selectedStartTime,
    String selectedEndDate,
    String selectedEndTime,
  });
}

/// @nodoc
class _$AppParamStateCopyWithImpl<$Res, $Val extends AppParamState>
    implements $AppParamStateCopyWith<$Res> {
  _$AppParamStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppParamState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedStartDate = null,
    Object? selectedStartTime = null,
    Object? selectedEndDate = null,
    Object? selectedEndTime = null,
  }) {
    return _then(
      _value.copyWith(
            selectedStartDate: null == selectedStartDate
                ? _value.selectedStartDate
                : selectedStartDate // ignore: cast_nullable_to_non_nullable
                      as String,
            selectedStartTime: null == selectedStartTime
                ? _value.selectedStartTime
                : selectedStartTime // ignore: cast_nullable_to_non_nullable
                      as String,
            selectedEndDate: null == selectedEndDate
                ? _value.selectedEndDate
                : selectedEndDate // ignore: cast_nullable_to_non_nullable
                      as String,
            selectedEndTime: null == selectedEndTime
                ? _value.selectedEndTime
                : selectedEndTime // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AppParamStateImplCopyWith<$Res>
    implements $AppParamStateCopyWith<$Res> {
  factory _$$AppParamStateImplCopyWith(
    _$AppParamStateImpl value,
    $Res Function(_$AppParamStateImpl) then,
  ) = __$$AppParamStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String selectedStartDate,
    String selectedStartTime,
    String selectedEndDate,
    String selectedEndTime,
  });
}

/// @nodoc
class __$$AppParamStateImplCopyWithImpl<$Res>
    extends _$AppParamStateCopyWithImpl<$Res, _$AppParamStateImpl>
    implements _$$AppParamStateImplCopyWith<$Res> {
  __$$AppParamStateImplCopyWithImpl(
    _$AppParamStateImpl _value,
    $Res Function(_$AppParamStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppParamState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedStartDate = null,
    Object? selectedStartTime = null,
    Object? selectedEndDate = null,
    Object? selectedEndTime = null,
  }) {
    return _then(
      _$AppParamStateImpl(
        selectedStartDate: null == selectedStartDate
            ? _value.selectedStartDate
            : selectedStartDate // ignore: cast_nullable_to_non_nullable
                  as String,
        selectedStartTime: null == selectedStartTime
            ? _value.selectedStartTime
            : selectedStartTime // ignore: cast_nullable_to_non_nullable
                  as String,
        selectedEndDate: null == selectedEndDate
            ? _value.selectedEndDate
            : selectedEndDate // ignore: cast_nullable_to_non_nullable
                  as String,
        selectedEndTime: null == selectedEndTime
            ? _value.selectedEndTime
            : selectedEndTime // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$AppParamStateImpl implements _AppParamState {
  const _$AppParamStateImpl({
    this.selectedStartDate = '',
    this.selectedStartTime = '',
    this.selectedEndDate = '',
    this.selectedEndTime = '',
  });

  @override
  @JsonKey()
  final String selectedStartDate;
  @override
  @JsonKey()
  final String selectedStartTime;
  @override
  @JsonKey()
  final String selectedEndDate;
  @override
  @JsonKey()
  final String selectedEndTime;

  @override
  String toString() {
    return 'AppParamState(selectedStartDate: $selectedStartDate, selectedStartTime: $selectedStartTime, selectedEndDate: $selectedEndDate, selectedEndTime: $selectedEndTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppParamStateImpl &&
            (identical(other.selectedStartDate, selectedStartDate) ||
                other.selectedStartDate == selectedStartDate) &&
            (identical(other.selectedStartTime, selectedStartTime) ||
                other.selectedStartTime == selectedStartTime) &&
            (identical(other.selectedEndDate, selectedEndDate) ||
                other.selectedEndDate == selectedEndDate) &&
            (identical(other.selectedEndTime, selectedEndTime) ||
                other.selectedEndTime == selectedEndTime));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    selectedStartDate,
    selectedStartTime,
    selectedEndDate,
    selectedEndTime,
  );

  /// Create a copy of AppParamState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppParamStateImplCopyWith<_$AppParamStateImpl> get copyWith =>
      __$$AppParamStateImplCopyWithImpl<_$AppParamStateImpl>(this, _$identity);
}

abstract class _AppParamState implements AppParamState {
  const factory _AppParamState({
    final String selectedStartDate,
    final String selectedStartTime,
    final String selectedEndDate,
    final String selectedEndTime,
  }) = _$AppParamStateImpl;

  @override
  String get selectedStartDate;
  @override
  String get selectedStartTime;
  @override
  String get selectedEndDate;
  @override
  String get selectedEndTime;

  /// Create a copy of AppParamState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppParamStateImplCopyWith<_$AppParamStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
