import 'package:equatable/equatable.dart';
import 'package:restotrack_app/features/orders/data/models/order_model.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object?> get props => [];
}

class OrderLoadOrders extends OrderEvent {
  const OrderLoadOrders({this.status});

  final OrderStatus? status;

  @override
  List<Object?> get props => [status];
}

class OrderRefreshOrders extends OrderEvent {
  const OrderRefreshOrders();
}

class OrderLoadOrder extends OrderEvent {
  const OrderLoadOrder(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

class OrderCancelOrder extends OrderEvent {
  const OrderCancelOrder(this.id, {this.reason});

  final String id;
  final String? reason;

  @override
  List<Object?> get props => [id, reason];
}

class OrderCompleteOrder extends OrderEvent {
  const OrderCompleteOrder(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

class OrderClearError extends OrderEvent {
  const OrderClearError();
}