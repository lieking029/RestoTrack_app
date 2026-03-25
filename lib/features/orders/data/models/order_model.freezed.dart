// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) {
  return _OrderModel.fromJson(json);
}

/// @nodoc
mixin _$OrderModel {
  String get id => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError;
  String? get processedBy => throw _privateConstructorUsedError;
  OrderStatus get status => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _toDouble)
  double get subtotal => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _toDouble)
  double get tax => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _toDouble)
  double get total => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  List<OrderItemModel> get items => throw _privateConstructorUsedError;
  UserSummary? get creator => throw _privateConstructorUsedError;
  UserSummary? get processor => throw _privateConstructorUsedError;
  String? get discountType => throw _privateConstructorUsedError;
  String? get customerName => throw _privateConstructorUsedError;
  String? get idNumber => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _toDouble)
  double get discountAmount => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _toDouble)
  double get discountTotal => throw _privateConstructorUsedError;

  /// Serializes this OrderModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderModelCopyWith<OrderModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderModelCopyWith<$Res> {
  factory $OrderModelCopyWith(
          OrderModel value, $Res Function(OrderModel) then) =
      _$OrderModelCopyWithImpl<$Res, OrderModel>;
  @useResult
  $Res call(
      {String id,
      String createdBy,
      String? processedBy,
      OrderStatus status,
      @JsonKey(fromJson: _toDouble) double subtotal,
      @JsonKey(fromJson: _toDouble) double tax,
      @JsonKey(fromJson: _toDouble) double total,
      DateTime? createdAt,
      DateTime? updatedAt,
      List<OrderItemModel> items,
      UserSummary? creator,
      UserSummary? processor,
      String? discountType,
      String? customerName,
      String? idNumber,
      @JsonKey(fromJson: _toDouble) double discountAmount,
      @JsonKey(fromJson: _toDouble) double discountTotal});

  $UserSummaryCopyWith<$Res>? get creator;
  $UserSummaryCopyWith<$Res>? get processor;
}

