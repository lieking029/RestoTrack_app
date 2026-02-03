import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

/// Product stock status matching Laravel enum
enum ProductStatus {
  @JsonValue(0)
  onStock,
  @JsonValue(1)
  lowOnStock,
  @JsonValue(2)
  noStock;

  String get displayName {
    switch (this) {
      case ProductStatus.onStock:
        return 'In Stock';
      case ProductStatus.lowOnStock:
        return 'Low Stock';
      case ProductStatus.noStock:
        return 'Out of Stock';
    }
  }

  bool get isAvailable => this != noStock;
}

/// Unit of measurement enum
enum UnitOfMeasurement {
  @JsonValue(0)
  piece,
  @JsonValue(1)
  kilogram,
  @JsonValue(2)
  gram,
  @JsonValue(3)
  liter,
  @JsonValue(4)
  milliliter,
  @JsonValue(5)
  pack;

  String get displayName {
    switch (this) {
      case UnitOfMeasurement.piece:
        return 'Piece(s)';
      case UnitOfMeasurement.kilogram:
        return 'Kilogram(s)';
      case UnitOfMeasurement.gram:
        return 'Gram(s)';
      case UnitOfMeasurement.liter:
        return 'Liter(s)';
      case UnitOfMeasurement.milliliter:
        return 'Milliliter(s)';
      case UnitOfMeasurement.pack:
        return 'Pack(s)';
    }
  }

  String get abbreviation {
    switch (this) {
      case UnitOfMeasurement.piece:
        return 'pc';
      case UnitOfMeasurement.kilogram:
        return 'kg';
      case UnitOfMeasurement.gram:
        return 'g';
      case UnitOfMeasurement.liter:
        return 'L';
      case UnitOfMeasurement.milliliter:
        return 'mL';
      case UnitOfMeasurement.pack:
        return 'pk';
    }
  }
}

@freezed
class ProductModel with _$ProductModel {
  const ProductModel._();

  const factory ProductModel({
    required String id,
    required String name,
    required int initialStock,
    required UnitOfMeasurement unitOfMeasurement,
    required DateTime expirationDate,
    @Default(ProductStatus.onStock) ProductStatus status,
    int? stockOut,
    int? remainingStock,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  bool get isAvailable => status.isAvailable;

  bool get isExpired => expirationDate.isBefore(DateTime.now());

  bool get isExpiringSoon {
    final daysUntilExpiry = expirationDate.difference(DateTime.now()).inDays;
    return daysUntilExpiry <= 7 && daysUntilExpiry > 0;
  }
}
