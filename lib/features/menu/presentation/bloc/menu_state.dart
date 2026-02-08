import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:restotrack_app/features/menu/data/models/menu_model.dart';

part 'menu_state.freezed.dart';

@freezed
class MenuState with _$MenuState {

  const factory MenuState({
    @Default([]) List<MenuModel> menuItems,
    @Default([]) List<MenuModel> filteredItems,
    @Default([]) List<CategoryModel> categories,
    @Default(false) bool isLoading,
    @Default(false) bool isSearching,
    int? selectedCategoryId,
    String? searchQuery,
    String? errorMessage,
  }) = _MenuState;
  const MenuState._();

  bool get hasError => errorMessage != null;
  bool get isEmpty => filteredItems.isEmpty && !isLoading;

  List<MenuModel> get displayItems =>
      searchQuery != null || selectedCategoryId != null
          ? filteredItems
          : menuItems;

  List<MenuModel> get availableItems =>
      displayItems.where((item) => item.isAvailable).toList();
}