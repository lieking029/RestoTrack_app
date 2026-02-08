import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

class _KdsPageState extends State<KdsPage> {
  @override
  void initState() {
    super.initState();
    context.read<KdsBloc>().add(const KdsLoadOrders());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kitchen Display'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
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
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.restaurant_menu, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No orders in the kitchen',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<KdsBloc>().add(const KdsRefreshOrders());
            },
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth >= 900) {
                  return _buildThreeColumnLayout(context, state);
                } else {
                  return _buildScrollableLayout(context, state);
                }
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildThreeColumnLayout(BuildContext context, KdsState state) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _buildColumn(
            context: context,
            title: 'PAID',
            color: Colors.blue,
            orders: state.confirmedOrders,
            state: state,
          ),
        ),
        const VerticalDivider(width: 1),
        Expanded(
          child: _buildColumn(
            context: context,
            title: 'IN PREPARATION',
            color: Colors.purple,
            orders: state.inPreparationOrders,
            state: state,
          ),
        ),
        const VerticalDivider(width: 1),
        Expanded(
          child: _buildColumn(
            context: context,
            title: 'READY',
            color: Colors.green,
            orders: state.readyOrders,
            state: state,
          ),
        ),
      ],
    );
  }

  Widget _buildScrollableLayout(BuildContext context, KdsState state) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 320,
            child: _buildColumn(
              context: context,
              title: 'PAID',
              color: Colors.blue,
              orders: state.confirmedOrders,
              state: state,
            ),
          ),
          const VerticalDivider(width: 1),
          SizedBox(
            width: 320,
            child: _buildColumn(
              context: context,
              title: 'IN PREPARATION',
              color: Colors.purple,
              orders: state.inPreparationOrders,
              state: state,
            ),
          ),
          const VerticalDivider(width: 1),
          SizedBox(
            width: 320,
            child: _buildColumn(
              context: context,
              title: 'READY',
              color: Colors.green,
              orders: state.readyOrders,
              state: state,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColumn({
    required BuildContext context,
    required String title,
    required Color color,
    required List<OrderModel> orders,
    required KdsState state,
  }) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          color: color,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${orders.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: orders.isEmpty
              ? Center(
                  child: Text(
                    'No orders',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    final isUpdating = state.isUpdating &&
                        state.updatingOrderId == order.id;
                    return KdsOrderCard(
                      order: order,
                      isUpdating: isUpdating,
                      onStatusUpdate: _getStatusUpdateHandler(order),
                    );
                  },
                ),
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
