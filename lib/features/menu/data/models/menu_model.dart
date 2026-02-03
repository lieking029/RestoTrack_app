import 'package:freezed_annotation/freezed_annotation.dart';

part 'menu_model.freezed.dart';
part 'menu_model.g.dart';

/// Menu item status
enum MenuStatus {
  @JsonValue(0)
  available,
  @JsonValue(1)
  unavailable;

  String get displayName {
    switch (this) {
      case MenuStatus.available:
        return 'Available';
      case MenuStatus.unavailable:
        return 'Unavailable';
    }
  }

  bool get isAvailable => this == available;
}

@freezed
class MenuModel with _$MenuModel {
  const MenuModel._();

  const factory MenuModel({
    required String id,
    required String name,
    required double price,
    String? description,
    String? imageUrl,
    String? categoryId,
    @Default(MenuStatus.available) MenuStatus status,
    DateTime? createdAt,
    DateTime? updatedAt,
    // Relationship
    CategoryModel? category,
  }) = _MenuModel;

  factory MenuModel.fromJson(Map<String, dynamic> json) =>
      _$MenuModelFromJson(json);

  bool get isAvailable => status == MenuStatus.available;
}

@freezed
class CategoryModel with _$CategoryModel {
  const factory CategoryModel({
    required String id,
    required String name,
    String? description,
    int? sortOrder,
  }) = _CategoryModel;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
}