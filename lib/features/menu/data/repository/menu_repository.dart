import 'package:restotrack_app/features/menu/data/models/menu_model.dart';

abstract class MenuRepository {
  Future<List<MenuModel>> getMenuItems();

  Future<List<MenuModel>> getMenuItemsByCategory(int categoryId);

  Future<List<CategoryModel>> getCategories();

  Future<MenuModel> getMenuItem(String id);

  Future<List<MenuModel>> searchMenuItems(String query);
}