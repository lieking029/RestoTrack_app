import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restotrack_app/features/kds/data/repositories/kds_repository.dart';
import 'package:restotrack_app/features/kds/presentation/bloc/kds_event.dart';
import 'package:restotrack_app/features/kds/presentation/bloc/kds_state.dart';
import 'package:restotrack_app/features/orders/data/models/order_model.dart';

class KdsBloc extends Bloc<KdsEvent, KdsState> {
  KdsBloc({required KdsRepository kdsRepository})
      : _kdsRepository = kdsRepository,
        super(const KdsState()) {
    on<KdsLoadOrders>(_onLoadOrders);
    on<KdsRefreshOrders>(_onRefreshOrders);
    on<KdsUpdateOrderStatus>(_onUpdateOrderStatus);
    on<KdsClearError>(_onClearError);
  }

  final KdsRepository _kdsRepository;

  Future<void> _onLoadOrders(
    KdsLoadOrders event,
    Emitter<KdsState> emit,
  ) async {
    emit(
      state.copyWith(
        status: KdsStateStatus.loading,
        errorMessage: null,
      ),
    );

    try {
      final orders = await _kdsRepository.getKitchenOrders();
      emit(
        state.copyWith(
          status: KdsStateStatus.success,
          orders: _mergeWithReadyOrders(orders),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: KdsStateStatus.error,
          errorMessage: 'Failed to load orders',
        ),
      );
    }
  }

  Future<void> _onRefreshOrders(
    KdsRefreshOrders event,
    Emitter<KdsState> emit,
  ) async {
    try {
      final orders = await _kdsRepository.getKitchenOrders();
      emit(
        state.copyWith(
          status: KdsStateStatus.success,
          orders: _mergeWithReadyOrders(orders),
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: KdsStateStatus.error,
          errorMessage: 'Failed to refresh orders',
        ),
      );
    }
  }

  /// The API may not return ready orders since the kitchen is "done" with them.
  /// Preserve ready orders from the current state so they remain visible in the
  /// Ready tab until the next full load.
  List<OrderModel> _mergeWithReadyOrders(List<OrderModel> freshOrders) {
    final freshIds = freshOrders.map((o) => o.id).toSet();
    final retainedReady = state.orders
        .where((o) =>
            o.status == OrderStatus.ready && !freshIds.contains(o.id))
        .toList();
    return [...freshOrders, ...retainedReady];
  }

  Future<void> _onUpdateOrderStatus(
    KdsUpdateOrderStatus event,
    Emitter<KdsState> emit,
  ) async {
    emit(
      state.copyWith(
        isUpdating: true,
        updatingOrderId: event.orderId,
        errorMessage: null,
        successMessage: null,
      ),
    );

    try {
      final updatedOrder = await _kdsRepository.updateOrderStatus(
        event.orderId,
        event.newStatus,
      );

      final updatedOrders = state.orders.map((order) {
        return order.id == event.orderId ? updatedOrder : order;
      }).toList();

      final statusLabel = switch (event.newStatus) {
        OrderStatus.inPreparation => 'Order is now being prepared',
        OrderStatus.ready => 'Order marked as ready',
        _ => 'Order status updated',
      };

      emit(
        state.copyWith(
          isUpdating: false,
          updatingOrderId: null,
          orders: updatedOrders,
          successMessage: statusLabel,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isUpdating: false,
          updatingOrderId: null,
          errorMessage: 'Failed to update order status',
        ),
      );
    }
  }

  void _onClearError(
    KdsClearError event,
    Emitter<KdsState> emit,
  ) {
    emit(state.copyWith(errorMessage: null, successMessage: null));
  }
}
