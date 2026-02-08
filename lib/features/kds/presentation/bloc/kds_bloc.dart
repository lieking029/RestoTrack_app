import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restotrack_app/features/kds/data/repositories/kds_repository.dart';
import 'package:restotrack_app/features/kds/presentation/bloc/kds_event.dart';
import 'package:restotrack_app/features/kds/presentation/bloc/kds_state.dart';

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
          orders: orders,
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
          orders: orders,
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

  Future<void> _onUpdateOrderStatus(
    KdsUpdateOrderStatus event,
    Emitter<KdsState> emit,
  ) async {
    emit(
      state.copyWith(
        isUpdating: true,
        updatingOrderId: event.orderId,
        errorMessage: null,
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

      emit(
        state.copyWith(
          isUpdating: false,
          updatingOrderId: null,
          orders: updatedOrders,
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
    emit(state.copyWith(errorMessage: null));
  }
}
