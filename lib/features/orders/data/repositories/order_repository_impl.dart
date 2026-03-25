import 'package:restotrack_app/core/network/api_client.dart';
import 'package:restotrack_app/features/orders/data/models/cart_model.dart';
import 'package:restotrack_app/features/orders/data/models/order_model.dart';
import 'package:restotrack_app/features/orders/data/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  OrderRepositoryImpl({required ApiClient apiClient}) : _apiClient = apiClient;

  final ApiClient _apiClient;

  Map<String, dynamic> _extractObject(dynamic data) {
    if (data is Map<String, dynamic> && data.containsKey('data')) {
      return data['data'] as Map<String, dynamic>;
    }
    return data as Map<String, dynamic>;
  }

  @override
  Future<OrderModel> createOrder(CartModel cart) async {
    final response = await _apiClient.createOrder(cart.toRequest());
    return OrderModel.fromJson(_extractObject(response.data));
  }

  @override
  Future<List<OrderModel>> getMyOrders({OrderStatus? status}) async {
    final response = await _apiClient.getMyOrders(status: status?.index);
    final data = response.data is List
        ? response.data as List<dynamic>
        : response.data['data'] as List<dynamic>;
    return data
        .map((json) => OrderModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<OrderModel> getOrder(String id) async {
    final response = await _apiClient.getOrder(id);
    return OrderModel.fromJson(_extractObject(response.data));
  }

  @override
  Future<OrderModel> cancelOrder(String id, {String? reason}) async {
    final response = await _apiClient.cancelOrder(id);
    return OrderModel.fromJson(_extractObject(response.data));
  }

  @override
  Future<OrderModel> serveOrder(String id) async {
    final response = await _apiClient.serveOrder(id);
    return OrderModel.fromJson(_extractObject(response.data));
  }

  @override
  Future<OrderModel> editOrder(String id, CartModel cart) async {
    final response = await _apiClient.editOrder(id, cart.toRequest());
    return OrderModel.fromJson(_extractObject(response.data));
  }
}
