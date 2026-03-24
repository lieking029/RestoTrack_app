// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cashier_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CashierState {
  List<OrderModel> get orders => throw _privateConstructorUsedError;
  CashierStateStatus get status => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  bool get isProcessingPayment => throw _privateConstructorUsedError;
  String? get processingOrderId => throw _privateConstructorUsedError;
  CashierStats? get stats => throw _privateConstructorUsedError;
  OrderModel? get lastCompletedOrder => throw _privateConstructorUsedError;
  String? get checkoutUrl => throw _privateConstructorUsedError;
  String? get checkoutSessionId => throw _privateConstructorUsedError;
  bool get isPollingPayment => throw _privateConstructorUsedError;
  String? get onlinePaymentOrderId => throw _privateConstructorUsedError;

  /// Create a copy of CashierState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CashierStateCopyWith<CashierState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CashierStateCopyWith<$Res> {
  factory $CashierStateCopyWith(
          CashierState value, $Res Function(CashierState) then) =
      _$CashierStateCopyWithImpl<$Res, CashierState>;
  @useResult
  $Res call(
      {List<OrderModel> orders,
      CashierStateStatus status,
      String? errorMessage,
      bool isProcessingPayment,
      String? processingOrderId,
      CashierStats? stats,
      OrderModel? lastCompletedOrder,
      String? checkoutUrl,
      String? checkoutSessionId,
      bool isPollingPayment,
      String? onlinePaymentOrderId});

  $OrderModelCopyWith<$Res>? get lastCompletedOrder;
}