/// @nodoc
class _$OrderModelCopyWithImpl<$Res, $Val extends OrderModel>
    implements $OrderModelCopyWith<$Res> {
  _$OrderModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdBy = null,
    Object? processedBy = freezed,
    Object? status = null,
    Object? subtotal = null,
    Object? tax = null,
    Object? total = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? items = null,
    Object? creator = freezed,
    Object? processor = freezed,
    Object? discountType = freezed,
    Object? customerName = freezed,
    Object? idNumber = freezed,
    Object? discountAmount = null,
    Object? discountTotal = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      processedBy: freezed == processedBy
          ? _value.processedBy
          : processedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OrderStatus,
      subtotal: null == subtotal
          ? _value.subtotal
          : subtotal // ignore: cast_nullable_to_non_nullable
              as double,
      tax: null == tax
          ? _value.tax
          : tax // ignore: cast_nullable_to_non_nullable
              as double,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<OrderItemModel>,
      creator: freezed == creator
          ? _value.creator
          : creator // ignore: cast_nullable_to_non_nullable
              as UserSummary?,
      processor: freezed == processor
          ? _value.processor
          : processor // ignore: cast_nullable_to_non_nullable
              as UserSummary?,
      discountType: freezed == discountType
          ? _value.discountType
          : discountType // ignore: cast_nullable_to_non_nullable
              as String?,
      customerName: freezed == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String?,
      idNumber: freezed == idNumber
          ? _value.idNumber
          : idNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      discountAmount: null == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as double,
      discountTotal: null == discountTotal
          ? _value.discountTotal
          : discountTotal // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }

  /// Create a copy of OrderModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserSummaryCopyWith<$Res>? get creator {
    if (_value.creator == null) {
      return null;
    }

    return $UserSummaryCopyWith<$Res>(_value.creator!, (value) {
      return _then(_value.copyWith(creator: value) as $Val);
    });
  }

  /// Create a copy of OrderModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserSummaryCopyWith<$Res>? get processor {
    if (_value.processor == null) {
      return null;
    }

    return $UserSummaryCopyWith<$Res>(_value.processor!, (value) {
      return _then(_value.copyWith(processor: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OrderModelImplCopyWith<$Res>
    implements $OrderModelCopyWith<$Res> {
  factory _$$OrderModelImplCopyWith(
          _$OrderModelImpl value, $Res Function(_$OrderModelImpl) then) =
      __$$OrderModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String createdBy,
      String? processedBy,
      OrderStatus status,
      @JsonKey(fromJson: _toDouble) double subtotal,
      @JsonKey(fromJson: _toDouble) double tax,
      @JsonKey(fromJson: _toDouble) double total,
      DateTime? createdAt,
      DateTime? updatedAt,
      List<OrderItemModel> items,
      UserSummary? creator,
      UserSummary? processor,
      String? discountType,
      String? customerName,
      String? idNumber,
      @JsonKey(fromJson: _toDouble) double discountAmount,
      @JsonKey(fromJson: _toDouble) double discountTotal});

  @override
  $UserSummaryCopyWith<$Res>? get creator;
  @override
  $UserSummaryCopyWith<$Res>? get processor;
}

/// @nodoc
class __$$OrderModelImplCopyWithImpl<$Res>
    extends _$OrderModelCopyWithImpl<$Res, _$OrderModelImpl>
    implements _$$OrderModelImplCopyWith<$Res> {
  __$$OrderModelImplCopyWithImpl(
      _$OrderModelImpl _value, $Res Function(_$OrderModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdBy = null,
    Object? processedBy = freezed,
    Object? status = null,
    Object? subtotal = null,
    Object? tax = null,
    Object? total = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? items = null,
    Object? creator = freezed,
    Object? processor = freezed,
    Object? discountType = freezed,
    Object? customerName = freezed,
    Object? idNumber = freezed,
    Object? discountAmount = null,
    Object? discountTotal = null,
  }) {
    return _then(_$OrderModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
      processedBy: freezed == processedBy
          ? _value.processedBy
          : processedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OrderStatus,
      subtotal: null == subtotal
          ? _value.subtotal
          : subtotal // ignore: cast_nullable_to_non_nullable
              as double,
      tax: null == tax
          ? _value.tax
          : tax // ignore: cast_nullable_to_non_nullable
              as double,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<OrderItemModel>,
      creator: freezed == creator
          ? _value.creator
          : creator // ignore: cast_nullable_to_non_nullable
              as UserSummary?,
      processor: freezed == processor
          ? _value.processor
          : processor // ignore: cast_nullable_to_non_nullable
              as UserSummary?,
      discountType: freezed == discountType
          ? _value.discountType
          : discountType // ignore: cast_nullable_to_non_nullable
              as String?,
      customerName: freezed == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String?,
      idNumber: freezed == idNumber
          ? _value.idNumber
          : idNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      discountAmount: null == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as double,
      discountTotal: null == discountTotal
          ? _value.discountTotal
          : discountTotal // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderModelImpl extends _OrderModel {
  const _$OrderModelImpl(
      {required this.id,
      required this.createdBy,
      this.processedBy,
      this.status = OrderStatus.pending,
      @JsonKey(fromJson: _toDouble) this.subtotal = 0,
      @JsonKey(fromJson: _toDouble) this.tax = 0,
      @JsonKey(fromJson: _toDouble) this.total = 0,
      this.createdAt,
      this.updatedAt,
      final List<OrderItemModel> items = const [],
      this.creator,
      this.processor,
      this.discountType,
      this.customerName,
      this.idNumber,
      @JsonKey(fromJson: _toDouble) this.discountAmount = 0,
      @JsonKey(fromJson: _toDouble) this.discountTotal = 0})
      : _items = items,
        super._();

  factory _$OrderModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderModelImplFromJson(json);

  @override
  final String id;
  @override
  final String createdBy;
  @override
  final String? processedBy;
  @override
  @JsonKey()
  final OrderStatus status;
  @override
  @JsonKey(fromJson: _toDouble)
  final double subtotal;
  @override
  @JsonKey(fromJson: _toDouble)
  final double tax;
  @override
  @JsonKey(fromJson: _toDouble)
  final double total;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  final List<OrderItemModel> _items;
  @override
  @JsonKey()
  List<OrderItemModel> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final UserSummary? creator;
  @override
  final UserSummary? processor;
  @override
  final String? discountType;
  @override
  final String? customerName;
  @override
  final String? idNumber;
  @override
  @JsonKey(fromJson: _toDouble)
  final double discountAmount;
  @override
  @JsonKey(fromJson: _toDouble)
  final double discountTotal;

  @override
  String toString() {
    return 'OrderModel(id: $id, createdBy: $createdBy, processedBy: $processedBy, status: $status, subtotal: $subtotal, tax: $tax, total: $total, createdAt: $createdAt, updatedAt: $updatedAt, items: $items, creator: $creator, processor: $processor, discountType: $discountType, customerName: $customerName, idNumber: $idNumber, discountAmount: $discountAmount, discountTotal: $discountTotal)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.processedBy, processedBy) ||
                other.processedBy == processedBy) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.subtotal, subtotal) ||
                other.subtotal == subtotal) &&
            (identical(other.tax, tax) || other.tax == tax) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.creator, creator) || other.creator == creator) &&
            (identical(other.processor, processor) ||
                other.processor == processor) &&
            (identical(other.discountType, discountType) ||
                other.discountType == discountType) &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName) &&
            (identical(other.idNumber, idNumber) ||
                other.idNumber == idNumber) &&
            (identical(other.discountAmount, discountAmount) ||
                other.discountAmount == discountAmount) &&
            (identical(other.discountTotal, discountTotal) ||
                other.discountTotal == discountTotal));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      createdBy,
      processedBy,
      status,
      subtotal,
      tax,
      total,
      createdAt,
      updatedAt,
      const DeepCollectionEquality().hash(_items),
      creator,
      processor,
      discountType,
      customerName,
      idNumber,
      discountAmount,
      discountTotal);

  /// Create a copy of OrderModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderModelImplCopyWith<_$OrderModelImpl> get copyWith =>
      __$$OrderModelImplCopyWithImpl<_$OrderModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderModelImplToJson(
      this,
    );
  }
}

