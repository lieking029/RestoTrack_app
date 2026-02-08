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
