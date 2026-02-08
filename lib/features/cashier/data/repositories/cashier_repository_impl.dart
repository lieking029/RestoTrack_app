import 'package:restotrack_app/core/network/api_client.dart';
import 'package:restotrack_app/features/cashier/data/repositories/cashier_repository.dart';
import 'package:restotrack_app/features/orders/data/models/order_model.dart';

class CashierRepositoryImpl implements CashierRepository {
  CashierRepositoryImpl({required ApiClient apiClient}) : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<List<OrderModel>> getPendingOrders() async {
    final response = await _apiClient.getCashierOrders();
    final data = response.data as Map<String, dynamic>;
    final orders = data['data'] as List<dynamic>;
    return orders
        .map((json) => OrderModel.fromJson(json as Map<String, dynamic>))
        .where((order) => order.status == OrderStatus.pending)
        .toList();
  }

  @override
  Future<List<OrderModel>> getAllOrders() async {
    final response = await _apiClient.getCashierOrders();
    final data = response.data as Map<String, dynamic>;
    final orders = data['data'] as List<dynamic>;
    return orders
        .map((json) => OrderModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<OrderModel> processPayment({
    required String orderId,
    required double amountPaid,
    required String paymentMethod,
  }) async {
    final response = await _apiClient.processPayment({
      'order_id': orderId,
      'amount_paid': amountPaid,
      'payment_method': paymentMethod,
    });

    final data = response.data as Map<String, dynamic>;
    return OrderModel.fromJson(data['data'] as Map<String, dynamic>);
  }

  @override
  Future<CashierStats> getTodayStats() async {
    final response = await _apiClient.getCashierOrders();
    final data = response.data as Map<String, dynamic>;
    final orders = data['data'] as List<dynamic>;
    final orderModels = orders
        .map((json) => OrderModel.fromJson(json as Map<String, dynamic>))
        .toList();

    final pendingCount = orderModels
        .where((o) => o.status == OrderStatus.pending)
        .length;
    final completedOrders = orderModels
        .where((o) => o.status == OrderStatus.completed)
        .toList();
    final totalSales = completedOrders.fold<double>(
      0,
      (sum, order) => sum + order.total,
    );

    return CashierStats(
      pendingCount: pendingCount,
      completedCount: completedOrders.length,
      totalSales: totalSales,
    );
  }
}
