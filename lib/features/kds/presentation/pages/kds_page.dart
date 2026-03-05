import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restotrack_app/core/theme/app_theme.dart';
import 'package:restotrack_app/features/kds/presentation/bloc/kds_bloc.dart';
import 'package:restotrack_app/features/kds/presentation/bloc/kds_event.dart';
import 'package:restotrack_app/features/kds/presentation/bloc/kds_state.dart';
import 'package:restotrack_app/features/kds/presentation/widgets/kds_order_card.dart';
import 'package:restotrack_app/features/orders/data/models/order_model.dart';

class KdsPage extends StatefulWidget {
  const KdsPage({super.key});

  @override
  State<KdsPage> createState() => _KdsPageState();
}

class _KdsPageState extends State<KdsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    context.read<KdsBloc>().add(const KdsLoadOrders());
    _refreshTimer = Timer.periodic(
      const Duration(seconds: 10),
      (_) => context.read<KdsBloc>().add(const KdsRefreshOrders()),
    );
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primaryGreen,
        foregroundColor: AppColors.white,
        centerTitle: true,
        title: const Text(
          'Kitchen Display',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              context.read<KdsBloc>().add(const KdsRefreshOrders());
            },
          ),
        ],
      ),
      body: BlocConsumer<KdsBloc, KdsState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: Colors.red,
                action: SnackBarAction(
                  label: 'Dismiss',
                  textColor: Colors.white,
                  onPressed: () {
                    context.read<KdsBloc>().add(const KdsClearError());
                  },
                ),
              ),
            );
          }
          if (state.successMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.successMessage!),
                backgroundColor: AppColors.primaryGreen,
              ),
            );
            context.read<KdsBloc>().add(const KdsClearError());
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              _buildStatsRow(state),
              _buildTabBar(),
              Expanded(child: _buildTabContent(state)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatsRow(KdsState state) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Expanded(
            child: _StatCard(
              icon: Icons.payment_rounded,
              iconColor: Colors.blue,
              label: 'Paid',
              value: '${state.confirmedOrders.length}',
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _StatCard(
              icon: Icons.restaurant_rounded,
              iconColor: AppColors.purple,
              label: 'Preparing',
              value: '${state.inPreparationOrders.length}',
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _StatCard(
              icon: Icons.check_circle_rounded,
              iconColor: AppColors.primaryGreen,
              label: 'Ready',
              value: '${state.readyOrders.length}',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: TabBar(
        controller: _tabController,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        indicator: BoxDecoration(
          color: AppColors.primaryGreen,
          borderRadius: BorderRadius.circular(10),
        ),
        labelColor: AppColors.white,
        unselectedLabelColor: AppColors.textSecondary,
        labelStyle:
            const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        unselectedLabelStyle:
            const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
        padding: const EdgeInsets.all(4),
        tabs: const [
          Tab(text: 'Paid'),
          Tab(text: 'Preparing'),
          Tab(text: 'Ready'),
        ],
      ),
    );
  }

  Widget _buildTabContent(KdsState state) {
    return TabBarView(
      controller: _tabController,
      children: [
        _OrderListView(
          orders: state.confirmedOrders,
          state: state,
          emptyMessage: 'No paid orders',
          emptyIcon: Icons.payment_outlined,
          onRefresh: () async {
            context.read<KdsBloc>().add(const KdsRefreshOrders());
          },
          onStatusUpdate: _getStatusUpdateHandler,
        ),
        _OrderListView(
          orders: state.inPreparationOrders,
          state: state,
          emptyMessage: 'No orders in preparation',
          emptyIcon: Icons.restaurant_outlined,
          onRefresh: () async {
            context.read<KdsBloc>().add(const KdsRefreshOrders());
          },
          onStatusUpdate: _getStatusUpdateHandler,
        ),
        _OrderListView(
          orders: state.readyOrders,
          state: state,
          emptyMessage: 'No orders ready',
          emptyIcon: Icons.check_circle_outline,
          onRefresh: () async {
            context.read<KdsBloc>().add(const KdsRefreshOrders());
          },
          onStatusUpdate: _getStatusUpdateHandler,
        ),
      ],
    );
  }

  VoidCallback? _getStatusUpdateHandler(OrderModel order) {
    final newStatus = switch (order.status) {
      OrderStatus.pending => null,
      OrderStatus.confirmed => OrderStatus.inPreparation,
      OrderStatus.inPreparation => OrderStatus.ready,
      OrderStatus.ready => null,
      OrderStatus.completed => null,
      OrderStatus.cancelled => null,
    };

    if (newStatus == null) return null;

    return () {
      context.read<KdsBloc>().add(
            KdsUpdateOrderStatus(
              orderId: order.id,
              newStatus: newStatus,
            ),
          );
    };
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderListView extends StatelessWidget {
  const _OrderListView({
    required this.orders,
    required this.state,
    required this.emptyMessage,
    required this.emptyIcon,
    required this.onRefresh,
    required this.onStatusUpdate,
  });

  final List<OrderModel> orders;
  final KdsState state;
  final String emptyMessage;
  final IconData emptyIcon;
  final Future<void> Function() onRefresh;
  final VoidCallback? Function(OrderModel order) onStatusUpdate;

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(emptyIcon, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              emptyMessage,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: GridView.builder(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.85,
        ),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          final isUpdating =
              state.isUpdating && state.updatingOrderId == order.id;
          return KdsOrderCard(
            order: order,
            isUpdating: isUpdating,
            onStatusUpdate: onStatusUpdate(order),
          );
        },
      ),
    );
  }
}
