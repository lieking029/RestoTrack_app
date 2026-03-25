import 'package:equatable/equatable.dart';
import 'package:restotrack_app/features/menu/data/models/menu_model.dart';
import 'package:restotrack_app/features/orders/data/models/order_model.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class CartAddItem extends CartEvent {
  const CartAddItem(this.menu, {this.quantity = 1});

  final MenuModel menu;
  final int quantity;

  @override
  List<Object?> get props => [menu, quantity];
}

class CartRemoveItem extends CartEvent {
  const CartRemoveItem(this.menuId);

  final String menuId;

  @override
  List<Object?> get props => [menuId];
}

class CartIncrementItem extends CartEvent {
  const CartIncrementItem(this.menuId);

  final String menuId;

  @override
  List<Object?> get props => [menuId];
}

class CartDecrementItem extends CartEvent {
  const CartDecrementItem(this.menuId);

  final String menuId;

  @override
  List<Object?> get props => [menuId];
}

class CartUpdateQuantity extends CartEvent {
  const CartUpdateQuantity(this.menuId, this.quantity);

  final String menuId;
  final int quantity;

  @override
  List<Object?> get props => [menuId, quantity];
}

class CartUpdateNotes extends CartEvent {
  const CartUpdateNotes(this.menuId, this.notes);

  final String menuId;
  final String? notes;

  @override
  List<Object?> get props => [menuId, notes];
}

class CartClear extends CartEvent {
  const CartClear();
}

class CartSubmitOrder extends CartEvent {
  const CartSubmitOrder();
}

class CartLoadFromOrder extends CartEvent {
  const CartLoadFromOrder(this.order);

  final OrderModel order;

  @override
  List<Object?> get props => [order];
}

class CartEditOrder extends CartEvent {
  const CartEditOrder(this.orderId);

  final String orderId;

  @override
  List<Object?> get props => [orderId];
}