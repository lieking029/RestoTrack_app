import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:restotrack_app/features/orders/data/models/order_item_model.dart';

part 'order_model.freezed.dart';
part 'order_model.g.dart';

enum OrderStatus {
  @JsonValue(0)
  pending,
  @JsonValue(1)
  confirmed,
  @JsonValue(2)
  inPreparation,
  @JsonValue(3)
  ready,
  @JsonValue(4)
  completed,
  @JsonValue(5)
  cancelled;

  String get displayName {
    switch (this) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.confirmed:
        return 'Confirmed';
      case OrderStatus.inPreparation:
        return 'In Preparation';
      case OrderStatus.ready:
        return 'Ready';
      case OrderStatus.completed:
        return 'Completed';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }

  bool get isActive =>
      this == pending || this == confirmed || this == inPreparation || this == ready;
  bool get canCancel => this == pending || this == confirmed;
  bool get canComplete => this == ready;
}

@freezed
class OrderModel with _$OrderModel {

  const factory OrderModel({
    required String id,
    required String createdBy,
    String? processedBy,
    @Default(OrderStatus.pending) OrderStatus status,
    @Default(0) double subtotal,
    @Default(0) double tax,
    @Default(0) double total,
    DateTime? createdAt,
    DateTime? updatedAt,
    @Default([]) List<OrderItemModel> items,
    UserSummary? creator,
    UserSummary? processor,
  }) = _OrderModel;
  const OrderModel._();

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

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
      _$UserSummaryFromJson(json);
}