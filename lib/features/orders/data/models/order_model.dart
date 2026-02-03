import 'package:freezed_annotation/freezed_annotation.dart';

import 'order_item_model.dart';

part 'order_model.freezed.dart';
part 'order_model.g.dart';

/// Order status enum matching Laravel's OrderStatus enum
enum OrderStatus {
  @JsonValue(0)
  pending,
  @JsonValue(1)
  preparing,
  @JsonValue(2)
  ready,
  @JsonValue(3)
  completed,
  @JsonValue(4)
  cancelled;

  String get displayName {
    switch (this) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.preparing:
        return 'Preparing';
      case OrderStatus.ready:
        return 'Ready';
      case OrderStatus.completed:
        return 'Completed';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }

  bool get isActive => this == pending || this == preparing || this == ready;
  bool get canCancel => this == pending || this == preparing;
  bool get canComplete => this == ready;
}

@freezed
class OrderModel with _$OrderModel {
  const OrderModel._();

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
    // Relationships
    @Default([]) List<OrderItemModel> items,
    UserSummary? creator,
    UserSummary? processor,
  }) = _OrderModel;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  /// Get total item count
  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  /// Get formatted order number (last 4 chars of UUID)
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