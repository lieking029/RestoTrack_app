import 'package:restotrack_app/core/network/api_client.dart';
import 'package:restotrack_app/features/menu/data/models/menu_model.dart';
import 'package:restotrack_app/features/menu/data/repository/menu_repository.dart';

class MenuRepositoryImpl implements MenuRepository {
  MenuRepositoryImpl({required ApiClient apiClient}) : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<List<MenuModel>> getMenuItems() async {
    final response = await _apiClient.getMenus();
    final data = response.data['data'] as List<dynamic>;
    return data
        .map((json) => MenuModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<MenuModel>> getMenuItemsByCategory(int categoryId) async {
    final response = await _apiClient.getMenus(categoryId: categoryId.toString());
    final data = response.data['data'] as List<dynamic>;
    return data
        .map((json) => MenuModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await _apiClient.getCategories();
    final data = response.data['data'] as List<dynamic>;
    return data
        .map((json) => CategoryModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<MenuModel> getMenuItem(String id) async {
    final response = await _apiClient.getMenu(id);
    return MenuModel.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<List<MenuModel>> searchMenuItems(String query) async {
    final response = await _apiClient.getMenus(search: query);
    final data = response.data['data'] as List<dynamic>;
    return data
        .map((json) => MenuModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}