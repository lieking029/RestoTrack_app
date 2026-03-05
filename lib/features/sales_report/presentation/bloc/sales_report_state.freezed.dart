// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sales_report_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SalesReportState {
  List<OrderModel> get orders => throw _privateConstructorUsedError;
  SalesReportStateStatus get status => throw _privateConstructorUsedError;
  SalesReportFilterType get filterType => throw _privateConstructorUsedError;
  DateTime? get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of SalesReportState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SalesReportStateCopyWith<SalesReportState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SalesReportStateCopyWith<$Res> {
  factory $SalesReportStateCopyWith(
          SalesReportState value, $Res Function(SalesReportState) then) =
      _$SalesReportStateCopyWithImpl<$Res, SalesReportState>;
  @useResult
  $Res call(
      {List<OrderModel> orders,
      SalesReportStateStatus status,
      SalesReportFilterType filterType,
      DateTime? startDate,
      DateTime? endDate,
      String? errorMessage});
}

/// @nodoc
class _$SalesReportStateCopyWithImpl<$Res, $Val extends SalesReportState>
    implements $SalesReportStateCopyWith<$Res> {
  _$SalesReportStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SalesReportState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orders = null,
    Object? status = null,
    Object? filterType = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      orders: null == orders
          ? _value.orders
          : orders // ignore: cast_nullable_to_non_nullable
              as List<OrderModel>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SalesReportStateStatus,
      filterType: null == filterType
          ? _value.filterType
          : filterType // ignore: cast_nullable_to_non_nullable
              as SalesReportFilterType,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SalesReportStateImplCopyWith<$Res>
    implements $SalesReportStateCopyWith<$Res> {
  factory _$$SalesReportStateImplCopyWith(_$SalesReportStateImpl value,
          $Res Function(_$SalesReportStateImpl) then) =
      __$$SalesReportStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<OrderModel> orders,
      SalesReportStateStatus status,
      SalesReportFilterType filterType,
      DateTime? startDate,
      DateTime? endDate,
      String? errorMessage});
}

/// @nodoc
class __$$SalesReportStateImplCopyWithImpl<$Res>
    extends _$SalesReportStateCopyWithImpl<$Res, _$SalesReportStateImpl>
    implements _$$SalesReportStateImplCopyWith<$Res> {
  __$$SalesReportStateImplCopyWithImpl(_$SalesReportStateImpl _value,
      $Res Function(_$SalesReportStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SalesReportState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orders = null,
    Object? status = null,
    Object? filterType = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_$SalesReportStateImpl(
      orders: null == orders
          ? _value._orders
          : orders // ignore: cast_nullable_to_non_nullable
              as List<OrderModel>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SalesReportStateStatus,
      filterType: null == filterType
          ? _value.filterType
          : filterType // ignore: cast_nullable_to_non_nullable
              as SalesReportFilterType,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SalesReportStateImpl extends _SalesReportState {
  const _$SalesReportStateImpl(
      {final List<OrderModel> orders = const [],
      this.status = SalesReportStateStatus.initial,
      this.filterType = SalesReportFilterType.today,
      this.startDate,
      this.endDate,
      this.errorMessage})
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
  final SalesReportStateStatus status;
  @override
  @JsonKey()
  final SalesReportFilterType filterType;
  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'SalesReportState(orders: $orders, status: $status, filterType: $filterType, startDate: $startDate, endDate: $endDate, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SalesReportStateImpl &&
            const DeepCollectionEquality().equals(other._orders, _orders) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.filterType, filterType) ||
                other.filterType == filterType) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_orders),
      status,
      filterType,
      startDate,
      endDate,
      errorMessage);

  /// Create a copy of SalesReportState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SalesReportStateImplCopyWith<_$SalesReportStateImpl> get copyWith =>
      __$$SalesReportStateImplCopyWithImpl<_$SalesReportStateImpl>(
          this, _$identity);
}

abstract class _SalesReportState extends SalesReportState {
  const factory _SalesReportState(
      {final List<OrderModel> orders,
      final SalesReportStateStatus status,
      final SalesReportFilterType filterType,
      final DateTime? startDate,
      final DateTime? endDate,
      final String? errorMessage}) = _$SalesReportStateImpl;
  const _SalesReportState._() : super._();

  @override
  List<OrderModel> get orders;
  @override
  SalesReportStateStatus get status;
  @override
  SalesReportFilterType get filterType;
  @override
  DateTime? get startDate;
  @override
  DateTime? get endDate;
  @override
  String? get errorMessage;

  /// Create a copy of SalesReportState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SalesReportStateImplCopyWith<_$SalesReportStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
