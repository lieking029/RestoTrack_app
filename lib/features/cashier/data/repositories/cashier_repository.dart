import 'package:restotrack_app/features/orders/data/models/order_model.dart';

abstract class CashierRepository {
  Future<List<OrderModel>> getServedOrders();

  Future<List<OrderModel>> getAllOrders();

  Future<void> processPayment({
    required String orderId,
    required double amountPaid,
    required String paymentMethod,
  });

  Future<CashierStats> getTodayStats();

  Future<Map<String, String>> createOnlinePayment({required String orderId});

  Future<bool> checkPaymentStatus({required String orderId});
}

class CashierStats {
  final int servedCount;
  final int completedCount;
  final double totalSales;

  const CashierStats({
    required this.servedCount,
    required this.completedCount,
    required this.totalSales,
  });
}
