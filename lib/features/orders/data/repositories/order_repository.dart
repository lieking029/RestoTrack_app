import 'package:restotrack_app/features/orders/data/models/cart_model.dart';
import 'package:restotrack_app/features/orders/data/models/order_model.dart';

abstract class OrderRepository {
  Future<OrderModel> createOrder(CartModel cart);

  Future<List<OrderModel>> getMyOrders({OrderStatus? status});

  Future<OrderModel> getOrder(String id);

  Future<OrderModel> cancelOrder(String id, {String? reason});

  Future<OrderModel> completeOrder(String id);
}