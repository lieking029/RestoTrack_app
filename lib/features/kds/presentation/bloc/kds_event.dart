import 'package:equatable/equatable.dart';
import 'package:restotrack_app/features/orders/data/models/order_model.dart';

abstract class KdsEvent extends Equatable {
  const KdsEvent();

  @override
  List<Object?> get props => [];
}

class KdsLoadOrders extends KdsEvent {
  const KdsLoadOrders();
}

class KdsRefreshOrders extends KdsEvent {
  const KdsRefreshOrders();
}

class KdsUpdateOrderStatus extends KdsEvent {
  const KdsUpdateOrderStatus({
    required this.orderId,
    required this.newStatus,
  });

  final String orderId;
  final OrderStatus newStatus;

  @override
  List<Object?> get props => [orderId, newStatus];
}

class KdsClearError extends KdsEvent {
  const KdsClearError();
}
