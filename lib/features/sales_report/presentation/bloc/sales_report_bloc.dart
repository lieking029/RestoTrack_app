import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restotrack_app/features/sales_report/data/repositories/sales_report_repository.dart';
import 'package:restotrack_app/features/sales_report/presentation/bloc/sales_report_event.dart';
import 'package:restotrack_app/features/sales_report/presentation/bloc/sales_report_state.dart';

class SalesReportBloc extends Bloc<SalesReportEvent, SalesReportState> {
  SalesReportBloc({required SalesReportRepository salesReportRepository})
      : _repo = salesReportRepository,
        super(const SalesReportState()) {
    on<SalesReportLoad>(_onLoad);
    on<SalesReportFilterChanged>(_onFilterChanged);
    on<SalesReportCustomDateRange>(_onCustomDateRange);
  }

  final SalesReportRepository _repo;

  Future<void> _onLoad(
    SalesReportLoad event,
    Emitter<SalesReportState> emit,
  ) async {
    emit(state.copyWith(
      status: SalesReportStateStatus.loading,
      errorMessage: null,
    ));

    try {
      final orders = await _repo.getCompletedOrders(
        startDate: event.startDate ?? state.startDate,
        endDate: event.endDate ?? state.endDate,
      );
      emit(state.copyWith(
        status: SalesReportStateStatus.success,
        orders: orders,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: SalesReportStateStatus.error,
        errorMessage: 'Failed to load sales report',
      ));
    }
  }

  Future<void> _onFilterChanged(
    SalesReportFilterChanged event,
    Emitter<SalesReportState> emit,
  ) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    DateTime? start;
    DateTime? end;

    switch (event.filterType) {
      case SalesReportFilterType.today:
        start = today;
        end = today;
      case SalesReportFilterType.thisWeek:
        start = today.subtract(Duration(days: today.weekday - 1));
        end = today;
      case SalesReportFilterType.thisMonth:
        start = DateTime(now.year, now.month);
        end = today;
      case SalesReportFilterType.custom:
        emit(state.copyWith(filterType: event.filterType));
        return;
    }

    emit(state.copyWith(
      filterType: event.filterType,
      startDate: start,
      endDate: end,
    ));
    add(SalesReportLoad(startDate: start, endDate: end));
  }

  Future<void> _onCustomDateRange(
    SalesReportCustomDateRange event,
    Emitter<SalesReportState> emit,
  ) async {
    emit(state.copyWith(
      filterType: SalesReportFilterType.custom,
      startDate: event.startDate,
      endDate: event.endDate,
    ));
    add(SalesReportLoad(
      startDate: event.startDate,
      endDate: event.endDate,
    ));
  }
}
