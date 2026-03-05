import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restotrack_app/features/cashier/data/repositories/cashier_repository.dart';
import 'package:restotrack_app/features/cashier/presentation/bloc/cashier_event.dart';
import 'package:restotrack_app/features/cashier/presentation/bloc/cashier_state.dart';

class CashierBloc extends Bloc<CashierEvent, CashierState> {
  CashierBloc({required CashierRepository cashierRepository})
      : _cashierRepository = cashierRepository,
        super(const CashierState()) {
    on<CashierLoadOrders>(_onLoadOrders);
    on<CashierRefreshOrders>(_onRefreshOrders);
    on<CashierProcessPayment>(_onProcessPayment);
    on<CashierLoadStats>(_onLoadStats);
    on<CashierClearError>(_onClearError);
  }

  final CashierRepository _cashierRepository;

  Future<void> _onLoadOrders(
    CashierLoadOrders event,
    Emitter<CashierState> emit,
  ) async {
    emit(
      state.copyWith(
        status: CashierStateStatus.loading,
        errorMessage: null,
      ),
    );

    try {
      final orders = await _cashierRepository.getAllOrders();
      final stats = await _cashierRepository.getTodayStats();
      emit(
        state.copyWith(
          status: CashierStateStatus.success,
          orders: orders,
          stats: stats,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CashierStateStatus.error,
          errorMessage: 'Failed to load orders',
        ),
      );
    }
  }

  Future<void> _onRefreshOrders(
    CashierRefreshOrders event,
    Emitter<CashierState> emit,
  ) async {
    try {
      final orders = await _cashierRepository.getAllOrders();
      final stats = await _cashierRepository.getTodayStats();
      emit(
        state.copyWith(
          status: CashierStateStatus.success,
          orders: orders,
          stats: stats,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CashierStateStatus.error,
          errorMessage: 'Failed to refresh orders',
        ),
      );
    }
  }

  Future<void> _onProcessPayment(
    CashierProcessPayment event,
    Emitter<CashierState> emit,
  ) async {
    emit(
      state.copyWith(
        isProcessingPayment: true,
        processingOrderId: event.orderId,
        errorMessage: null,
      ),
    );

    try {
      final paidOrder = state.orders.firstWhere((o) => o.id == event.orderId);

      await _cashierRepository.processPayment(
        orderId: event.orderId,
        amountPaid: event.amountPaid,
        paymentMethod: event.paymentMethod,
      );

      // Refresh orders and stats from backend
      final orders = await _cashierRepository.getAllOrders();
      final stats = await _cashierRepository.getTodayStats();

      emit(
        state.copyWith(
          isProcessingPayment: false,
          processingOrderId: null,
          orders: orders,
          stats: stats,
          lastCompletedOrder: paidOrder,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isProcessingPayment: false,
          processingOrderId: null,
          errorMessage: 'Failed to process payment',
        ),
      );
    }
  }

  Future<void> _onLoadStats(
    CashierLoadStats event,
    Emitter<CashierState> emit,
  ) async {
    try {
      final stats = await _cashierRepository.getTodayStats();
      emit(state.copyWith(stats: stats));
    } catch (e) {
      // Silently fail for stats
    }
  }

  void _onClearError(
    CashierClearError event,
    Emitter<CashierState> emit,
  ) {
    emit(state.copyWith(errorMessage: null));
  }
}
