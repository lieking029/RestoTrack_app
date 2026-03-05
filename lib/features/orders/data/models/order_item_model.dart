import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:restotrack_app/core/utils/json_utils.dart';

part 'order_item_model.freezed.dart';
part 'order_item_model.g.dart';

double _itemToDouble(dynamic value) {
  if (value == null) return 0;
  if (value is num) return value.toDouble();
  if (value is String) return double.tryParse(value) ?? 0;
  return 0;
}

@freezed
class OrderItemModel with _$OrderItemModel {
  const OrderItemModel._();

  const factory OrderItemModel({
    required String id,
    required String orderId,
    required String menuId,
    required String name,
    @JsonKey(fromJson: _itemToDouble) required double unitPrice,
    required int quantity,
    @JsonKey(fromJson: _itemToDouble) required double total,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _OrderItemModel;

  factory OrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemModelFromJson(normalizeJsonKeys(json));
}