import 'package:freezed_annotation/freezed_annotation.dart';

part 'menu_model.freezed.dart';
part 'menu_model.g.dart';

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
    @JsonKey(name: 'dish_picture') String? dishPicture,
    @Default(0) int category,
    @Default(MenuStatus.available) MenuStatus status,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _MenuModel;

  factory MenuModel.fromJson(Map<String, dynamic> json) =>
      _$MenuModelFromJson(json);

  bool get isAvailable => status == MenuStatus.available;

  String get categoryName => categoryNames[category] ?? 'Other';

  static const Map<int, String> categoryNames = {
    1: 'Main Course',
    2: 'Desserts',
    3: 'Beverages',
  };
}

@freezed
class CategoryModel with _$CategoryModel {
  const factory CategoryModel({
    required int id,
    required String name,
  }) = _CategoryModel;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
}