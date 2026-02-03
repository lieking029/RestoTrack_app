import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restotrack_app/features/orders/data/repositories/order_repository.dart';
import 'package:restotrack_app/features/orders/presentation/bloc/order_event.dart';
import 'package:restotrack_app/features/orders/presentation/bloc/order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc({required OrderRepository orderRepository})
      : _orderRepository = orderRepository,
        super(const OrderState()) {
    on<OrderLoadOrders>(_onLoadOrders);
    on<OrderRefreshOrders>(_onRefreshOrders);
    on<OrderLoadOrder>(_onLoadOrder);
    on<OrderCancelOrder>(_onCancelOrder);
    on<OrderCompleteOrder>(_onCompleteOrder);
    on<OrderClearError>(_onClearError);
  }

  final OrderRepository _orderRepository;

  Future<void> _onLoadOrders(
      OrderLoadOrders event,
      Emitter<OrderState> emit,
      ) async {
    emit(
      state.copyWith(
        status: OrderStateStatus.loading,
        filterStatus: event.status,
        errorMessage: null,
      ),
    );

    try {
      final orders = await _orderRepository.getMyOrders(status: event.status);
      emit(
        state.copyWith(
          status: OrderStateStatus.success,
          orders: orders,
        ),
      );
    } catch (e, stackTrace) {
      emit(
        state.copyWith(
          status: OrderStateStatus.error,
          errorMessage: 'Failed to load orders',
        ),
      );
    }
  }

  Future<void> _onRefreshOrders(
    OrderRefreshOrders event,
    Emitter<OrderState> emit,
  ) async {
    try {
      final orders =
          await _orderRepository.getMyOrders(status: state.filterStatus);
      emit(state.copyWith(
        status: OrderStateStatus.success,
        orders: orders,
        errorMessage: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: OrderStateStatus.error,
        errorMessage: 'Failed to refresh orders',
      ));
    }
  }

  Future<void> _onLoadOrder(
    OrderLoadOrder event,
    Emitter<OrderState> emit,
  ) async {
    try {
      final order = await _orderRepository.getOrder(event.id);
      emit(state.copyWith(selectedOrder: order));
    } catch (e) {
      emit(state.copyWith(
        errorMessage: 'Failed to load order details',
      ));
    }
  }

  Future<void> _onCancelOrder(
    OrderCancelOrder event,
    Emitter<OrderState> emit,
  ) async {
    emit(state.copyWith(isUpdating: true, errorMessage: null));

    try {
      final updatedOrder = await _orderRepository.cancelOrder(
        event.id,
        reason: event.reason,
      );

      // Update order in the list
      final updatedOrders = state.orders.map((order) {
        return order.id == event.id ? updatedOrder : order;
      }).toList();

      emit(state.copyWith(
        isUpdating: false,
        orders: updatedOrders,
      ));
    } catch (e) {
      emit(state.copyWith(
        isUpdating: false,
        errorMessage: 'Failed to cancel order',
      ));
    }
  }

  Future<void> _onCompleteOrder(
    OrderCompleteOrder event,
    Emitter<OrderState> emit,
  ) async {
    emit(state.copyWith(isUpdating: true, errorMessage: null));

    try {
      final updatedOrder = await _orderRepository.completeOrder(event.id);

      // Update order in the list
      final updatedOrders = state.orders.map((order) {
        return order.id == event.id ? updatedOrder : order;
      }).toList();

      emit(state.copyWith(
        isUpdating: false,
        orders: updatedOrders,
      ));
    } catch (e) {
      emit(state.copyWith(
        isUpdating: false,
        errorMessage: 'Failed to complete order',
      ));
    }
  }

  void _onClearError(
    OrderClearError event,
    Emitter<OrderState> emit,
  ) {
    emit(state.copyWith(errorMessage: null));
  }
}
