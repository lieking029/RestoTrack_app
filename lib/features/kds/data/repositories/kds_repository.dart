import 'package:restotrack_app/features/orders/data/models/order_model.dart';

abstract class KdsRepository {
  Future<List<OrderModel>> getKitchenOrders();
  Future<OrderModel> updateOrderStatus(String orderId, OrderStatus status);
}
