import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:restotrack_app/core/constants/api_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'ngrok-skip-browser-warning': 'true',
        },
      ),
    );
    _dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: false,
      responseBody: true,
      error: true,
      logPrint: (obj) => print('>>> [Dio] $obj'),
    ));
  }

  late final Dio _dio;
  late final PersistCookieJar _cookieJar;
  late final SharedPreferences _prefs;
  static const _tokenKey = 'auth_token';
  static const _userKey = 'auth_user';

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    final token = _prefs.getString(_tokenKey);
    if (token != null) {
      _dio.options.headers['Authorization'] = 'Bearer $token';
      print('>>> [ApiClient] Token restored from storage');
    }
  }

  Future<void> setUser(String userJson) async {
    await _prefs.setString(_userKey, userJson);
    print('>>> [ApiClient] User saved');
  }

  String? getUser() {
    return _prefs.getString(_userKey);
  }

  Future<void> clearUser() async {
    await _prefs.remove(_userKey);
    print('>>> [ApiClient] User cleared');
  }

  bool hasToken() {
    return _prefs.getString(_tokenKey) != null;
  }

  Future<void> clearCookies() async {
    await _cookieJar.deleteAll();
  }

  Future<void> setToken(String token) async {
    await _prefs.setString(_tokenKey, token);
    _dio.options.headers['Authorization'] = 'Bearer $token';
    print('>>> [ApiClient] Token saved');
  }

  Future<void> clearToken() async {
    await _prefs.remove(_tokenKey);
    _dio.options.headers.remove('Authorization');
    print('>>> [ApiClient] Token cleared');
  }

  Future<Response<dynamic>> login(String email, String password) => _dio.post(
        ApiConstants.login,
        data: {'email': email, 'password': password},
      );

  Future<Response<dynamic>> logout() => _dio.post(ApiConstants.logout);

  Future<Response<dynamic>> me() => _dio.get(ApiConstants.me);

  Future<Response<dynamic>> profile() => _dio.get(ApiConstants.profile);

  Future<Response<dynamic>> createOrder(Map<String, dynamic> data) =>
      _dio.post(ApiConstants.order, data: data);

  Future<Response<dynamic>> completeOrder(String orderId) =>
      _dio.put('${ApiConstants.order}/$orderId');

  Future<Response<dynamic>> cancelOrder(String orderId) =>
      _dio.put('${ApiConstants.order}/$orderId/cancel');

  Future<Response<dynamic>> getKitchenOrders() =>
      _dio.get(ApiConstants.kitchenOrders);

  Future<Response<dynamic>> getCashierOrders({int? status}) {
    final queryParams = <String, dynamic>{};
    if (status != null) {
      queryParams['status'] = status;
    }
    return _dio.get(
      ApiConstants.cashierOrders,
      queryParameters: queryParams.isNotEmpty ? queryParams : null,
    );
  }

  Future<Response<dynamic>> updateOrderStatus(String orderId, String status) =>
      _dio.patch('${ApiConstants.kitchenOrders}/$orderId',
          data: {'status': status});

  Future<Response<dynamic>> processPayment(Map<String, dynamic> data) =>
      _dio.post(ApiConstants.payments, data: data);

  Future<Response<dynamic>> getTransactions() =>
      _dio.get(ApiConstants.transactions);

  Future<Response<dynamic>> receiveInventory(
          String itemId, Map<String, dynamic> data) =>
      _dio.post('${ApiConstants.inventory}/$itemId/receive', data: data);

  Future<Response<dynamic>> wasteInventory(
          String itemId, Map<String, dynamic> data) =>
      _dio.post('${ApiConstants.inventory}/$itemId/waste', data: data);

  Future<Response<dynamic>> adjustInventory(
          String itemId, Map<String, dynamic> data) =>
      _dio.post('${ApiConstants.inventory}/$itemId/adjust', data: data);

  Future<Response<dynamic>> getMyOrders({int? status}) {
    final queryParams = <String, dynamic>{};
    if (status != null) {
      queryParams['status'] = status;
    }

    return _dio.get(
      ApiConstants.myOrders,
      queryParameters: queryParams.isNotEmpty ? queryParams : null,
    );
  }

  Future<Response<dynamic>> getOrder(String orderId) =>
      _dio.get('${ApiConstants.order}/$orderId');

  Future<Response<dynamic>> getSalesReport({
    String? startDate,
    String? endDate,
  }) {
    final queryParams = <String, dynamic>{};
    if (startDate != null) queryParams['start_date'] = startDate;
    if (endDate != null) queryParams['end_date'] = endDate;
    return _dio.get(
      ApiConstants.salesReport,
      queryParameters: queryParams.isNotEmpty ? queryParams : null,
    );
  }

  Future<Response<dynamic>> getMenus({String? categoryId, String? search}) {
    final queryParams = <String, dynamic>{};
    if (categoryId != null) queryParams['category_id'] = categoryId;
    if (search != null) queryParams['search'] = search;
    return _dio.get(
      ApiConstants.menus,
      queryParameters: queryParams.isNotEmpty ? queryParams : null,
    );
  }

  Future<Response<dynamic>> getMenu(String menuId) =>
      _dio.get('${ApiConstants.menus}/$menuId');

  Future<Response<dynamic>> getCategories() =>
      _dio.get(ApiConstants.categories);
}
