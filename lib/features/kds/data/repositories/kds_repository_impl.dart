import 'package:restotrack_app/core/network/api_client.dart';
import 'package:restotrack_app/features/kds/data/repositories/kds_repository.dart';
import 'package:restotrack_app/features/orders/data/models/order_model.dart';

class KdsRepositoryImpl implements KdsRepository {
  KdsRepositoryImpl({required ApiClient apiClient}) : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<List<OrderModel>> getKitchenOrders() async {
    final response = await _apiClient.getKitchenOrders();
    final data = response.data as Map<String, dynamic>;
    final orders = data['data'] as List<dynamic>;
    return orders
        .map((json) => OrderModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<OrderModel> updateOrderStatus(
    String orderId,
    OrderStatus status,
  ) async {
    final response = await _apiClient.updateOrderStatus(orderId, status.name);
    final data = response.data as Map<String, dynamic>;
    return OrderModel.fromJson(data['data'] as Map<String, dynamic>);
  }
}
