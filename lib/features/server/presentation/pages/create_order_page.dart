import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:restotrack_app/core/theme/app_theme.dart';
import 'package:restotrack_app/features/menu/data/models/menu_model.dart';
import 'package:restotrack_app/features/menu/presentation/bloc/menu_bloc.dart';
import 'package:restotrack_app/features/menu/presentation/bloc/menu_event.dart';
import 'package:restotrack_app/features/menu/presentation/bloc/menu_state.dart';
import 'package:restotrack_app/features/orders/presentation/bloc/cart_bloc.dart';
import 'package:restotrack_app/features/orders/presentation/bloc/cart_event.dart';
import 'package:restotrack_app/features/orders/presentation/bloc/cart_state.dart';
import 'package:restotrack_app/features/server/presentation/pages/order_summary_page.dart';

class CreateOrderPage extends StatefulWidget {
  const CreateOrderPage({super.key});

  @override
  State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<MenuBloc>().add(const MenuLoadItems());
    context.read<MenuBloc>().add(const MenuLoadCategories());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _navigateToSummary() {
    final cartBloc = context.read<CartBloc>();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: cartBloc,
          child: const OrderSummaryPage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primaryGreen,
        foregroundColor: AppColors.white,
        title: const Text('New Order'),
        centerTitle: true,
        actions: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state.isEmpty) return const SizedBox.shrink();
              return TextButton(
                onPressed: () {
                  context.read<CartBloc>().add(const CartClear());
                },
                child: const Text(
                  'Clear',
                  style: TextStyle(color: AppColors.white),
                ),
              );
            },
          ),
        ],
      ),
      body: Row(
        children: [
          Expanded(
            flex: 65,
            child: Column(
              children: [
                _buildSearchBar(),
                _buildCategoryChips(),
                Expanded(child: _buildMenuGrid()),
              ],
            ),
          ),
          Expanded(
            flex: 35,
            child: _buildCartSidebar(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: AppColors.white,
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          context.read<MenuBloc>().add(MenuSearch(value));
        },
        decoration: InputDecoration(
          hintText: 'Search menu...',
          prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _searchController.clear();
              context.read<MenuBloc>().add(const MenuClearSearch());
            },
          )
              : null,
          filled: true,
          fillColor: AppColors.background,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildCategoryChips() {
    return BlocBuilder<MenuBloc, MenuState>(
      builder: (context, state) {
        if (state.categories.isEmpty) return const SizedBox.shrink();

        return Container(
          height: 50,
          color: AppColors.white,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: state.categories.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return _CategoryChip(
                  label: 'All',
                  isSelected: state.selectedCategoryId == null,
                  onTap: () {
                    context.read<MenuBloc>().add(const MenuSelectCategory(null));
                  },
                );
              }

              final category = state.categories[index - 1];
              return _CategoryChip(
                label: category.name,
                isSelected: state.selectedCategoryId == category.id,
                onTap: () {
                  context.read<MenuBloc>().add(MenuSelectCategory(category.id));
                },
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildMenuGrid() {
    return BlocBuilder<MenuBloc, MenuState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text(state.errorMessage ?? 'Failed to load menu'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<MenuBloc>().add(const MenuLoadItems());
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (state.displayItems.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.restaurant_menu, size: 64, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text(
                  'No menu items found',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ],
            ),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.85,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: state.displayItems.length,
          itemBuilder: (context, index) {
            final menu = state.displayItems[index];
            return _MenuItemCard(menu: menu);
          },
        );
      },
    );
  }

  Widget _buildCartSidebar() {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
            border: Border(
              left: BorderSide(color: AppColors.border),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.shopping_cart_rounded,
                        color: AppColors.primaryGreen, size: 20),
                    const SizedBox(width: 8),
                    const Text(
                      'Cart',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const Spacer(),
                    if (!state.isEmpty)
                      Text(
                        '${state.itemCount} items',
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                        ),
                      ),
                  ],
                ),
              ),
              const Divider(height: 1, color: AppColors.border),
              if (state.isEmpty)
                const Expanded(
                  child: Center(
                    child: Text(
                      'Add items to get started',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ),
                )
              else ...[
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(12),
                    itemCount: state.cart.items.length,
                    separatorBuilder: (_, __) =>
                        const Divider(height: 16, color: AppColors.border),
                    itemBuilder: (context, index) {
                      final item = state.cart.items[index];
                      return Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimary,
                                    fontSize: 13,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  '\u20B1${item.total.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    color: AppColors.primaryGreen,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          _QuantityControls(
                            quantity: item.quantity,
                            onIncrement: () {
                              context
                                  .read<CartBloc>()
                                  .add(CartIncrementItem(item.menuId));
                            },
                            onDecrement: () {
                              context
                                  .read<CartBloc>()
                                  .add(CartDecrementItem(item.menuId));
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const Divider(height: 1, color: AppColors.border),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Subtotal',
                              style: TextStyle(color: AppColors.textSecondary)),
                          Text(
                            '\u20B1${state.subtotal.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: AppColors.textPrimary),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Tax (12%)',
                              style: TextStyle(color: AppColors.textSecondary)),
                          Text(
                            '\u20B1${state.tax.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: AppColors.textPrimary),
                          ),
                        ],
                      ),
                      const Divider(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            '\u20B1${state.total.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: AppColors.primaryGreen,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _navigateToSummary,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryGreen,
                            foregroundColor: AppColors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Review Order',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              SizedBox(width: 4),
                              Icon(Icons.arrow_forward_rounded, size: 18),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryGreen : AppColors.background,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? AppColors.primaryGreen : AppColors.border,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? AppColors.white : AppColors.textSecondary,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuItemCard extends StatelessWidget {
  const _MenuItemCard({required this.menu});

  final MenuModel menu;

  @override
  Widget build(BuildContext context) {
    final isAvailable = menu.isAvailable;

    return BlocBuilder<CartBloc, CartState>(
      builder: (context, cartState) {
        final quantityInCart = cartState.cart.getQuantity(menu.id);
        final isInCart = quantityInCart > 0;

        return Opacity(
          opacity: isAvailable ? 1.0 : 0.6,
          child: Container(
            decoration: BoxDecoration(
              color: isAvailable ? AppColors.white : Colors.grey[100],
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: !isAvailable
                    ? Colors.grey[300]!
                    : isInCart
                        ? AppColors.primaryGreen
                        : AppColors.border,
                width: isInCart && isAvailable ? 2 : 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image with sold out badge
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(14),
                          ),
                        ),
                        child: menu.dishPicture != null
                            ? ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(14),
                                ),
                                child: ColorFiltered(
                                  colorFilter: isAvailable
                                      ? const ColorFilter.mode(
                                          Colors.transparent,
                                          BlendMode.multiply,
                                        )
                                      : const ColorFilter.mode(
                                          Colors.grey,
                                          BlendMode.saturation,
                                        ),
                                  child: Image.network(
                                    menu.dishPicture!,
                                    fit: BoxFit.cover,
                                    headers: const {
                                      'ngrok-skip-browser-warning': 'true',
                                    },
                                    errorBuilder: (_, __, ___) =>
                                        const _PlaceholderIcon(),
                                  ),
                                ),
                              )
                            : const _PlaceholderIcon(),
                      ),
                      // Sold Out badge
                      if (!isAvailable)
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'Sold Out',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                // Details
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        menu.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: isAvailable
                              ? AppColors.textPrimary
                              : Colors.grey,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '₱${menu.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: isAvailable
                                    ? AppColors.primaryGreen
                                    : Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (!isAvailable)
                            const SizedBox.shrink()
                          else if (isInCart)
                            _QuantityControls(
                              quantity: quantityInCart,
                              onIncrement: () {
                                context
                                    .read<CartBloc>()
                                    .add(CartIncrementItem(menu.id));
                              },
                              onDecrement: () {
                                context
                                    .read<CartBloc>()
                                    .add(CartDecrementItem(menu.id));
                              },
                            )
                          else
                            _AddButton(
                              onTap: () {
                                context
                                    .read<CartBloc>()
                                    .add(CartAddItem(menu));
                              },
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PlaceholderIcon extends StatelessWidget {
  const _PlaceholderIcon();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(
        Icons.restaurant_rounded,
        size: 40,
        color: Colors.grey[400],
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  const _AddButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: AppColors.primaryGreen,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(
          Icons.add_rounded,
          color: AppColors.white,
          size: 20,
        ),
      ),
    );
  }
}

class _QuantityControls extends StatelessWidget {
  const _QuantityControls({
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryGreen.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: onDecrement,
            child: const Padding(
              padding: EdgeInsets.all(4),
              child: Icon(
                Icons.remove_rounded,
                color: AppColors.primaryGreen,
                size: 18,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              '$quantity',
              style: const TextStyle(
                color: AppColors.primaryGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          InkWell(
            onTap: onIncrement,
            child: const Padding(
              padding: EdgeInsets.all(4),
              child: Icon(
                Icons.add_rounded,
                color: AppColors.primaryGreen,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}