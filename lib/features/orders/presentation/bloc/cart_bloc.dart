import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restotrack_app/features/orders/data/models/cart_model.dart';
import 'package:restotrack_app/features/orders/data/models/order_model.dart';
import 'package:restotrack_app/features/orders/data/repositories/order_repository.dart';
import 'package:restotrack_app/features/orders/presentation/bloc/cart_event.dart';
import 'package:restotrack_app/features/orders/presentation/bloc/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc({required OrderRepository orderRepository})
      : _orderRepository = orderRepository,
        super(const CartState()) {
    on<CartAddItem>(_onAddItem);
    on<CartRemoveItem>(_onRemoveItem);
    on<CartIncrementItem>(_onIncrementItem);
    on<CartDecrementItem>(_onDecrementItem);
    on<CartUpdateQuantity>(_onUpdateQuantity);
    on<CartUpdateNotes>(_onUpdateNotes);
    on<CartClear>(_onClear);
    on<CartSubmitOrder>(_onSubmitOrder);
    on<CartLoadFromOrder>(_onLoadFromOrder);
    on<CartEditOrder>(_onEditOrder);
  }

  final OrderRepository _orderRepository;

  void _onAddItem(CartAddItem event, Emitter<CartState> emit) {
    final quantity = event.quantity ?? 1;
    final updatedCart = state.cart.addMenu(event.menu, quantity: quantity);
    emit(state.copyWith(
      cart: updatedCart,
      status: CartStatus.success,
      errorMessage: null,
    ));
  }

  void _onRemoveItem(CartRemoveItem event, Emitter<CartState> emit) {
    final updatedCart = state.cart.removeItem(event.menuId);
    emit(state.copyWith(
      cart: updatedCart,
      status: CartStatus.success,
    ));
  }

  void _onIncrementItem(CartIncrementItem event, Emitter<CartState> emit) {
    final updatedCart = state.cart.incrementItem(event.menuId);
    emit(state.copyWith(cart: updatedCart));
  }

  void _onDecrementItem(CartDecrementItem event, Emitter<CartState> emit) {
    final updatedCart = state.cart.decrementItem(event.menuId);
    emit(state.copyWith(cart: updatedCart));
  }

  void _onUpdateQuantity(CartUpdateQuantity event, Emitter<CartState> emit) {
    final updatedCart = state.cart.updateQuantity(event.menuId, event.quantity);
    emit(state.copyWith(cart: updatedCart));
  }

  void _onUpdateNotes(CartUpdateNotes event, Emitter<CartState> emit) {
    final updatedCart = state.cart.updateNotes(event.menuId, event.notes);
    emit(state.copyWith(cart: updatedCart));
  }

  void _onClear(CartClear event, Emitter<CartState> emit) {
    emit(state.copyWith(
      cart: const CartModel(),
      status: CartStatus.initial,
      submittedOrder: null,
      errorMessage: null,
    ));
  }

  Future<void> _onSubmitOrder(
      CartSubmitOrder event,
      Emitter<CartState> emit,
      ) async {
    if (state.isEmpty) {
      emit(state.copyWith(
        status: CartStatus.error,
        errorMessage: 'Cart is empty',
      ));
      return;
    }

    emit(state.copyWith(status: CartStatus.submitting, errorMessage: null));

    try {
      final order = await _orderRepository.createOrder(state.cart);
      emit(state.copyWith(
        status: CartStatus.submitted,
        submittedOrder: order,
        cart: const CartModel(), // Clear cart after successful submission
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CartStatus.error,
        errorMessage: 'Failed to submit order. Please try again.',
      ));
    }
  }

  void _onLoadFromOrder(CartLoadFromOrder event, Emitter<CartState> emit) {
    final items = event.order.items.map((item) {
      return CartItemModel(
        menuId: item.menuId,
        name: item.name,
        unitPrice: item.unitPrice,
        quantity: item.quantity,
      );
    }).toList();

    emit(state.copyWith(
      cart: CartModel(items: items),
      status: CartStatus.success,
      editingOrderId: event.order.id,
      submittedOrder: null,
      errorMessage: null,
    ));
  }

  Future<void> _onEditOrder(
    CartEditOrder event,
    Emitter<CartState> emit,
  ) async {
    if (state.isEmpty) {
      emit(state.copyWith(
        status: CartStatus.error,
        errorMessage: 'Cart is empty',
      ));
      return;
    }

    emit(state.copyWith(status: CartStatus.submitting, errorMessage: null));

    try {
      final order = await _orderRepository.editOrder(event.orderId, state.cart);
      emit(state.copyWith(
        status: CartStatus.submitted,
        submittedOrder: order,
        cart: const CartModel(),
        editingOrderId: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CartStatus.error,
        errorMessage: 'Failed to update order. Please try again.',
      ));
    }
  }
}