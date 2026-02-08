import 'package:restotrack_app/features/orders/data/models/order_model.dart';

abstract class CashierRepository {
  Future<List<OrderModel>> getPendingOrders();

  Future<List<OrderModel>> getAllOrders();

  Future<OrderModel> processPayment({
    required String orderId,
    required double amountPaid,
    required String paymentMethod,
  });

  Future<CashierStats> getTodayStats();
}

class CashierStats {
  final int pendingCount;
  final int completedCount;
  final double totalSales;

  const CashierStats({
    required this.pendingCount,
    required this.completedCount,
    required this.totalSales,
  });
}
