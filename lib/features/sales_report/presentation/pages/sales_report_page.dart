import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import 'package:restotrack_app/core/theme/app_theme.dart';
import 'package:restotrack_app/features/orders/data/models/order_model.dart';
import 'package:restotrack_app/features/sales_report/data/services/sales_report_export_service.dart';
import 'package:restotrack_app/features/sales_report/presentation/bloc/sales_report_bloc.dart';
import 'package:restotrack_app/features/sales_report/presentation/bloc/sales_report_event.dart';
import 'package:restotrack_app/features/sales_report/presentation/bloc/sales_report_state.dart';

class SalesReportPage extends StatefulWidget {
  const SalesReportPage({super.key});

  @override
  State<SalesReportPage> createState() => _SalesReportPageState();
}

class _SalesReportPageState extends State<SalesReportPage> {
  @override
  void initState() {
    super.initState();
    context.read<SalesReportBloc>().add(
          const SalesReportFilterChanged(
            filterType: SalesReportFilterType.today,
          ),
        );
  }

  Future<void> _selectCustomDateRange() async {
    final now = DateTime.now();
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(now.year - 1),
      lastDate: now,
      initialDateRange: DateTimeRange(
        start: now.subtract(const Duration(days: 7)),
        end: now,
      ),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryGreen,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && mounted) {
      context.read<SalesReportBloc>().add(
            SalesReportCustomDateRange(
              startDate: picked.start,
              endDate: picked.end,
            ),
          );
    }
  }

  Future<void> _exportPdf(SalesReportState state) async {
    if (state.orders.isEmpty || state.startDate == null || state.endDate == null) {
      return;
    }

    try {
      final pdfBytes = await SalesReportExportService.generatePdf(
        orders: state.orders,
        stats: state.stats,
        startDate: state.startDate!,
        endDate: state.endDate!,
      );
      await Printing.layoutPdf(
        onLayout: (_) => pdfBytes,
        name: 'SalesReport_${DateFormat('yyyyMMdd').format(DateTime.now())}',
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to generate PDF'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
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
          'Sales Report',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          BlocBuilder<SalesReportBloc, SalesReportState>(
            builder: (context, state) {
              final hasData = state.orders.isNotEmpty && !state.isLoading;
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: hasData ? () => _exportPdf(state) : null,
                    icon: const Icon(Icons.picture_as_pdf_rounded),
                    tooltip: 'Export PDF',
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: BlocConsumer<SalesReportBloc, SalesReportState>(
        listener: (context, state) {
          if (state.hasError && state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<SalesReportBloc>().add(
                    SalesReportLoad(
                      startDate: state.startDate,
                      endDate: state.endDate,
                    ),
                  );
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFilterChips(state),
                  _buildDateRangeLabel(state),
                  _buildSummaryCards(state),
                  _buildOrderList(state),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFilterChips(SalesReportState state) {
    final filters = [
      (SalesReportFilterType.today, 'Today'),
      (SalesReportFilterType.thisWeek, 'This Week'),
      (SalesReportFilterType.thisMonth, 'This Month'),
      (SalesReportFilterType.custom, 'Custom'),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Wrap(
        spacing: 8,
        children: filters.map((filter) {
          final isSelected = state.filterType == filter.$1;
          return ChoiceChip(
            label: Text(filter.$2),
            selected: isSelected,
            selectedColor: AppColors.primaryGreen,
            labelStyle: TextStyle(
              color: isSelected ? AppColors.white : AppColors.textSecondary,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              fontSize: 13,
            ),
            backgroundColor: AppColors.white,
            side: BorderSide(
              color: isSelected ? AppColors.primaryGreen : AppColors.border,
            ),
            onSelected: (_) {
              if (filter.$1 == SalesReportFilterType.custom) {
                _selectCustomDateRange();
              } else {
                context.read<SalesReportBloc>().add(
                      SalesReportFilterChanged(filterType: filter.$1),
                    );
              }
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDateRangeLabel(SalesReportState state) {
    if (state.startDate == null || state.endDate == null) {
      return const SizedBox.shrink();
    }

    final dateFormat = DateFormat('MMM dd, yyyy');
    final startStr = dateFormat.format(state.startDate!);
    final endStr = dateFormat.format(state.endDate!);
    final label = startStr == endStr ? startStr : '$startStr - $endStr';

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Text(
        label,
        style: const TextStyle(
          color: AppColors.textSecondary,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildSummaryCards(SalesReportState state) {
    final stats = state.stats;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: AppColors.purpleGradient,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Sales',
                    style: TextStyle(
                      color: AppColors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  state.isLoading
                      ? const SizedBox(
                          height: 34,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: AppColors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          '\u20B1${stats.totalSales.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _SummaryCard(
              icon: Icons.receipt_long_rounded,
              iconColor: AppColors.purple,
              label: 'Orders',
              value: state.isLoading ? '...' : '${stats.orderCount}',
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _SummaryCard(
              icon: Icons.trending_up_rounded,
              iconColor: AppColors.primaryGreen,
              label: 'Avg. Order',
              value: state.isLoading
                  ? '...'
                  : '\u20B1${stats.averageOrderValue.toStringAsFixed(2)}',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderList(SalesReportState state) {
    if (state.isLoading) {
      return const Padding(
        padding: EdgeInsets.all(32),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (state.orders.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Column(
            children: [
              Icon(Icons.receipt_long_outlined, size: 64, color: Colors.grey[400]),
              const SizedBox(height: 16),
              Text(
                'No completed orders',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              const SizedBox(height: 4),
              Text(
                'Try a different date range',
                style: TextStyle(fontSize: 13, color: Colors.grey[500]),
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transactions (${state.orders.length})',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 12,
              childAspectRatio: 4.0,
            ),
            itemCount: state.orders.length,
            itemBuilder: (context, index) {
              return _OrderCard(order: state.orders[index]);
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  const _OrderCard({required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final timeFormat = DateFormat('hh:mm a');
    final timeStr = order.createdAt != null
        ? timeFormat.format(order.createdAt!)
        : '';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primaryGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.check_circle_rounded,
              color: AppColors.primaryGreen,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '#${order.orderNumber}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${order.itemCount} items \u2022 $timeStr',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '\u20B1${order.total.toStringAsFixed(2)}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: AppColors.primaryGreen,
            ),
          ),
        ],
      ),
    );
  }
}
