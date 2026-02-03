import 'dart:convert';

import 'package:restotrack_app/core/network/api_client.dart';
import 'package:restotrack_app/features/auth/data/models/user_model.dart';

class AuthRepository {

  AuthRepository(this._apiClient);
  final ApiClient _apiClient;

  Future<UserModel> login(String email, String password) async {
    final response = await _apiClient.login(email, password);

    final token = response.data['token'] as String;
    await _apiClient.setToken(token);

    final userJson = response.data['user'] as Map<String, dynamic>;
    final user = UserModel.fromJson(userJson);

    // Save user data locally for session persistence
    await _apiClient.setUser(jsonEncode(userJson));

    return user;
  }

  Future<void> logout() async {
    try {
      await _apiClient.logout();
    } catch (_) {
      // Ignore logout API errors
    }
    await _apiClient.clearToken();
    await _apiClient.clearUser();
  }

  Future<UserModel?> checkAuthStatus() async {
    // First check if we have a token
    if (!_apiClient.hasToken()) {
      return null;
    }

    // Try to restore user from local storage first
    final savedUserJson = _apiClient.getUser();
    UserModel? savedUser;
    if (savedUserJson != null) {
      try {
        savedUser = UserModel.fromJson(
          jsonDecode(savedUserJson) as Map<String, dynamic>,
        );
      } catch (_) {
        // Invalid saved user data
      }
    }

    // Try to verify with server, but fall back to saved user if API fails
    try {
      final response = await _apiClient.me();
      final userJson = response.data['user'] as Map<String, dynamic>;
      final user = UserModel.fromJson(userJson);
      // Update saved user data
      await _apiClient.setUser(jsonEncode(userJson));
      return user;
    } catch (e) {
      // API failed - use saved user if available
      if (savedUser != null) {
        print('>>> [AuthRepository] API failed, using cached user');
        return savedUser;
      }
      // No saved user, clear token and return null
      await _apiClient.clearToken();
      return null;
    }
  }
}