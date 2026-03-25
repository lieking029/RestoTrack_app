import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:restotrack_app/features/orders/data/models/cart_model.dart';
import 'package:restotrack_app/features/orders/data/models/order_model.dart';

part 'cart_state.freezed.dart';

enum CartStatus {
  initial,
  loading,
  success,
  submitting,
  submitted,
  error,
}

@freezed
class CartState with _$CartState {
  const CartState._();

  const factory CartState({
    @Default(CartModel()) CartModel cart,
    @Default(CartStatus.initial) CartStatus status,
    OrderModel? submittedOrder,
    String? errorMessage,
    String? editingOrderId,
  }) = _CartState;

  bool get isEmpty => cart.isEmpty;
  bool get isNotEmpty => cart.isNotEmpty;
  bool get isSubmitting => status == CartStatus.submitting;
  bool get isSubmitted => status == CartStatus.submitted;
  bool get hasError => status == CartStatus.error;

  int get itemCount => cart.itemCount;
  int get uniqueItemCount => cart.uniqueItemCount;
  double get subtotal => cart.subtotal;
  double get tax => cart.tax;
  double get total => cart.total;
}