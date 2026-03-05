import 'package:restotrack_app/core/network/api_client.dart';
import 'package:restotrack_app/features/orders/data/models/order_model.dart';
import 'package:restotrack_app/features/sales_report/data/repositories/sales_report_repository.dart';

class SalesReportRepositoryImpl implements SalesReportRepository {
  SalesReportRepositoryImpl({required ApiClient apiClient})
      : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<List<OrderModel>> getCompletedOrders({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final response = await _apiClient.getSalesReport(
        startDate: startDate?.toIso8601String().split('T').first,
        endDate: endDate?.toIso8601String().split('T').first,
      );
      final orders = _extractOrderList(response.data);
      return orders
          .map((json) => OrderModel.fromJson(json as Map<String, dynamic>))
          .where((o) => o.status == OrderStatus.completed)
          .toList();
    } catch (_) {
      // Fallback: fetch all cashier orders and filter client-side
      final response = await _apiClient.getCashierOrders();
      final orders = _extractOrderList(response.data);
      return orders
          .map((json) => OrderModel.fromJson(json as Map<String, dynamic>))
          .where((o) => o.status == OrderStatus.completed)
          .where((o) => _isInDateRange(o, startDate, endDate))
          .toList();
    }
  }

  List<dynamic> _extractOrderList(dynamic data) {
    if (data is List) return data;
    if (data is Map<String, dynamic>) return data['data'] as List<dynamic>;
    return [];
  }

  bool _isInDateRange(OrderModel order, DateTime? start, DateTime? end) {
    if (order.createdAt == null) return false;
    if (start != null && order.createdAt!.isBefore(start)) return false;
    if (end != null &&
        order.createdAt!.isAfter(end.add(const Duration(days: 1)))) {
      return false;
    }
    return true;
  }
}
