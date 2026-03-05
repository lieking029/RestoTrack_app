import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:restotrack_app/features/orders/data/models/order_model.dart';

part 'kds_state.freezed.dart';

enum KdsStateStatus {
  initial,
  loading,
  success,
  error,
}

@freezed
class KdsState with _$KdsState {
  const factory KdsState({
    @Default([]) List<OrderModel> orders,
    @Default(KdsStateStatus.initial) KdsStateStatus status,
    String? errorMessage,
    String? successMessage,
    @Default(false) bool isUpdating,
    String? updatingOrderId,
  }) = _KdsState;

  const KdsState._();

  bool get isLoading => status == KdsStateStatus.loading;
  bool get hasError => status == KdsStateStatus.error;
  bool get isEmpty => orders.isEmpty && status == KdsStateStatus.success;

  List<OrderModel> get pendingOrders =>
      orders.where((o) => o.status == OrderStatus.pending).toList();

  List<OrderModel> get confirmedOrders =>
      orders.where((o) => o.status == OrderStatus.confirmed).toList();

  List<OrderModel> get inPreparationOrders =>
      orders.where((o) => o.status == OrderStatus.inPreparation).toList();

  List<OrderModel> get readyOrders =>
      orders.where((o) => o.status == OrderStatus.ready).toList();
}