abstract class _OrderModel extends OrderModel {
  const factory _OrderModel(
          {required final String id,
          required final String createdBy,
          final String? processedBy,
          final OrderStatus status,
          @JsonKey(fromJson: _toDouble) final double subtotal,
          @JsonKey(fromJson: _toDouble) final double tax,
          @JsonKey(fromJson: _toDouble) final double total,
          final DateTime? createdAt,
          final DateTime? updatedAt,
          final List<OrderItemModel> items,
          final UserSummary? creator,
          final UserSummary? processor,
          final String? discountType,
          final String? customerName,
          final String? idNumber,
          @JsonKey(fromJson: _toDouble) final double discountAmount,
          @JsonKey(fromJson: _toDouble) final double discountTotal}) =
      _$OrderModelImpl;
  const _OrderModel._() : super._();

  factory _OrderModel.fromJson(Map<String, dynamic> json) =
      _$OrderModelImpl.fromJson;

  @override
  String get id;
  @override
  String get createdBy;
  @override
  String? get processedBy;
  @override
  OrderStatus get status;
  @override
  @JsonKey(fromJson: _toDouble)
  double get subtotal;
  @override
  @JsonKey(fromJson: _toDouble)
  double get tax;
  @override
  @JsonKey(fromJson: _toDouble)
  double get total;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  List<OrderItemModel> get items;
  @override
  UserSummary? get creator;
  @override
  UserSummary? get processor;
  @override
  String? get discountType;
  @override
  String? get customerName;
  @override
  String? get idNumber;
  @override
  @JsonKey(fromJson: _toDouble)
  double get discountAmount;
  @override
  @JsonKey(fromJson: _toDouble)
  double get discountTotal;

  /// Create a copy of OrderModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderModelImplCopyWith<_$OrderModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserSummary _$UserSummaryFromJson(Map<String, dynamic> json) {
  return _UserSummary.fromJson(json);
}

/// @nodoc
mixin _$UserSummary {
  String get id => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;

  /// Serializes this UserSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserSummaryCopyWith<UserSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserSummaryCopyWith<$Res> {
  factory $UserSummaryCopyWith(
          UserSummary value, $Res Function(UserSummary) then) =
      _$UserSummaryCopyWithImpl<$Res, UserSummary>;
  @useResult
  $Res call({String id, String firstName, String lastName});
}

/// @nodoc
class _$UserSummaryCopyWithImpl<$Res, $Val extends UserSummary>
    implements $UserSummaryCopyWith<$Res> {
  _$UserSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstName = null,
    Object? lastName = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserSummaryImplCopyWith<$Res>
    implements $UserSummaryCopyWith<$Res> {
  factory _$$UserSummaryImplCopyWith(
          _$UserSummaryImpl value, $Res Function(_$UserSummaryImpl) then) =
      __$$UserSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String firstName, String lastName});
}

/// @nodoc
class __$$UserSummaryImplCopyWithImpl<$Res>
    extends _$UserSummaryCopyWithImpl<$Res, _$UserSummaryImpl>
    implements _$$UserSummaryImplCopyWith<$Res> {
  __$$UserSummaryImplCopyWithImpl(
      _$UserSummaryImpl _value, $Res Function(_$UserSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstName = null,
    Object? lastName = null,
  }) {
    return _then(_$UserSummaryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserSummaryImpl implements _UserSummary {
  const _$UserSummaryImpl(
      {required this.id, required this.firstName, required this.lastName});

  factory _$UserSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserSummaryImplFromJson(json);

  @override
  final String id;
  @override
  final String firstName;
  @override
  final String lastName;

  @override
  String toString() {
    return 'UserSummary(id: $id, firstName: $firstName, lastName: $lastName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserSummaryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, firstName, lastName);

  /// Create a copy of UserSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserSummaryImplCopyWith<_$UserSummaryImpl> get copyWith =>
      __$$UserSummaryImplCopyWithImpl<_$UserSummaryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserSummaryImplToJson(
      this,
    );
  }
}

abstract class _UserSummary implements UserSummary {
  const factory _UserSummary(
      {required final String id,
      required final String firstName,
      required final String lastName}) = _$UserSummaryImpl;

  factory _UserSummary.fromJson(Map<String, dynamic> json) =
      _$UserSummaryImpl.fromJson;

  @override
  String get id;
  @override
  String get firstName;
  @override
  String get lastName;

  /// Create a copy of UserSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserSummaryImplCopyWith<_$UserSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
