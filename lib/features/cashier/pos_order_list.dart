import 'package:flutter/material.dart';
import 'package:restotrack_app/features/cashier/pos_payment.dart';

class PosOrderListPage extends StatefulWidget {
  const PosOrderListPage({super.key});

  @override
  State<PosOrderListPage> createState() => _PosOrderListPageState();
}

class _PosOrderListPageState extends State<PosOrderListPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = false;

  List<MockOrder> _readyOrders = [];
  List<MockOrder> _allOrders = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadOrders();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadOrders() async {
    setState(() => _isLoading = true);

    // TODO: Replace with actual API call
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      _readyOrders = _mockReadyOrders;
      _allOrders = _mockAllOrders;
      _isLoading = false;
    });
  }

  void _onOrderSelected(MockOrder order) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PosPaymentPage(order: order),
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
        elevation: 0,
        title: const Text('Point of Sale'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: _loadOrders,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.white,
          indicatorWeight: 3,
          labelColor: AppColors.white,
          unselectedLabelColor: AppColors.white.withOpacity(0.6),
          tabs: [
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.payments_rounded, size: 18),
                  const SizedBox(width: 8),
                  const Text('Ready to Pay'),
                  if (_readyOrders.isNotEmpty) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${_readyOrders.length}',
                        style: const TextStyle(
                          color: AppColors.primaryGreen,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.receipt_long_rounded, size: 18),
                  SizedBox(width: 8),
                  Text('All Orders'),
                ],
              ),
            ),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
        controller: _tabController,
        children: [
          _buildOrderList(_readyOrders, isReadyTab: true),
          _buildOrderList(_allOrders, isReadyTab: false),
        ],
      ),
    );
  }

  Widget _buildOrderList(List<MockOrder> orders, {required bool isReadyTab}) {
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isReadyTab
                  ? Icons.payments_outlined
                  : Icons.receipt_long_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              isReadyTab ? 'No orders ready for payment' : 'No orders yet',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isReadyTab
                  ? 'Orders will appear here when kitchen marks them ready'
                  : 'Orders will appear here once created',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[400],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadOrders,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return _OrderCard(
            order: order,
            onTap: order.status == 'ready' ? () => _onOrderSelected(order) : null,
          );
        },
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  const _OrderCard({
    required this.order,
    this.onTap,
  });

  final MockOrder order;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isReady = order.status == 'ready';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isReady ? AppColors.primaryGreen : AppColors.border,
          width: isReady ? 2 : 1,
        ),
        boxShadow: isReady
            ? [
          BoxShadow(
            color: AppColors.primaryGreen.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Header Row
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isReady
                            ? AppColors.primaryGreen.withOpacity(0.1)
                            : AppColors.background,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        order.type == 'Dine In'
                            ? Icons.restaurant_rounded
                            : Icons.takeout_dining_rounded,
                        color: isReady
                            ? AppColors.primaryGreen
                            : AppColors.textSecondary,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '#${order.orderNumber}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(width: 8),
                              _StatusBadge(status: order.status),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            order.type == 'Dine In'
                                ? 'Table ${order.tableNumber}'
                                : 'Takeout',
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '₱${order.total.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: AppColors.primaryGreen,
                          ),
                        ),
                        Text(
                          '${order.items.length} items',
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                // Divider
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Divider(height: 1, color: AppColors.border),
                ),

                // Items Preview
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        order.items.map((i) => '${i.quantity}x ${i.name}').join(', '),
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      order.time,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),

                // Action Button for Ready Orders
                if (isReady) ...[
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: onTap,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryGreen,
                        foregroundColor: AppColors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                      ),
                      icon: const Icon(Icons.payments_rounded, size: 18),
                      label: const Text(
                        'Process Payment',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final config = _getStatusConfig(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: config.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        config.label,
        style: TextStyle(
          color: config.color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  _StatusConfig _getStatusConfig(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return _StatusConfig('Pending', Colors.orange);
      case 'preparing':
        return _StatusConfig('Preparing', AppColors.purple);
      case 'ready':
        return _StatusConfig('Ready', AppColors.primaryGreen);
      case 'completed':
        return _StatusConfig('Paid', AppColors.success);
      case 'cancelled':
        return _StatusConfig('Cancelled', Colors.red);
      default:
        return _StatusConfig(status, Colors.grey);
    }
  }
}

class _StatusConfig {
  final String label;
  final Color color;

  const _StatusConfig(this.label, this.color);
}

// ============ MOCK DATA - Replace with your real models ============

class MockOrder {
  final String orderNumber;
  final String type;
  final String? tableNumber;
  final String serverName;
  final String status;
  final String time;
  final List<MockOrderItem> items;
  final double subtotal;
  final double tax;
  final double total;

  const MockOrder({
    required this.orderNumber,
    required this.type,
    this.tableNumber,
    required this.serverName,
    required this.status,
    required this.time,
    required this.items,
    required this.subtotal,
    required this.tax,
    required this.total,
  });
}

class MockOrderItem {
  final String name;
  final int quantity;
  final double price;
  final double total;
  final String? notes;

  const MockOrderItem({
    required this.name,
    required this.quantity,
    required this.price,
    required this.total,
    this.notes,
  });
}

// Ready orders (for payment)
final _mockReadyOrders = [
  MockOrder(
    orderNumber: '1248',
    type: 'Dine In',
    tableNumber: '3',
    serverName: 'Maria Santos',
    status: 'ready',
    time: '2 mins ago',
    items: const [
      MockOrderItem(name: 'Chicken Adobo', quantity: 2, price: 180, total: 360),
      MockOrderItem(name: 'Plain Rice', quantity: 2, price: 35, total: 70),
      MockOrderItem(name: 'Iced Tea', quantity: 2, price: 45, total: 90),
    ],
    subtotal: 520.00,
    tax: 62.40,
    total: 582.40,
  ),
  MockOrder(
    orderNumber: '1247',
    type: 'Takeout',
    serverName: 'Juan Dela Cruz',
    status: 'ready',
    time: '5 mins ago',
    items: const [
      MockOrderItem(name: 'Sinigang na Baboy', quantity: 1, price: 220, total: 220),
      MockOrderItem(name: 'Plain Rice', quantity: 3, price: 35, total: 105),
    ],
    subtotal: 325.00,
    tax: 39.00,
    total: 364.00,
  ),
  MockOrder(
    orderNumber: '1245',
    type: 'Dine In',
    tableNumber: '5',
    serverName: 'Maria Santos',
    status: 'ready',
    time: '8 mins ago',
    items: const [
      MockOrderItem(name: 'Chicken Adobo', quantity: 2, price: 180, total: 360),
      MockOrderItem(name: 'Sinigang na Baboy', quantity: 1, price: 220, total: 220),
      MockOrderItem(name: 'Plain Rice', quantity: 3, price: 35, total: 105),
      MockOrderItem(name: 'Halo-Halo', quantity: 2, price: 85, total: 170),
      MockOrderItem(name: 'Iced Tea', quantity: 3, price: 45, total: 135),
    ],
    subtotal: 990.00,
    tax: 118.80,
    total: 1108.80,
  ),
];

// All orders (mixed statuses)
final _mockAllOrders = [
  ..._mockReadyOrders,
  MockOrder(
    orderNumber: '1249',
    type: 'Dine In',
    tableNumber: '7',
    serverName: 'Ana Reyes',
    status: 'preparing',
    time: '1 min ago',
    items: const [
      MockOrderItem(name: 'Kare-Kare', quantity: 1, price: 280, total: 280),
      MockOrderItem(name: 'Plain Rice', quantity: 2, price: 35, total: 70),
    ],
    subtotal: 350.00,
    tax: 42.00,
    total: 392.00,
  ),
  MockOrder(
    orderNumber: '1246',
    type: 'Dine In',
    tableNumber: '2',
    serverName: 'Juan Dela Cruz',
    status: 'completed',
    time: '15 mins ago',
    items: const [
      MockOrderItem(name: 'Lechon Kawali', quantity: 1, price: 200, total: 200),
      MockOrderItem(name: 'Plain Rice', quantity: 1, price: 35, total: 35),
    ],
    subtotal: 235.00,
    tax: 28.20,
    total: 263.20,
  ),
];