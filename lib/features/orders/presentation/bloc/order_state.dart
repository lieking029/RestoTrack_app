import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:restotrack_app/features/orders/data/models/order_model.dart';

part 'order_state.freezed.dart';

enum OrderStateStatus {
  initial,
  loading,
  success,
  error,
}

@freezed
class OrderState with _$OrderState {
  const OrderState._();

  const factory OrderState({
    @Default([]) List<OrderModel> orders,
    @Default(OrderStateStatus.initial) OrderStateStatus status,
    OrderModel? selectedOrder,
    OrderStatus? filterStatus,
    String? errorMessage,
    @Default(false) bool isUpdating,
  }) = _OrderState;

  bool get isLoading => status == OrderStateStatus.loading;
  bool get hasError => status == OrderStateStatus.error;
  bool get isEmpty => orders.isEmpty && status == OrderStateStatus.success;

  List<OrderModel> get activeOrders =>
      orders.where((o) => o.status.isActive).toList();

  List<OrderModel> get pendingOrders =>
      orders.where((o) => o.status == OrderStatus.pending).toList();

  List<OrderModel> get preparingOrders =>
      orders.where((o) => o.status == OrderStatus.preparing).toList();

  List<OrderModel> get readyOrders =>
      orders.where((o) => o.status == OrderStatus.ready).toList();

  List<OrderModel> get completedOrders =>
      orders.where((o) => o.status == OrderStatus.completed).toList();
}