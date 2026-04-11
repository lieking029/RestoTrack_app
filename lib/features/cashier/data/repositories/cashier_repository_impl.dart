import 'package:restotrack_app/core/network/api_client.dart';
import 'package:restotrack_app/features/cashier/data/repositories/cashier_repository.dart';
import 'package:restotrack_app/features/orders/data/models/order_model.dart';

class CashierRepositoryImpl implements CashierRepository {
  CashierRepositoryImpl({required ApiClient apiClient}) : _apiClient = apiClient;

  final ApiClient _apiClient;

  List<dynamic> _extractOrderList(dynamic data) {
    if (data is List) return data;
    if (data is Map<String, dynamic>) return data['data'] as List<dynamic>;
    return [];
  }

  @override
  Future<List<OrderModel>> getServedOrders() async {
    final response = await _apiClient.getCashierOrders(status: 3);
    final orders = _extractOrderList(response.data);
    return orders
        .map((json) => OrderModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<OrderModel>> getAllOrders() async {
    final response = await _apiClient.getCashierOrders();
    final orders = _extractOrderList(response.data);
    return orders
        .map((json) => OrderModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> processPayment({
    required String orderId,
    required double amountPaid,
    required String paymentMethod,
    String? discountType,
    String? customerName,
    String? idNumber,
  }) async {
    final data = <String, dynamic>{
      'order_id': orderId,
      'amount_paid': amountPaid,
      'payment_method': paymentMethod,
    };
    if (discountType != null) {
      data['discount_type'] = discountType;
      data['customer_name'] = customerName;
      data['id_number'] = idNumber;
    }
    await _apiClient.processPayment(data);
  }

  @override
  Future<CashierStats> getTodayStats() async {
    final response = await _apiClient.getCashierOrders();
    final orders = _extractOrderList(response.data);
    final orderModels = orders
        .map((json) => OrderModel.fromJson(json as Map<String, dynamic>))
        .toList();

    final servedCount = orderModels
        .where((o) => o.status == OrderStatus.served)
        .length;
    final completedOrders = orderModels
        .where((o) => o.status == OrderStatus.completed)
        .toList();
    final totalSales = completedOrders.fold<double>(
      0,
      (sum, order) => sum + order.total,
    );

    return CashierStats(
      servedCount: servedCount,
      completedCount: completedOrders.length,
      totalSales: totalSales,
    );
  }

  @override
  Future<Map<String, String>> createOnlinePayment({
    required String orderId,
    String? discountType,
    String? customerName,
    String? idNumber,
  }) async {
    final data = <String, dynamic>{
      'order_id': orderId,
    };
    if (discountType != null) {
      data['discount_type'] = discountType;
      data['customer_name'] = customerName;
      data['id_number'] = idNumber;
    }
    final response = await _apiClient.createOnlinePayment(data);
    final responseData = response.data as Map<String, dynamic>;
    return {
      'checkout_url': responseData['checkout_url'] as String,
      'checkout_session_id': responseData['checkout_session_id'] as String,
    };
  }

  @override
  Future<bool> checkPaymentStatus({required String orderId}) async {
    final response = await _apiClient.getPaymentStatus(orderId);
    final data = response.data as Map<String, dynamic>;
    return data['is_paid'] == true;
  }
}