/// @nodoc
class _$CashierStateCopyWithImpl<$Res, $Val extends CashierState>
    implements $CashierStateCopyWith<$Res> {
  _$CashierStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CashierState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orders = null,
    Object? status = null,
    Object? errorMessage = freezed,
    Object? isProcessingPayment = null,
    Object? processingOrderId = freezed,
    Object? stats = freezed,
    Object? lastCompletedOrder = freezed,
    Object? checkoutUrl = freezed,
    Object? checkoutSessionId = freezed,
    Object? isPollingPayment = null,
    Object? onlinePaymentOrderId = freezed,
  }) {
    return _then(_value.copyWith(
      orders: null == orders
          ? _value.orders
          : orders // ignore: cast_nullable_to_non_nullable
              as List<OrderModel>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CashierStateStatus,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      isProcessingPayment: null == isProcessingPayment
          ? _value.isProcessingPayment
          : isProcessingPayment // ignore: cast_nullable_to_non_nullable
              as bool,
      processingOrderId: freezed == processingOrderId
          ? _value.processingOrderId
          : processingOrderId // ignore: cast_nullable_to_non_nullable
              as String?,
      stats: freezed == stats
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as CashierStats?,
      lastCompletedOrder: freezed == lastCompletedOrder
          ? _value.lastCompletedOrder
          : lastCompletedOrder // ignore: cast_nullable_to_non_nullable
              as OrderModel?,
      checkoutUrl: freezed == checkoutUrl
          ? _value.checkoutUrl
          : checkoutUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      checkoutSessionId: freezed == checkoutSessionId
          ? _value.checkoutSessionId
          : checkoutSessionId // ignore: cast_nullable_to_non_nullable
              as String?,
      isPollingPayment: null == isPollingPayment
          ? _value.isPollingPayment
          : isPollingPayment // ignore: cast_nullable_to_non_nullable
              as bool,
      onlinePaymentOrderId: freezed == onlinePaymentOrderId
          ? _value.onlinePaymentOrderId
          : onlinePaymentOrderId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of CashierState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OrderModelCopyWith<$Res>? get lastCompletedOrder {
    if (_value.lastCompletedOrder == null) {
      return null;
    }

    return $OrderModelCopyWith<$Res>(_value.lastCompletedOrder!, (value) {
      return _then(_value.copyWith(lastCompletedOrder: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CashierStateImplCopyWith<$Res>
    implements $CashierStateCopyWith<$Res> {
  factory _$$CashierStateImplCopyWith(
          _$CashierStateImpl value, $Res Function(_$CashierStateImpl) then) =
      __$$CashierStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<OrderModel> orders,
      CashierStateStatus status,
      String? errorMessage,
      bool isProcessingPayment,
      String? processingOrderId,
      CashierStats? stats,
      OrderModel? lastCompletedOrder,
      String? checkoutUrl,
      String? checkoutSessionId,
      bool isPollingPayment,
      String? onlinePaymentOrderId});

  @override
  $OrderModelCopyWith<$Res>? get lastCompletedOrder;
}

/// @nodoc
class __$$CashierStateImplCopyWithImpl<$Res>
    extends _$CashierStateCopyWithImpl<$Res, _$CashierStateImpl>
    implements _$$CashierStateImplCopyWith<$Res> {
  __$$CashierStateImplCopyWithImpl(
      _$CashierStateImpl _value, $Res Function(_$CashierStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CashierState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orders = null,
    Object? status = null,
    Object? errorMessage = freezed,
    Object? isProcessingPayment = null,
    Object? processingOrderId = freezed,
    Object? stats = freezed,
    Object? lastCompletedOrder = freezed,
    Object? checkoutUrl = freezed,
    Object? checkoutSessionId = freezed,
    Object? isPollingPayment = null,
    Object? onlinePaymentOrderId = freezed,
  }) {
    return _then(_$CashierStateImpl(
      orders: null == orders
          ? _value._orders
          : orders // ignore: cast_nullable_to_non_nullable
              as List<OrderModel>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CashierStateStatus,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      isProcessingPayment: null == isProcessingPayment
          ? _value.isProcessingPayment
          : isProcessingPayment // ignore: cast_nullable_to_non_nullable
              as bool,
      processingOrderId: freezed == processingOrderId
          ? _value.processingOrderId
          : processingOrderId // ignore: cast_nullable_to_non_nullable
              as String?,
      stats: freezed == stats
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as CashierStats?,
      lastCompletedOrder: freezed == lastCompletedOrder
          ? _value.lastCompletedOrder
          : lastCompletedOrder // ignore: cast_nullable_to_non_nullable
              as OrderModel?,
      checkoutUrl: freezed == checkoutUrl
          ? _value.checkoutUrl
          : checkoutUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      checkoutSessionId: freezed == checkoutSessionId
          ? _value.checkoutSessionId
          : checkoutSessionId // ignore: cast_nullable_to_non_nullable
              as String?,
      isPollingPayment: null == isPollingPayment
          ? _value.isPollingPayment
          : isPollingPayment // ignore: cast_nullable_to_non_nullable
              as bool,
      onlinePaymentOrderId: freezed == onlinePaymentOrderId
          ? _value.onlinePaymentOrderId
          : onlinePaymentOrderId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$CashierStateImpl extends _CashierState {
  const _$CashierStateImpl(
      {final List<OrderModel> orders = const [],
      this.status = CashierStateStatus.initial,
      this.errorMessage,
      this.isProcessingPayment = false,
      this.processingOrderId,
      this.stats,
      this.lastCompletedOrder,
      this.checkoutUrl,
      this.checkoutSessionId,
      this.isPollingPayment = false,
      this.onlinePaymentOrderId})
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
  final CashierStateStatus status;
  @override
  final String? errorMessage;
  @override
  @JsonKey()
  final bool isProcessingPayment;
  @override
  final String? processingOrderId;
  @override
  final CashierStats? stats;
  @override
  final OrderModel? lastCompletedOrder;
  @override
  final String? checkoutUrl;
  @override
  final String? checkoutSessionId;
  @override
  @JsonKey()
  final bool isPollingPayment;
  @override
  final String? onlinePaymentOrderId;

  @override
  String toString() {
    return 'CashierState(orders: $orders, status: $status, errorMessage: $errorMessage, isProcessingPayment: $isProcessingPayment, processingOrderId: $processingOrderId, stats: $stats, lastCompletedOrder: $lastCompletedOrder, checkoutUrl: $checkoutUrl, checkoutSessionId: $checkoutSessionId, isPollingPayment: $isPollingPayment, onlinePaymentOrderId: $onlinePaymentOrderId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CashierStateImpl &&
            const DeepCollectionEquality().equals(other._orders, _orders) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.isProcessingPayment, isProcessingPayment) ||
                other.isProcessingPayment == isProcessingPayment) &&
            (identical(other.processingOrderId, processingOrderId) ||
                other.processingOrderId == processingOrderId) &&
            (identical(other.stats, stats) || other.stats == stats) &&
            (identical(other.lastCompletedOrder, lastCompletedOrder) ||
                other.lastCompletedOrder == lastCompletedOrder) &&
            (identical(other.checkoutUrl, checkoutUrl) ||
                other.checkoutUrl == checkoutUrl) &&
            (identical(other.checkoutSessionId, checkoutSessionId) ||
                other.checkoutSessionId == checkoutSessionId) &&
            (identical(other.isPollingPayment, isPollingPayment) ||
                other.isPollingPayment == isPollingPayment) &&
            (identical(other.onlinePaymentOrderId, onlinePaymentOrderId) ||
                other.onlinePaymentOrderId == onlinePaymentOrderId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_orders),
      status,
      errorMessage,
      isProcessingPayment,
      processingOrderId,
      stats,
      lastCompletedOrder,
      checkoutUrl,
      checkoutSessionId,
      isPollingPayment,
      onlinePaymentOrderId);

  /// Create a copy of CashierState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CashierStateImplCopyWith<_$CashierStateImpl> get copyWith =>
      __$$CashierStateImplCopyWithImpl<_$CashierStateImpl>(this, _$identity);
}

abstract class _CashierState extends CashierState {
  const factory _CashierState(
      {final List<OrderModel> orders,
      final CashierStateStatus status,
      final String? errorMessage,
      final bool isProcessingPayment,
      final String? processingOrderId,
      final CashierStats? stats,
      final OrderModel? lastCompletedOrder,
      final String? checkoutUrl,
      final String? checkoutSessionId,
      final bool isPollingPayment,
      final String? onlinePaymentOrderId}) = _$CashierStateImpl;
  const _CashierState._() : super._();

  @override
  List<OrderModel> get orders;
  @override
  CashierStateStatus get status;
  @override
  String? get errorMessage;
  @override
  bool get isProcessingPayment;
  @override
  String? get processingOrderId;
  @override
  CashierStats? get stats;
  @override
  OrderModel? get lastCompletedOrder;
  @override
  String? get checkoutUrl;
  @override
  String? get checkoutSessionId;
  @override
  bool get isPollingPayment;
  @override
  String? get onlinePaymentOrderId;

  /// Create a copy of CashierState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CashierStateImplCopyWith<_$CashierStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
