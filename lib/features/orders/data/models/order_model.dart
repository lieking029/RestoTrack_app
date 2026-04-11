import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:restotrack_app/core/utils/json_utils.dart';
import 'package:restotrack_app/features/orders/data/models/order_item_model.dart';

part 'order_model.freezed.dart';
part 'order_model.g.dart';

enum OrderStatus {
  @JsonValue(0)
  pending,
  @JsonValue(1)
  inPreparation,
  @JsonValue(2)
  ready,
  @JsonValue(3)
  served,
  @JsonValue(4)
  completed,
  @JsonValue(5)
  cancelled;

  String get displayName {
    switch (this) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.inPreparation:
        return 'In Preparation';
      case OrderStatus.ready:
        return 'Ready';
      case OrderStatus.served:
        return 'Served';
      case OrderStatus.completed:
        return 'Completed';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }

  bool get isActive =>
      this == pending || this == inPreparation || this == ready || this == served;
  bool get canCancel => this == pending || this == inPreparation;
  bool get canComplete => this == ready;
}

double _toDouble(dynamic value) {
  if (value == null) return 0;
  if (value is num) return value.toDouble();
  if (value is String) return double.tryParse(value) ?? 0;
  return 0;
}

@freezed
class OrderModel with _$OrderModel {

  const factory OrderModel({
    required String id,
    required String createdBy,
    String? processedBy,
    @Default(OrderStatus.pending) OrderStatus status,
    @JsonKey(fromJson: _toDouble) @Default(0) double subtotal,
    DateTime? createdAt,
    DateTime? updatedAt,
    @Default([]) List<OrderItemModel> items,
    UserSummary? creator,
    UserSummary? processor,
    String? discountType,
    String? customerName,
    String? idNumber,
    @JsonKey(fromJson: _toDouble) @Default(0) double discountAmount,
    @JsonKey(fromJson: _toDouble) @Default(0) double discountTotal,
  }) = _OrderModel;
  const OrderModel._();

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(normalizeJsonKeys(json));

  double get total => subtotal;

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  String get orderNumber => id.substring(id.length - 4).toUpperCase();

  String get timeAgo {
    if (createdAt == null) return '';
    final diff = DateTime.now().difference(createdAt!);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes} mins ago';
    if (diff.inHours < 24) return '${diff.inHours} hours ago';
    return '${diff.inDays} days ago';
  }
}

@freezed
class UserSummary with _$UserSummary {
  const factory UserSummary({
    required String id,
    required String firstName,
    required String lastName,
  }) = _UserSummary;

  factory UserSummary.fromJson(Map<String, dynamic> json) =>
      _$UserSummaryFromJson(normalizeJsonKeys(json));
}