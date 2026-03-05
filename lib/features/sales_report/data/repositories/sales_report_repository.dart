import 'package:restotrack_app/features/orders/data/models/order_model.dart';

abstract class SalesReportRepository {
  Future<List<OrderModel>> getCompletedOrders({
    DateTime? startDate,
    DateTime? endDate,
  });
}

class SalesReportStats {
  const SalesReportStats({
    required this.totalSales,
    required this.orderCount,
    required this.averageOrderValue,
  });

  final double totalSales;
  final int orderCount;
  final double averageOrderValue;
}
