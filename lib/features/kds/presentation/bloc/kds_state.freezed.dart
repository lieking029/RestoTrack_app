// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kds_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$KdsState {
  List<OrderModel> get orders => throw _privateConstructorUsedError;
  KdsStateStatus get status => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  String? get successMessage => throw _privateConstructorUsedError;
  bool get isUpdating => throw _privateConstructorUsedError;
  String? get updatingOrderId => throw _privateConstructorUsedError;

  /// Create a copy of KdsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KdsStateCopyWith<KdsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KdsStateCopyWith<$Res> {
  factory $KdsStateCopyWith(KdsState value, $Res Function(KdsState) then) =
      _$KdsStateCopyWithImpl<$Res, KdsState>;
  @useResult
  $Res call(
      {List<OrderModel> orders,
      KdsStateStatus status,
      String? errorMessage,
      String? successMessage,
      bool isUpdating,
      String? updatingOrderId});
}

/// @nodoc
class _$KdsStateCopyWithImpl<$Res, $Val extends KdsState>
    implements $KdsStateCopyWith<$Res> {
  _$KdsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KdsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orders = null,
    Object? status = null,
    Object? errorMessage = freezed,
    Object? successMessage = freezed,
    Object? isUpdating = null,
    Object? updatingOrderId = freezed,
  }) {
    return _then(_value.copyWith(
      orders: null == orders
          ? _value.orders
          : orders // ignore: cast_nullable_to_non_nullable
              as List<OrderModel>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as KdsStateStatus,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      successMessage: freezed == successMessage
          ? _value.successMessage
          : successMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      isUpdating: null == isUpdating
          ? _value.isUpdating
          : isUpdating // ignore: cast_nullable_to_non_nullable
              as bool,
      updatingOrderId: freezed == updatingOrderId
          ? _value.updatingOrderId
          : updatingOrderId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KdsStateImplCopyWith<$Res>
    implements $KdsStateCopyWith<$Res> {
  factory _$$KdsStateImplCopyWith(
          _$KdsStateImpl value, $Res Function(_$KdsStateImpl) then) =
      __$$KdsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<OrderModel> orders,
      KdsStateStatus status,
      String? errorMessage,
      String? successMessage,
      bool isUpdating,
      String? updatingOrderId});
}

/// @nodoc
class __$$KdsStateImplCopyWithImpl<$Res>
    extends _$KdsStateCopyWithImpl<$Res, _$KdsStateImpl>
    implements _$$KdsStateImplCopyWith<$Res> {
  __$$KdsStateImplCopyWithImpl(
      _$KdsStateImpl _value, $Res Function(_$KdsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of KdsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orders = null,
    Object? status = null,
    Object? errorMessage = freezed,
    Object? successMessage = freezed,
    Object? isUpdating = null,
    Object? updatingOrderId = freezed,
  }) {
    return _then(_$KdsStateImpl(
      orders: null == orders
          ? _value._orders
          : orders // ignore: cast_nullable_to_non_nullable
              as List<OrderModel>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as KdsStateStatus,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      successMessage: freezed == successMessage
          ? _value.successMessage
          : successMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      isUpdating: null == isUpdating
          ? _value.isUpdating
          : isUpdating // ignore: cast_nullable_to_non_nullable
              as bool,
      updatingOrderId: freezed == updatingOrderId
          ? _value.updatingOrderId
          : updatingOrderId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$KdsStateImpl extends _KdsState {
  const _$KdsStateImpl(
      {final List<OrderModel> orders = const [],
      this.status = KdsStateStatus.initial,
      this.errorMessage,
      this.successMessage,
      this.isUpdating = false,
      this.updatingOrderId})
      : _orders = orders,
        super._();

  final List<OrderModel> _orders;
  @override
  @JsonKey()
  List<OrderModel> get orders {
    if (_orders is EqualUnmodifiableListView) return _orders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orders);
  }

  @override
  @JsonKey()
  final KdsStateStatus status;
  @override
  final String? errorMessage;
  @override
  final String? successMessage;
  @override
  @JsonKey()
  final bool isUpdating;
  @override
  final String? updatingOrderId;

  @override
  String toString() {
    return 'KdsState(orders: $orders, status: $status, errorMessage: $errorMessage, successMessage: $successMessage, isUpdating: $isUpdating, updatingOrderId: $updatingOrderId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KdsStateImpl &&
            const DeepCollectionEquality().equals(other._orders, _orders) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.successMessage, successMessage) ||
                other.successMessage == successMessage) &&
            (identical(other.isUpdating, isUpdating) ||
                other.isUpdating == isUpdating) &&
            (identical(other.updatingOrderId, updatingOrderId) ||
                other.updatingOrderId == updatingOrderId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_orders),
      status,
      errorMessage,
      successMessage,
      isUpdating,
      updatingOrderId);

  /// Create a copy of KdsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KdsStateImplCopyWith<_$KdsStateImpl> get copyWith =>
      __$$KdsStateImplCopyWithImpl<_$KdsStateImpl>(this, _$identity);
}

abstract class _KdsState extends KdsState {
  const factory _KdsState(
      {final List<OrderModel> orders,
      final KdsStateStatus status,
      final String? errorMessage,
      final String? successMessage,
      final bool isUpdating,
      final String? updatingOrderId}) = _$KdsStateImpl;
  const _KdsState._() : super._();

  @override
  List<OrderModel> get orders;
  @override
  KdsStateStatus get status;
  @override
  String? get errorMessage;
  @override
  String? get successMessage;
  @override
  bool get isUpdating;
  @override
  String? get updatingOrderId;

  /// Create a copy of KdsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KdsStateImplCopyWith<_$KdsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
