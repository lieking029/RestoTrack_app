import 'dart:async';

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
    on<CashierCreateOnlinePayment>(_onCreateOnlinePayment);
    on<CashierPollPaymentStatus>(_onPollPaymentStatus);
    on<CashierCancelOnlinePayment>(_onCancelOnlinePayment);
  }

  final CashierRepository _cashierRepository;
  Timer? _pollTimer;
  Timer? _pollTimeoutTimer;

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

  Future<void> _onCreateOnlinePayment(
    CashierCreateOnlinePayment event,
    Emitter<CashierState> emit,
  ) async {
    emit(
      state.copyWith(
        isProcessingPayment: true,
        onlinePaymentOrderId: event.orderId,
        errorMessage: null,
        checkoutUrl: null,
        checkoutSessionId: null,
      ),
    );

    try {
      final result = await _cashierRepository.createOnlinePayment(
        orderId: event.orderId,
      );
      emit(
        state.copyWith(
          isProcessingPayment: false,
          checkoutUrl: result['checkout_url'],
          checkoutSessionId: result['checkout_session_id'],
        ),
      );

      // Automatically start polling
      add(CashierPollPaymentStatus(orderId: event.orderId));
    } catch (e) {
      emit(
        state.copyWith(
          isProcessingPayment: false,
          onlinePaymentOrderId: null,
          errorMessage: 'Failed to create online payment session',
        ),
      );
    }
  }

  Future<void> _onPollPaymentStatus(
    CashierPollPaymentStatus event,
    Emitter<CashierState> emit,
  ) async {
    _cancelPolling();

    emit(state.copyWith(isPollingPayment: true));

    final completer = Completer<void>();

    _pollTimer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      try {
        final isPaid = await _cashierRepository.checkPaymentStatus(
          orderId: event.orderId,
        );
        if (isPaid) {
          _cancelPolling();

          final paidOrder = state.orders.firstWhere(
            (o) => o.id == event.orderId,
          );

          final orders = await _cashierRepository.getAllOrders();
          final stats = await _cashierRepository.getTodayStats();

          emit(
            state.copyWith(
              isPollingPayment: false,
              checkoutUrl: null,
              checkoutSessionId: null,
              onlinePaymentOrderId: null,
              orders: orders,
              stats: stats,
              lastCompletedOrder: paidOrder,
            ),
          );

          if (!completer.isCompleted) completer.complete();
        }
      } catch (_) {
        // Silently continue polling on error
      }
    });

    // Timeout after 10 minutes
    _pollTimeoutTimer = Timer(const Duration(minutes: 10), () {
      _cancelPolling();
      emit(
        state.copyWith(
          isPollingPayment: false,
          checkoutUrl: null,
          checkoutSessionId: null,
          onlinePaymentOrderId: null,
          errorMessage: 'Payment session timed out',
        ),
      );
      if (!completer.isCompleted) completer.complete();
    });

    return completer.future;
  }

  void _onCancelOnlinePayment(
    CashierCancelOnlinePayment event,
    Emitter<CashierState> emit,
  ) {
    _cancelPolling();
    emit(
      state.copyWith(
        isPollingPayment: false,
        checkoutUrl: null,
        checkoutSessionId: null,
        onlinePaymentOrderId: null,
      ),
    );
  }

  void _cancelPolling() {
    _pollTimer?.cancel();
    _pollTimer = null;
    _pollTimeoutTimer?.cancel();
    _pollTimeoutTimer = null;
  }

  @override
  Future<void> close() {
    _cancelPolling();
    return super.close();
  }
}
