import 'package:equatable/equatable.dart';

abstract class CashierEvent extends Equatable {
  const CashierEvent();

  @override
  List<Object?> get props => [];
}

class CashierLoadOrders extends CashierEvent {
  const CashierLoadOrders();
}

class CashierRefreshOrders extends CashierEvent {
  const CashierRefreshOrders();
}

class CashierProcessPayment extends CashierEvent {
  const CashierProcessPayment({
    required this.orderId,
    required this.amountPaid,
    this.paymentMethod = 'cash',
  });

  final String orderId;
  final double amountPaid;
  final String paymentMethod;

  @override
  List<Object?> get props => [orderId, amountPaid, paymentMethod];
}

class CashierLoadStats extends CashierEvent {
  const CashierLoadStats();
}

class CashierClearError extends CashierEvent {
  const CashierClearError();
}

class CashierCreateOnlinePayment extends CashierEvent {
  const CashierCreateOnlinePayment({required this.orderId});

  final String orderId;

  @override
  List<Object?> get props => [orderId];
}

class CashierPollPaymentStatus extends CashierEvent {
  const CashierPollPaymentStatus({required this.orderId});

  final String orderId;

  @override
  List<Object?> get props => [orderId];
}

class CashierCancelOnlinePayment extends CashierEvent {
  const CashierCancelOnlinePayment();
}
