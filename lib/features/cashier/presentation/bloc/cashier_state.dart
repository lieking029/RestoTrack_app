import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:restotrack_app/features/cashier/data/repositories/cashier_repository.dart';
import 'package:restotrack_app/features/orders/data/models/order_model.dart';

part 'cashier_state.freezed.dart';

enum CashierStateStatus {
  initial,
  loading,
  success,
  error,
}

@freezed
class CashierState with _$CashierState {
  const factory CashierState({
    @Default([]) List<OrderModel> orders,
    @Default(CashierStateStatus.initial) CashierStateStatus status,
    String? errorMessage,
    @Default(false) bool isProcessingPayment,
    String? processingOrderId,
    CashierStats? stats,
    OrderModel? lastCompletedOrder,
    String? checkoutUrl,
    String? checkoutSessionId,
    @Default(false) bool isPollingPayment,
    String? onlinePaymentOrderId,
  }) = _CashierState;

  const CashierState._();

  bool get isLoading => status == CashierStateStatus.loading;
  bool get hasError => status == CashierStateStatus.error;
  bool get isEmpty => orders.isEmpty && status == CashierStateStatus.success;

  List<OrderModel> get servedOrders =>
      orders.where((o) => o.status == OrderStatus.served).toList();

  List<OrderModel> get completedOrders =>
      orders.where((o) => o.status == OrderStatus.completed).toList();

  List<OrderModel> get allActiveOrders =>
      orders.where((o) => o.status.isActive).toList();
}
