import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../menu/data/models/menu_model.dart';

part 'cart_model.freezed.dart';
part 'cart_model.g.dart';

/// Cart item for building an order locally
@freezed
class CartItemModel with _$CartItemModel {
  const CartItemModel._();

  const factory CartItemModel({
    required String menuId,
    required String name,
    required double unitPrice,
    required int quantity,
    String? notes,
  }) = _CartItemModel;

  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(json);

  /// Create from menu item
  factory CartItemModel.fromMenu(MenuModel menu, {int quantity = 1}) {
    return CartItemModel(
      menuId: menu.id,
      name: menu.name,
      unitPrice: menu.price,
      quantity: quantity,
    );
  }

  double get total => unitPrice * quantity;

  CartItemModel increment() => copyWith(quantity: quantity + 1);

  CartItemModel decrement() => quantity > 1
      ? copyWith(quantity: quantity - 1)
      : this;

  /// Convert to API request format
  Map<String, dynamic> toRequest() => {
    'menu_id': menuId,
    'quantity': quantity,
    if (notes != null) 'notes': notes,
  };
}

/// Cart state for order taking
@freezed
class CartModel with _$CartModel {
  const CartModel._();

  const factory CartModel({
    @Default([]) List<CartItemModel> items,
  }) = _CartModel;

  factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);

  bool get isEmpty => items.isEmpty;
  bool get isNotEmpty => items.isNotEmpty;

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);
  int get uniqueItemCount => items.length;

  double get subtotal => items.fold(0, (sum, item) => sum + item.total);
  double get total => subtotal;

  /// Check if menu item is in cart
  bool containsMenu(String menuId) =>
      items.any((item) => item.menuId == menuId);

  /// Get cart item by menu ID
  CartItemModel? getItemByMenuId(String menuId) {
    try {
      return items.firstWhere((item) => item.menuId == menuId);
    } catch (_) {
      return null;
    }
  }

  /// Get quantity of a menu item in cart
  int getQuantity(String menuId) {
    final item = getItemByMenuId(menuId);
    return item?.quantity ?? 0;
  }

  /// Add item to cart
  CartModel addItem(CartItemModel newItem) {
    final existingIndex = items.indexWhere((i) => i.menuId == newItem.menuId);

    if (existingIndex >= 0) {
      // Update existing item quantity
      final updatedItems = [...items];
      final existing = updatedItems[existingIndex];
      updatedItems[existingIndex] = existing.copyWith(
        quantity: existing.quantity + newItem.quantity,
      );
      return copyWith(items: updatedItems);
    } else {
      // Add new item
      return copyWith(items: [...items, newItem]);
    }
  }

  /// Add menu item to cart
  CartModel addMenu(MenuModel menu, {int quantity = 1}) {
    return addItem(CartItemModel.fromMenu(menu, quantity: quantity));
  }

  CartModel removeItem(String menuId) {
    return copyWith(
      items: items.where((item) => item.menuId != menuId).toList(),
    );
  }

  CartModel updateQuantity(String menuId, int quantity) {
    if (quantity <= 0) {
      return removeItem(menuId);
    }

    final updatedItems = items.map((item) {
      if (item.menuId == menuId) {
        return item.copyWith(quantity: quantity);
      }
      return item;
    }).toList();

    return copyWith(items: updatedItems);
  }

  CartModel incrementItem(String menuId) {
    final updatedItems = items.map((item) {
      if (item.menuId == menuId) {
        return item.increment();
      }
      return item;
    }).toList();

    return copyWith(items: updatedItems);
  }

  CartModel decrementItem(String menuId) {
    final item = getItemByMenuId(menuId);
    if (item == null) return this;

    if (item.quantity <= 1) {
      return removeItem(menuId);
    }

    final updatedItems = items.map((i) {
      if (i.menuId == menuId) {
        return i.decrement();
      }
      return i;
    }).toList();

    return copyWith(items: updatedItems);
  }

  CartModel updateNotes(String menuId, String? notes) {
    final updatedItems = items.map((item) {
      if (item.menuId == menuId) {
        return item.copyWith(notes: notes);
      }
      return item;
    }).toList();

    return copyWith(items: updatedItems);
  }

  CartModel clear() => copyWith(items: []);

  Map<String, dynamic> toRequest() => {
    'items': items.map((item) => item.toRequest()).toList(),
  };
}