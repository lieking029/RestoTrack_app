import 'package:equatable/equatable.dart';

enum SalesReportFilterType { today, thisWeek, thisMonth, custom }

abstract class SalesReportEvent extends Equatable {
  const SalesReportEvent();

  @override
  List<Object?> get props => [];
}

class SalesReportLoad extends SalesReportEvent {
  const SalesReportLoad({this.startDate, this.endDate});

  final DateTime? startDate;
  final DateTime? endDate;

  @override
  List<Object?> get props => [startDate, endDate];
}

class SalesReportFilterChanged extends SalesReportEvent {
  const SalesReportFilterChanged({required this.filterType});

  final SalesReportFilterType filterType;

  @override
  List<Object?> get props => [filterType];
}

class SalesReportCustomDateRange extends SalesReportEvent {
  const SalesReportCustomDateRange({
    required this.startDate,
    required this.endDate,
  });

  final DateTime startDate;
  final DateTime endDate;

  @override
  List<Object?> get props => [startDate, endDate];
}
