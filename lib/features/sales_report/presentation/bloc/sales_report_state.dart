import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:restotrack_app/features/orders/data/models/order_model.dart';
import 'package:restotrack_app/features/sales_report/data/repositories/sales_report_repository.dart';
import 'package:restotrack_app/features/sales_report/presentation/bloc/sales_report_event.dart';

part 'sales_report_state.freezed.dart';

enum SalesReportStateStatus { initial, loading, success, error }

@freezed
class SalesReportState with _$SalesReportState {
  const SalesReportState._();

  const factory SalesReportState({
    @Default([]) List<OrderModel> orders,
    @Default(SalesReportStateStatus.initial) SalesReportStateStatus status,
    @Default(SalesReportFilterType.today) SalesReportFilterType filterType,
    DateTime? startDate,
    DateTime? endDate,
    String? errorMessage,
  }) = _SalesReportState;

  bool get isLoading => status == SalesReportStateStatus.loading;
  bool get hasError => status == SalesReportStateStatus.error;

  SalesReportStats get stats {
    final totalSales = orders.fold<double>(0, (sum, o) => sum + o.total);
    final count = orders.length;
    return SalesReportStats(
      totalSales: totalSales,
      orderCount: count,
      averageOrderValue: count > 0 ? totalSales / count : 0,
    );
  }
}
