// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CartState {
  CartModel get cart => throw _privateConstructorUsedError;
  CartStatus get status => throw _privateConstructorUsedError;
  OrderModel? get submittedOrder => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  String? get editingOrderId => throw _privateConstructorUsedError;

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CartStateCopyWith<CartState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartStateCopyWith<$Res> {
  factory $CartStateCopyWith(CartState value, $Res Function(CartState) then) =
      _$CartStateCopyWithImpl<$Res, CartState>;
  @useResult
  $Res call(
      {CartModel cart,
      CartStatus status,
      OrderModel? submittedOrder,
      String? errorMessage,
      String? editingOrderId});

  $CartModelCopyWith<$Res> get cart;
  $OrderModelCopyWith<$Res>? get submittedOrder;
}

/// @nodoc
class _$CartStateCopyWithImpl<$Res, $Val extends CartState>
    implements $CartStateCopyWith<$Res> {
  _$CartStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cart = null,
    Object? status = null,
    Object? submittedOrder = freezed,
    Object? errorMessage = freezed,
    Object? editingOrderId = freezed,
  }) {
    return _then(_value.copyWith(
      cart: null == cart
          ? _value.cart
          : cart // ignore: cast_nullable_to_non_nullable
              as CartModel,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CartStatus,
      submittedOrder: freezed == submittedOrder
          ? _value.submittedOrder
          : submittedOrder // ignore: cast_nullable_to_non_nullable
              as OrderModel?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      editingOrderId: freezed == editingOrderId
          ? _value.editingOrderId
          : editingOrderId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CartModelCopyWith<$Res> get cart {
    return $CartModelCopyWith<$Res>(_value.cart, (value) {
      return _then(_value.copyWith(cart: value) as $Val);
    });
  }

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OrderModelCopyWith<$Res>? get submittedOrder {
    if (_value.submittedOrder == null) {
      return null;
    }

    return $OrderModelCopyWith<$Res>(_value.submittedOrder!, (value) {
      return _then(_value.copyWith(submittedOrder: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CartStateImplCopyWith<$Res>
    implements $CartStateCopyWith<$Res> {
  factory _$$CartStateImplCopyWith(
          _$CartStateImpl value, $Res Function(_$CartStateImpl) then) =
      __$$CartStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {CartModel cart,
      CartStatus status,
      OrderModel? submittedOrder,
      String? errorMessage,
      String? editingOrderId});

  @override
  $CartModelCopyWith<$Res> get cart;
  @override
  $OrderModelCopyWith<$Res>? get submittedOrder;
}

/// @nodoc
class __$$CartStateImplCopyWithImpl<$Res>
    extends _$CartStateCopyWithImpl<$Res, _$CartStateImpl>
    implements _$$CartStateImplCopyWith<$Res> {
  __$$CartStateImplCopyWithImpl(
      _$CartStateImpl _value, $Res Function(_$CartStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cart = null,
    Object? status = null,
    Object? submittedOrder = freezed,
    Object? errorMessage = freezed,
    Object? editingOrderId = freezed,
  }) {
    return _then(_$CartStateImpl(
      cart: null == cart
          ? _value.cart
          : cart // ignore: cast_nullable_to_non_nullable
              as CartModel,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CartStatus,
      submittedOrder: freezed == submittedOrder
          ? _value.submittedOrder
          : submittedOrder // ignore: cast_nullable_to_non_nullable
              as OrderModel?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      editingOrderId: freezed == editingOrderId
          ? _value.editingOrderId
          : editingOrderId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$CartStateImpl extends _CartState {
  const _$CartStateImpl(
      {this.cart = const CartModel(),
      this.status = CartStatus.initial,
      this.submittedOrder,
      this.errorMessage,
      this.editingOrderId})
      : super._();

  @override
  @JsonKey()
  final CartModel cart;
  @override
  @JsonKey()
  final CartStatus status;
  @override
  final OrderModel? submittedOrder;
  @override
  final String? errorMessage;
  @override
  final String? editingOrderId;

  @override
  String toString() {
    return 'CartState(cart: $cart, status: $status, submittedOrder: $submittedOrder, errorMessage: $errorMessage, editingOrderId: $editingOrderId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CartStateImpl &&
            (identical(other.cart, cart) || other.cart == cart) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.submittedOrder, submittedOrder) ||
                other.submittedOrder == submittedOrder) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.editingOrderId, editingOrderId) ||
                other.editingOrderId == editingOrderId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, cart, status, submittedOrder, errorMessage, editingOrderId);

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CartStateImplCopyWith<_$CartStateImpl> get copyWith =>
      __$$CartStateImplCopyWithImpl<_$CartStateImpl>(this, _$identity);
}

abstract class _CartState extends CartState {
  const factory _CartState(
      {final CartModel cart,
      final CartStatus status,
      final OrderModel? submittedOrder,
      final String? errorMessage,
      final String? editingOrderId}) = _$CartStateImpl;
  const _CartState._() : super._();

  @override
  CartModel get cart;
  @override
  CartStatus get status;
  @override
  OrderModel? get submittedOrder;
  @override
  String? get errorMessage;
  @override
  String? get editingOrderId;

  /// Create a copy of CartState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CartStateImplCopyWith<_$CartStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
